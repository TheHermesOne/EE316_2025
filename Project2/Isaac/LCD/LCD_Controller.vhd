LIBRARY ieee;
   USE ieee.std_logic_1164.all;

	entity LCD_Controller is 
		port(
			iClk				: in std_logic; 
			LCD_Mode_SW		: in std_logic_vector(3 downto 0); -- switch for state machine input
			SRAM_DATA		: in std_logic_vector(15 downto 0);
			SRAM_ADDRESS	: in std_logic_vector(19 downto 0);
			LCD_DATA			: inout std_logic_vector(7 downto 0);
			LCD_EN			: out std_logic;
			LCD_RS			: out std_logic
			);
	END LCD_Controller;
	
architecture structural of LCD_Controller is
	function SRAM_addr_decoder(val_addr: std_logic_vector(3 downto 0)) return std_logic_vector is
begin
    case val_addr is
        when "0000" => return X"30"; -- '0'
        when "0001" => return X"31"; -- '1'
        when "0010" => return X"32"; -- '2'
        when "0011" => return X"33"; -- '3'
        when "0100" => return X"34"; -- '4'
        when "0101" => return X"35"; -- '5'
        when "0110" => return X"36"; -- '6'
        when "0111" => return X"37"; -- '7'
        when "1000" => return X"38"; -- '8'
        when "1001" => return X"39"; -- '9'
        when "1010" => return X"41"; -- 'A'
        when "1011" => return X"42"; -- 'B'
        when "1100" => return X"43"; -- 'C'
        when "1101" => return X"44"; -- 'D'
        when "1110" => return X"45"; -- 'E'
        when "1111" => return X"46"; -- 'F'
        when others => return X"20"; -- SPACE (BLANK/ERROR)
    end case;
end function;

function SRAM_data_decoder(val_data: std_logic_vector(3 downto 0)) return std_logic_vector is
begin
    case val_data is
        when "0000" => return X"30"; -- '0'
        when "0001" => return X"31"; -- '1'
        when "0010" => return X"32"; -- '2'
        when "0011" => return X"33"; -- '3'
        when "0100" => return X"34"; -- '4'
        when "0101" => return X"35"; -- '5'
        when "0110" => return X"36"; -- '6'
        when "0111" => return X"37"; -- '7'
        when "1000" => return X"38"; -- '8'
        when "1001" => return X"39"; -- '9'
        when "1010" => return X"41"; -- 'A'
        when "1011" => return X"42"; -- 'B'
        when "1100" => return X"43"; -- 'C'
        when "1101" => return X"44"; -- 'D'
        when "1110" => return X"45"; -- 'E'
        when "1111" => return X"46"; -- 'F'
        when others => return X"20"; -- SPACE (BLANK/ERROR)
    end case;
end function;

 constant iCLK_Lim                   : integer := 83333;
 constant iCLK_Lim_sram              : integer := 12500000;   -- .25s
 signal byte_Cnt                     : integer range 0 to 32 := 0;
 signal iCLK_Cnt                     : integer := 0;
 signal iCLK_Cnt_sram                : integer := 0;
 signal LCD_Data_Temp                : STD_LOGIC_VECTOR(7 downto 0);
 signal LCD_EN_Temp                  : STD_LOGIC;
 signal LCD_RS_Temp                  : STD_LOGIC;
 signal data_EN                      : STD_LOGIC;
 signal a1,a2,d1,d2,d3,d4				 : std_logic_vector(7 downto 0);
signal state_prev						 : std_logic_vector(3 downto 0);
 begin 
--
 process(iclK)
 begin
 if rising_edge(iclk) then

 state_prev <= LCD_Mode_SW;

 end if;
 end process;
process(SRAM_ADDRESS,SRAM_DATA)
begin
		if iCLK_Cnt_sram < iCLK_Lim_sram then
			iCLK_Cnt_sram <= iCLK_Cnt_sram +1;
		else    
			a1 <= SRAM_addr_decoder(SRAM_ADDRESS(3 downto 0));
			a2 <= SRAM_addr_decoder(SRAM_ADDRESS(7 downto 4));

			d1 <= SRAM_data_decoder(SRAM_DATA(3 downto 0));
			d2 <= SRAM_data_decoder(SRAM_DATA(7 downto 4));
			d3 <= SRAM_data_decoder(SRAM_DATA(11 downto 8));
			d4 <= SRAM_data_decoder(SRAM_DATA(15 downto 12));
		end if;
