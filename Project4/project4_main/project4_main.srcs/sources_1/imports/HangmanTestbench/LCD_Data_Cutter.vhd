library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

entity LCD_Data_Cutter is
    port(
        iCLK                : IN std_logic;
	     next_data           : IN std_logic;
		  str_in					 : IN string(1 to 16);
        reset               : IN std_logic;
		  kp_pulse				 : IN std_logic;
		  i2c_ena				 : OUT std_logic := '1';
        LCD_Data        	 : OUT std_logic_vector(11 downto 0)   		  
        );
end LCD_Data_Cutter;

architecture Behavioral of LCD_Data_Cutter is

signal ascii_value : std_logic_vector(7 downto 0);  -- 8-bit ASCII output
signal LCD_Data_Out	: std_LOGIC_VECTOR(11 downto 0);
signal string_length	: integer := 0;
signal count		: integer := 0;
signal b8bit_enable	: std_logic;
signal i8bit_count	: integer := 0;
signal command : std_logic;  -- Example signal telling desing that data being sent is a command.
signal max_byte_cnt	: integer := 25;
signal byte_cnt	: integer range 0 to 25 := 0;
signal lcd_data_temp		: std_LOGIC_VECTOR(11 downto 0);

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
	else
		LCD_Data_Out <= "0001" & ascii_value(7 downto 0);
	end if;
end process;


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
		elsif kp_pulse = '1' then
			byte_Cnt <= 6;
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
		elsif byte_Cnt < 26 and byte_cnt > 8 then
        -- First-line characters
        LCD_Data_Temp <= LCD_Data_Out;
--	   elsif byte_Cnt = 26 then
--        -- Move to second LCD line
--        LCD_Data_Temp <= X"0C0";
--		elsif byte_Cnt > 26 then
--		  -- Second-line characters (Offset needs to be adjusted)
--		  LCD_Data_Temp <= LCD_Data_Out;
	  end if;
end process;

end behavioral;