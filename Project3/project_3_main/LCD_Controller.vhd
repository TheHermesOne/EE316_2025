LIBRARY ieee;
   USE ieee.std_logic_1164.all;

	entity LCD_Controller is 
		port(
			reset			: in std_logic := '0'; 
			iClk			: in std_logic; 
			state			: in std_logic_vector(3 downto 0);
--			Clock_on        : in std_logic;
			Next_data       : in std_logic;
            LCD_DATA		: out std_logic_vector(11 downto 0)

			);
	END LCD_Controller;
	
architecture structural of LCD_Controller is

--- SIGNALS FOR LCD TIMING ---
 constant iCLK_Lim                   : integer := 250000; --5ms   
 signal byte_Cnt                     : integer range 0 to 39 := 0;
 signal iCLK_Cnt                     : integer := 0;
 signal LCD_Data_Temp                : STD_LOGIC_VECTOR(11 downto 0);

 --- SIGNALS FOR LCD ARRAY STORAGE ---

 type state_type is (LDR, TEMP, POT);
 signal current_state 			    : state_type;
 signal LCD_index_TL 				: integer range 0 to 2;
 signal LCD_index_BL 				: integer range 3 to 4;
 signal prev_state 				    : state_type;
 signal prev_CO                     : std_logic;
 signal clk_cnt					    : integer := 0;
 signal clk_change                  : std_logic;
 signal clk_sync                    : std_logic_vector(1 downto 0);
 
 --- ARRAY DEFINING ---
 
 type LCD_array is array (0 to 4, 1 to 16) of std_logic_vector(11 downto 0);
 signal LCD_display : LCD_array := (
	(X"14C", X"144", X"152", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120"), -- TL "LDR"
	(X"154", X"145", X"14D", X"150", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120"), -- TL "TEMP" 		
	(X"150", X"14F", X"154", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120"), -- TL "POT"
	(X"143", X"14C", X"14F", X"143", X"14B", X"120", X"14F", X"155", X"154", X"150", X"155", X"154", X"120", X"120", X"120", X"120"), -- BL "CLOCK OUTPUT
	(X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120", X"120")  -- LINE CLEAR
	);

begin

LCD_DATA    <= LCD_Data_Temp;

--- LCD STATE ASSIGNMENTS ---

process(state, reset)
begin
	if reset = '1' then
		current_state <= LDR;
	else
		case state(1 downto 0) is
			when "00" => current_state <= LDR;
			when "01" => current_state <= TEMP;
			when "10" => current_state <= POT;
			when others => current_state <= LDR;
		end case;
	end if;
end process;

--- TOP LINE LCD STATE INDEXING ---

process(current_state)
begin
    case current_state is
        when LDR    => LCD_index_TL  <= 0;
        when TEMP   => LCD_index_TL  <= 1;
        when POT    => LCD_index_TL  <= 2;
        when others => LCD_index_TL  <= 0; -- Default to LDR
    end case;
end process;

--- BOTTOM LINE LCD STATE INDEXING ---
 
process(state)
begin
    if state(2) = '1' then
        LCD_index_BL <= 3;
    else
        LCD_index_BL <= 4;
    end if;
end process;

--- LCD ARRAY Processing ---
 
process(byte_Cnt)
begin
    LCD_Data_Temp <= (others => '0');
			
    if byte_Cnt < 8 then
        -- Initial LCD commands
        case byte_Cnt is
            when 0 | 1 | 2 => LCD_Data_Temp <= X"030"; -- Function Set 8-bit mode
            when 3 => LCD_Data_Temp <= X"020"; -- Changes to 4-bit mode
            when 4 => LCD_Data_Temp <= X"028";	-- 4-bit mode, 2x16 lcd
            when 5 => LCD_Data_Temp <= X"006";	 -- cursor to right
            when 6 => LCD_Data_Temp <= X"001"; 	 -- clear display
            when 7 => LCD_Data_Temp <= X"00F"; 	 -- display on for loading
            when others => null;
        end case;
	 elsif byte_Cnt < 25 then
        -- First-line characters
        LCD_Data_Temp <= LCD_display(LCD_index_TL, byte_Cnt - 7);
    elsif byte_Cnt = 25 then
        -- Move to second LCD line
        LCD_Data_Temp <= X"0C0";
    elsif byte_Cnt > 25 then
		  -- Second-line characters (Offset needs to be adjusted)
		  LCD_Data_Temp <= LCD_display(LCD_index_BL, byte_Cnt - 9);
	  end if;
end process;
 
 --- LCD TIMING PROCESS ---
 
process(iCLK, reset)
begin
    if reset = '1' then
        byte_Cnt <= 0;
        prev_state <= current_state;  
    elsif rising_edge(iCLK) then
        if current_state /= prev_state or clk_change = '1' then
            byte_Cnt <= 6;  -- Reset byte_Cnt if state changes
        end if;
        if Next_data = '1' then
            byte_cnt <= byte_cnt + 1; 
            
            if byte_cnt = 41 then
                byte_cnt <= 8;
            end if;
        end if;
    end if;
end process;

-- CLOCK ON PULSE --

process(iCLK)
begin
	if rising_edge(ICLK) then
		clk_sync(0) <= state(2);
		clk_sync(1) <= clk_sync(0);
		clk_change <= not clk_sync(1) and clk_sync(0);
	end if;
end process;

--	if reset = '1' then
--		byte_Cnt <= 0;
--		iCLK_Cnt <= 0;
--		prev_state <= current_state;
--	elsif rising_edge(iCLK) then
--		if current_state /= prev_state then
--			byte_Cnt <= 0;  -- Reset byte_Cnt if state changes
--		end if;
--		if iCLK_Cnt < iCLK_Lim then
--			iCLK_Cnt <= iCLK_Cnt +1;
--			if iCLK_Cnt = iCLK_Lim/3 then
--			elsif iCLK_Cnt = (iCLK_Lim*2)/3 then
--			end if;              
--		else    
--			iCLK_Cnt <= 0;
--			byte_Cnt <= byte_Cnt +1; 
--			if byte_Cnt = 39 then
--					byte_Cnt <= 6; 
--			else
--				byte_Cnt <= byte_Cnt +1; -- IF DATA_NEXT is TRUE then move byte_cnt
--			end if;
--		end if;
--		if iCLK_Cnt = 1 then
--		end if;
--		prev_state <= current_state;
--	end if;

end architecture;