end process;

 LCD_DATA    <= LCD_Data_Temp;
 LCD_EN      <= LCD_EN_Temp;
 LCD_RS      <= LCD_RS_Temp;


process(iCLK, LCD_Mode_SW)
begin
    
	if rising_edge(iCLK) then
		
		if iCLK_Cnt < iCLK_Lim then
			iCLK_Cnt <= iCLK_Cnt +1;
			if iCLK_Cnt = iCLK_Lim/3 then
				LCD_EN_Temp <= '1';
			elsif iCLK_Cnt = (iCLK_Lim*2)/3 then
				LCD_EN_Temp <= '0';
			end if; 
		else    
			iCLK_Cnt <= 0;
			byte_Cnt <= byte_Cnt +1; 
			if byte_Cnt = 40 then
				byte_Cnt <= 9;
			end if;
--		elsif LCD_Mode_SW /= state_prev and LCD_Mode_SW /= "1000" then    
--			iCLK_Cnt <= 0;
--			byte_Cnt <= 0;
--			if byte_Cnt < 34 then
--			byte_Cnt <= byte_Cnt + 1;
--			end if;
--		elsif LCD_Mode_SW = "1000" then
--			iCLK_Cnt <= 0;
--			byte_Cnt <= byte_Cnt +1; 
--			if byte_Cnt = 32 then
--				byte_Cnt <= 9;
--			end if;
--		end if;
--		if iCLK_Cnt = 1 then
--			LCD_EN_Temp <= '0';
--			data_EN <= '0';
--		end if;
		end if;
	end if;
end process;

process(byte_Cnt)
 begin
	  
	  LCD_Data_Temp <= (others => '0');
	  LCD_RS_Temp <= '0';
 
case(LCD_Mode_SW) is
when "0000" =>
	  case byte_Cnt is       
			when 0  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
			when 1  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
			when 2  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
			when 3  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
			when 4  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
			when 5  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
			when 6  => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0';
			when 7  => LCD_Data_Temp <= X"0C"; LCD_RS_Temp <= '0';
			when 8  => LCD_Data_Temp <= X"06"; LCD_RS_Temp <= '0';
			when 9  => LCD_Data_Temp <= X"80"; LCD_RS_Temp <= '0';

			-- Inserted Clear Display Command
			when 10 => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0'; -- Clear display

			-- Initializing
			when 11 => LCD_Data_Temp <= X"49"; LCD_RS_Temp <= '1'; -- 'I'
			when 12 => LCD_Data_Temp <= X"6E"; LCD_RS_Temp <= '1'; -- 'n'
			when 13 => LCD_Data_Temp <= X"69"; LCD_RS_Temp <= '1'; -- 'i'
			when 14 => LCD_Data_Temp <= X"74"; LCD_RS_Temp <= '1'; -- 't'
			when 15 => LCD_Data_Temp <= X"69"; LCD_RS_Temp <= '1'; -- 'i'
			when 16 => LCD_Data_Temp <= X"61"; LCD_RS_Temp <= '1'; -- 'a'
			when 17 => LCD_Data_Temp <= X"6C"; LCD_RS_Temp <= '1'; -- 'l'
			when 18 => LCD_Data_Temp <= X"69"; LCD_RS_Temp <= '1'; -- 'i'
			when 19 => LCD_Data_Temp <= X"7A"; LCD_RS_Temp <= '1'; -- 'z'
			when 20 => LCD_Data_Temp <= X"69"; LCD_RS_Temp <= '1'; -- 'i'
			when 21 => LCD_Data_Temp <= X"6E"; LCD_RS_Temp <= '1'; -- 'n'
			when 22 => LCD_Data_Temp <= X"67"; LCD_RS_Temp <= '1'; -- 'g'

			when others =>
				 LCD_Data_Temp <= (others => '0');
				 LCD_RS_Temp <= '0';
			end case;
