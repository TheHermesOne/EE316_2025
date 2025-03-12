library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

entity LCD_Data_Cutter is
    port(
        iCLK                : IN std_logic;
	     next_data           : IN std_logic;
		  str_in					 : IN string(1 to 16);
--      LCD_Data            : IN std_logic_vector(11 downto 0);
        reset               : IN std_logic;
		  i2c_ena				 : OUT std_logic := '1';
        LCD_Data        	 : OUT std_logic_vector(11 downto 0)   		  
        );
end LCD_Data_Cutter;

architecture Behavioral of LCD_Data_Cutter is

--signal str_in : string(1 to 16) := "uueeuueeuueeXXXX";
signal ascii_value : std_logic_vector(7 downto 0);  -- 8-bit ASCII output
signal LCD_Data_Out	: std_LOGIC_VECTOR(11 downto 0);
signal string_length	: integer := 0;
signal count		: integer := 0;
signal b8bit_enable	: std_logic;
signal i8bit_count	: integer := 0;
--signal LCD_Data	: std_logic_vector(11 downto 0);
signal command : std_logic;  -- Example signal telling desing that data being sent is a command.
signal max_byte_cnt	: integer := 25;
signal byte_cnt	: integer range 0 to 25 := 0;
signal lcd_data_temp		: std_LOGIC_VECTOR(11 downto 0);
--signal i2c_ena_str			
--signal i2c_ena_bytcnt	: std_logic

begin

LCD_Data <= LCD_Data_Temp;



 -- Convert character to ASCII and then to std_logic_vector