when "1000" =>
    case byte_Cnt is       
        when 0  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
        when 1  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
        when 2  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
        when 3  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
        when 4  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
        when 5  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
        when 6  => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0';
        when 7  => LCD_Data_Temp <= X"0C"; LCD_RS_Temp <= '0';
        when 8  => LCD_Data_Temp <= X"06"; LCD_RS_Temp <= '0';
        when 9  => LCD_Data_Temp <= X"80"; LCD_RS_Temp <= '0';

        -- Inserted Clear Display Command
        when 10 => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0'; -- Clear display

        -- Test Mode
        when 11 => LCD_Data_Temp <= X"54"; LCD_RS_Temp <= '1'; -- 'T'
        when 12 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'
        when 13 => LCD_Data_Temp <= X"73"; LCD_RS_Temp <= '1'; -- 's'
        when 14 => LCD_Data_Temp <= X"74"; LCD_RS_Temp <= '1'; -- 't'
        when 15 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' ' (space)
        when 16 => LCD_Data_Temp <= X"4D"; LCD_RS_Temp <= '1'; -- 'M'
        when 17 => LCD_Data_Temp <= X"6F"; LCD_RS_Temp <= '1'; -- 'o'
        when 18 => LCD_Data_Temp <= X"64"; LCD_RS_Temp <= '1'; -- 'd'
        when 19 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'
		  when 20 => LCD_Data_Temp <= X"C0"; LCD_RS_Temp <= '0'; -- move cursor
		
		  when 21 => LCD_Data_Temp <= a1; LCD_RS_Temp <= '1'; --sram address
		  when 22 => LCD_Data_Temp <= a2; LCD_RS_Temp <= '1';
		  when 23 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' '
		  when 24 => LCD_Data_Temp <= d1; LCD_RS_Temp <= '1'; --sram data
		  when 25 => LCD_Data_Temp <= d2; LCD_RS_Temp <= '1';
		  when 26 => LCD_Data_Temp <= d3; LCD_RS_Temp <= '1';
		  when 27 => LCD_Data_Temp <= d4; LCD_RS_Temp <= '1';
        when others =>
            LCD_Data_Temp <= (others => '0');
            LCD_RS_Temp <= '0';
    end case;
when "0100" =>
	case byte_Cnt is       
		when 0  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 1  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 2  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 3  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 4  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 5  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 6  => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0';
		when 7  => LCD_Data_Temp <= X"0C"; LCD_RS_Temp <= '0';
		when 8  => LCD_Data_Temp <= X"06"; LCD_RS_Temp <= '0';
		when 9  => LCD_Data_Temp <= X"80"; LCD_RS_Temp <= '0';

		-- Inserted Clear Display Command
		when 10 => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0'; -- Clear display

		-- Pause Mode
		when 11 => LCD_Data_Temp <= X"50"; LCD_RS_Temp <= '1'; -- 'P'
		when 12 => LCD_Data_Temp <= X"61"; LCD_RS_Temp <= '1'; -- 'a'
		when 13 => LCD_Data_Temp <= X"75"; LCD_RS_Temp <= '1'; -- 'u'
		when 14 => LCD_Data_Temp <= X"73"; LCD_RS_Temp <= '1'; -- 's'
		when 15 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'
		when 16 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' ' (space)
		when 17 => LCD_Data_Temp <= X"4D"; LCD_RS_Temp <= '1'; -- 'M'
		when 18 => LCD_Data_Temp <= X"6F"; LCD_RS_Temp <= '1'; -- 'o'
		when 19 => LCD_Data_Temp <= X"64"; LCD_RS_Temp <= '1'; -- 'd'
		when 20 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'
		when 21 => LCD_Data_Temp <= X"C0"; LCD_RS_Temp <= '0'; -- move cursor
		
		when 22 => LCD_Data_Temp <= a1; LCD_RS_Temp <= '1'; --sram address
		when 23 => LCD_Data_Temp <= a2; LCD_RS_Temp <= '1';
		when 24 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' '
		when 25 => LCD_Data_Temp <= d1; LCD_RS_Temp <= '1'; --sram data
		when 26 => LCD_Data_Temp <= d2; LCD_RS_Temp <= '1';
		when 27 => LCD_Data_Temp <= d3; LCD_RS_Temp <= '1';
		when 28 => LCD_Data_Temp <= d4; LCD_RS_Temp <= '1';

		when others =>
			LCD_Data_Temp <= (others => '0');
			LCD_RS_Temp <= '0';
	end case;
when "1101" =>
	case byte_Cnt is       
		when 0  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 1  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 2  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 3  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 4  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 5  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 6  => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0';
		when 7  => LCD_Data_Temp <= X"0C"; LCD_RS_Temp <= '0';
		when 8  => LCD_Data_Temp <= X"06"; LCD_RS_Temp <= '0';
		when 9  => LCD_Data_Temp <= X"80"; LCD_RS_Temp <= '0';

		-- Inserted Clear Display Command
		when 10 => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0'; -- Clear display

		-- Operation Mode
		when 11 => LCD_Data_Temp <= X"4F"; LCD_RS_Temp <= '1'; -- 'O'
		when 12 => LCD_Data_Temp <= X"70"; LCD_RS_Temp <= '1'; -- 'p'
		when 13 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'
		when 14 => LCD_Data_Temp <= X"72"; LCD_RS_Temp <= '1'; -- 'r'
		when 15 => LCD_Data_Temp <= X"61"; LCD_RS_Temp <= '1'; -- 'a'
		when 16 => LCD_Data_Temp <= X"74"; LCD_RS_Temp <= '1'; -- 't'
		when 17 => LCD_Data_Temp <= X"69"; LCD_RS_Temp <= '1'; -- 'i'
		when 18 => LCD_Data_Temp <= X"6F"; LCD_RS_Temp <= '1'; -- 'o'
		when 19 => LCD_Data_Temp <= X"6E"; LCD_RS_Temp <= '1'; -- 'n'
		when 20 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' ' (space)
		when 21 => LCD_Data_Temp <= X"4D"; LCD_RS_Temp <= '1'; -- 'M'
		when 22 => LCD_Data_Temp <= X"6F"; LCD_RS_Temp <= '1'; -- 'o'
		when 23 => LCD_Data_Temp <= X"64"; LCD_RS_Temp <= '1'; -- 'd'
		when 24 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'

		-- Move cursor to second line (Address C0h)
		when 25 => LCD_Data_Temp <= X"C0"; LCD_RS_Temp <= '0'; 

		-- "60 Hz" (Second Line)
		when 26 => LCD_Data_Temp <= X"36"; LCD_RS_Temp <= '1'; -- '6'
		when 27 => LCD_Data_Temp <= X"30"; LCD_RS_Temp <= '1'; -- '0'
		when 28 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' ' (space)
		when 29 => LCD_Data_Temp <= X"48"; LCD_RS_Temp <= '1'; -- 'H'
		when 30 => LCD_Data_Temp <= X"5A"; LCD_RS_Temp <= '1'; -- 'z'

		when others =>
			LCD_Data_Temp <= (others => '0');
			LCD_RS_Temp <= '0';
	end case;
when "1110" =>
	case byte_Cnt is       
		when 0  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 1  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 2  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 3  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 4  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 5  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 6  => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0';
		when 7  => LCD_Data_Temp <= X"0C"; LCD_RS_Temp <= '0';
		when 8  => LCD_Data_Temp <= X"06"; LCD_RS_Temp <= '0';
		when 9  => LCD_Data_Temp <= X"80"; LCD_RS_Temp <= '0';  -- Move cursor to beginning of first line
		
		-- Inserted Clear Display Command
		when 10 => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0'; -- Clear display

		-- Operation Mode (First Line)
		when 11 => LCD_Data_Temp <= X"4F"; LCD_RS_Temp <= '1'; -- 'O'
		when 12 => LCD_Data_Temp <= X"70"; LCD_RS_Temp <= '1'; -- 'p'
		when 13 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'
		when 14 => LCD_Data_Temp <= X"72"; LCD_RS_Temp <= '1'; -- 'r'
		when 15 => LCD_Data_Temp <= X"61"; LCD_RS_Temp <= '1'; -- 'a'
		when 16 => LCD_Data_Temp <= X"74"; LCD_RS_Temp <= '1'; -- 't'
		when 17 => LCD_Data_Temp <= X"69"; LCD_RS_Temp <= '1'; -- 'i'
		when 18 => LCD_Data_Temp <= X"6F"; LCD_RS_Temp <= '1'; -- 'o'
		when 19 => LCD_Data_Temp <= X"6E"; LCD_RS_Temp <= '1'; -- 'n'
		when 20 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' ' (space)
		when 21 => LCD_Data_Temp <= X"4D"; LCD_RS_Temp <= '1'; -- 'M'
		when 22 => LCD_Data_Temp <= X"6F"; LCD_RS_Temp <= '1'; -- 'o'
		when 23 => LCD_Data_Temp <= X"64"; LCD_RS_Temp <= '1'; -- 'd'
		when 24 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'
		
		-- Move cursor to second line (Address C0h)
		when 25 => LCD_Data_Temp <= X"C0"; LCD_RS_Temp <= '0'; 
		
		-- "100 Hz" (Second Line)
		when 26 => LCD_Data_Temp <= X"31"; LCD_RS_Temp <= '1'; -- '1'
		when 27 => LCD_Data_Temp <= X"30"; LCD_RS_Temp <= '1'; -- '0'
		when 28 => LCD_Data_Temp <= X"30"; LCD_RS_Temp <= '1'; -- '0'
		when 29 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' ' (space)
		when 30 => LCD_Data_Temp <= X"48"; LCD_RS_Temp <= '1'; -- 'H'
		when 31 => LCD_Data_Temp <= X"5A"; LCD_RS_Temp <= '1'; -- 'z'
		when 32 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' '

		when others =>
			LCD_Data_Temp <= (others => '0');
			LCD_RS_Temp <= '0';
	end case;