ascii_value <= CONV_STD_LOGIC_VECTOR(CHARACTER'POS(str_in(byte_cnt-8)), 8);
 -- Concatenate the binary prefix with ASCII value
 
 ---------------------------------------------
 ------ Command / Data concatinator MUX ------
 ---------------------------------------------
 
process(ascii_value)
begin
	if ascii_value = X"58" then
		LCD_Data_Out <= "0001" & x"20";
--		i2c_ena <= '0';
	else
		LCD_Data_Out <= "0001" & ascii_value(7 downto 0);
--		i2c_ena <= '1';
	end if;
end process;

-- process(command)
-- begin
--	if command = '1' then
--		LCD_Data_Out <= "0000" & ascii_value(7 downto 0);
--	else
--		LCD_Data_Out <= "0001" & ascii_value(7 downto 0);
--	end if;
--end process;

 ----------------------------------------------
 -- Busy signal pulse for Byte Count Looping --
 ----------------------------------------------

process(next_data,reset,iCLK)
begin
	if	reset = '0' then
		byte_Cnt <= 0;
		i2c_ena <= '1';
	elsif rising_edge(iCLK) then
		if byte_Cnt < max_byte_cnt then
			i2c_ena <= '1';
			if next_data = '1' then
			byte_Cnt <= byte_Cnt + 1;
			
			end if;
--	elsif new_string = '1' then
--		byte_Cnt <= 6;
		
		elsif byte_Cnt = max_byte_cnt then
			i2c_ena <= '0';
		end if;
	end if;
end process;

------------------------------------
------LCD BYTE_CNT DATA SELECT------
------------------------------------
lcd_Data <= lcd_Data_Temp; 
 
process(byte_Cnt)
begin
--    LCD_Data_Temp <= (others => '0');
			
		if byte_Cnt < 9 then
        -- Initial LCD commands
			case byte_Cnt is
				when 0 | 1 | 2 => LCD_Data_Temp <= X"030"; -- Function Set 8-bit mode
				when 3 => LCD_Data_Temp <= X"020";   -- Changes to 4-bit mode
				when 4 => LCD_Data_Temp <= X"028";	 -- 4-bit mode, 2x16 lcd
				when 5 => LCD_Data_Temp <= X"008";	 -- cursor to right
				when 6 => LCD_Data_Temp <= X"001"; 	 -- clear display
				when 7 => LCD_Data_Temp <= X"006"; 	 -- display on for loading
				when 8 => LCD_Data_Temp <= X"00C";   --
				when others => null;
        end case;
		elsif byte_Cnt < 26 and byte_cnt > 9 then
        -- First-line characters
        LCD_Data_Temp <= LCD_Data_Out;
	   elsif byte_Cnt = 26 then
        -- Move to second LCD line
        LCD_Data_Temp <= X"0C0";
		elsif byte_Cnt > 26 then
		  -- Second-line characters (Offset needs to be adjusted)
		  LCD_Data_Temp <= LCD_Data_Out;
	  end if;
end process;

-------------------------------
------LCD Cutter Example ------
-------------------------------

-- LCD_Nibble(7 downto 0)   <= LCD_Data(7 downto 4) & "100" & LCD_Data(8); -- SHOULD BE MOVED TO USER LOGIC I2C
-- LCD_Nibble(15 downto 8)  <= LCD_Data(7 downto 4) & "110" & LCD_Data(8);
-- LCD_Nibble(23 downto 16) <= LCD_Data(7 downto 4) & "100" & LCD_Data(8);    
-- LCD_Nibble(31 downto 24) <= LCD_Data(3 downto 0) & "100" & LCD_Data(8);
-- LCD_Nibble(39 downto 32) <= LCD_Data(3 downto 0) & "110" & LCD_Data(8);
-- LCD_Nibble(47 downto 40) <= LCD_Data(3 downto 0) & "100" & LCD_Data(8);  
--string_length <= str_in'length;



end behavioral;

--process(iCLK)
--begin
--if reset = '1' then
--	i8bit_count <= 0;
--else
--	if rising_edge(iCLK) then
--		if i8bit_count < 8 then
--			i8bit_count <= i8bit_count + 1;
--			b8bit_enable <= '0';
--		else
--			i8bit_count <= 0;
--			b8bit_enable <= '1';
--		end if;
--	end if;
--end if;
--end process;
-- 
-- 
-- 
--process(iCLK)
--begin
--if reset = '1' then
--	count <= 0;
--else
--	if rising_edge(b8bit_enable) then
--		 if count < string_length then
--			count <= count + 1;
--		else
--			count <= 0;
--		end if;
--	end if;
--end if;
--end process;
		 
	
		
--process(iCLK)
--begin
--    if rising_edge(iCLK) then
--        case current_state is
--        
--            when hn1 =>
--                LCD_Nibble <= LCD_Data(7 downto 4) & "100" & LCD_Data(8);
--            when hn2 =>
--                LCD_Nibble <= LCD_Data(7 downto 4) & "110" & LCD_Data(8);
--            when hn3 =>
--                LCD_Nibble <= LCD_Data(7 downto 4) & "100" & LCD_Data(8);    
--            when ln1 =>
--                LCD_Nibble <= LCD_Data(3 downto 0) & "100" & LCD_Data(8);
--            when ln2 =>
--                LCD_Nibble <= LCD_Data(3 downto 0) & "110" & LCD_Data(8);
--            when ln3 =>
--                LCD_Nibble <= LCD_Data(3 downto 0) & "100" & LCD_Data(8);  
--    
--        end case;
--    end if;
--end process;
--
--
--process(iCLK)
--begin
--    if rising_edge(iCLK) then
--        if reset = '1' then
--            state_cnt <= 0;
--            current_state <= hn1;  -- Ensure a known initial state
--        elsif ready = '1' then
--            -- Update state first, then increment state_cnt
--            case state_cnt is
--                when 0 =>
--                    current_state <= hn1;
--                when 1 =>
--                    current_state <= hn2;
--                when 2 =>
--                    current_state <= hn3;
--                when 3 =>
--                    current_state <= ln1;
--                when 4 =>
--                    current_state <= ln2;
--                when 5 =>
--                    current_state <= ln3;
--                when others =>
--                    current_state <= hn1;
--            end case;
--            if state_cnt = 4 then
--               Next_data_ready <= '1';
--           else
--               Next_data_ready <= '0';  
--            end if;
--            -- Now increment state_cnt
--            if state_cnt = 5 then
--                state_cnt <= 0;
--            else
--                state_cnt <= state_cnt + 1;
--            end if;
--        end if;
--    end if;
--end process;
--            
--process(Next_data_ready)
--begin
--nd_prev <= Next_data_ready;
--	if Next_data_ready = '0' and nd_prev = '1' then
--		ndTemp <= '1';
--	else
--		ndTemp <= '0';
--	end if;
--end process;
--
--process(iCLK)
--begin
--	if rising_edge(ICLK) then
--		nd_sync(0) <= ndTemp;
--		nd_sync(1) <= nd_sync(0);
--		Next_data <= not nd_sync(1) and nd_sync(0);
--	end if;
--end process;
--
--end Behavioral;
        
--    -- Upper and Lower Nibble converter --

--    procedure Convert_To_LCD_4bit(
--        ascii_data : in STD_LOGIC_VECTOR(11 downto 0);
--        lcd_data_high : out STD_LOGIC_VECTOR(7 downto 0);
--        lcd_data_low : out STD_LOGIC_VECTOR(7 downto 0)
--    ) is
--        variable high_nibble : STD_LOGIC_VECTOR(3 downto 0);
--        variable low_nibble : STD_LOGIC_VECTOR(3 downto 0);
--    begin
        
--        high_nibble := ascii_data(7 downto 4);
--        low_nibble := ascii_data(3 downto 0);
        
--        if ascii_data(8) = '1' then
--            lcd_data_high := high_nibble & "1011"; -- RS=1, RW=0, High nibble data
--            lcd_data_low := low_nibble & "1011"; -- RS=1, RW=0, Low nibble data
--        else
--            lcd_data_high := high_nibble & "1010"; -- RS=0, RW=0, High nibble command
--            lcd_data_low := low_nibble & "1010"; -- RS=0, RW=0, Low nibble command
--        end if;
--    end procedure Convert_To_LCD_4bit;

--    -- Temp Signals --
    
--    signal LCD_Unibble     : std_logic_vector(7 downto 0);
--    signal LCD_Lnibble     : std_logic_vector(7 downto 0);
--    signal lcd_data_high    : std_logic_vector(7 downto 0);
--    signal lcd_data_low     : std_logic_vector(7 downto 0);
--    signal clk_cnt          : integer := 0;
--    signal clk_nibble_lim   : integer := 41665;
--    signal nibble_en        : std_logic;
    
       
--begin

--    process(iCLK)
--    begin
--        if rising_edge(iCLK) then
--            clk_cnt <= clk_cnt + 1;
--        end if;
        
--        if clk_cnt >= clk_nibble_lim then
--            nibble_en <= '1';
--            clk_cnt <= 0;
--        else
--            nibble_en <= '0';
--        end if;
--    end process;

         
---- 4-BIT LCD DATA CUT CALL --
--    process(clk_en)
--    begin
--        if clk_en = '1' then
--                 Convert_To_LCD_4bit(LCD_Data, LCD_Unibble, LCD_Lnibble);
--        end if;
--    end process;
    
---- ASCII SPLITTER --

--    process(LCD_Nibble)
--    begin