when "1111" =>
	case byte_Cnt is       
		when 0  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 1  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 2  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 3  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 4  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 5  => LCD_Data_Temp <= X"38"; LCD_RS_Temp <= '0';
		when 6  => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0';
		when 7  => LCD_Data_Temp <= X"0C"; LCD_RS_Temp <= '0';
		when 8  => LCD_Data_Temp <= X"06"; LCD_RS_Temp <= '0';
		when 9  => LCD_Data_Temp <= X"80"; LCD_RS_Temp <= '0';  -- Move cursor to beginning of first line

		-- Inserted Clear Display Command
		when 10 => LCD_Data_Temp <= X"01"; LCD_RS_Temp <= '0'; -- Clear display

		-- Operation Mode (First Line)
		when 11 => LCD_Data_Temp <= X"4F"; LCD_RS_Temp <= '1'; -- 'O'
		when 12 => LCD_Data_Temp <= X"70"; LCD_RS_Temp <= '1'; -- 'p'
		when 13 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'
		when 14 => LCD_Data_Temp <= X"72"; LCD_RS_Temp <= '1'; -- 'r'
		when 15 => LCD_Data_Temp <= X"61"; LCD_RS_Temp <= '1'; -- 'a'
		when 16 => LCD_Data_Temp <= X"74"; LCD_RS_Temp <= '1'; -- 't'
		when 17 => LCD_Data_Temp <= X"69"; LCD_RS_Temp <= '1'; -- 'i'
		when 18 => LCD_Data_Temp <= X"6F"; LCD_RS_Temp <= '1'; -- 'o'
		when 19 => LCD_Data_Temp <= X"6E"; LCD_RS_Temp <= '1'; -- 'n'
		when 20 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' ' (space)
		when 21 => LCD_Data_Temp <= X"4D"; LCD_RS_Temp <= '1'; -- 'M'
		when 22 => LCD_Data_Temp <= X"6F"; LCD_RS_Temp <= '1'; -- 'o'
		when 23 => LCD_Data_Temp <= X"64"; LCD_RS_Temp <= '1'; -- 'd'
		when 24 => LCD_Data_Temp <= X"65"; LCD_RS_Temp <= '1'; -- 'e'

		-- Move cursor to second line (Address C0h)
		when 25 => LCD_Data_Temp <= X"C0"; LCD_RS_Temp <= '0'; 
		
		-- "1000 Hz" (Second Line)
		when 26 => LCD_Data_Temp <= X"31"; LCD_RS_Temp <= '1'; -- '1'
		when 27 => LCD_Data_Temp <= X"30"; LCD_RS_Temp <= '1'; -- '0'
		when 28 => LCD_Data_Temp <= X"30"; LCD_RS_Temp <= '1'; -- '0'
		when 29 => LCD_Data_Temp <= X"30"; LCD_RS_Temp <= '1'; -- '0'
		when 30 => LCD_Data_Temp <= X"20"; LCD_RS_Temp <= '1'; -- ' ' (space)
		when 31 => LCD_Data_Temp <= X"48"; LCD_RS_Temp <= '1'; -- 'H'
		when 32 => LCD_Data_Temp <= X"5A"; LCD_RS_Temp <= '1'; -- 'z'

		when others =>
			LCD_Data_Temp <= (others => '0');
			LCD_RS_Temp <= '0';
	end case;
	when others => null;
	end case;
 end process;

 end architecture;