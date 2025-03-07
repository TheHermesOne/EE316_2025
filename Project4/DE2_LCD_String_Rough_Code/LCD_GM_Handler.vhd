LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;  -- Required for integer to std_logic_vector conversion

Entity LCD_GM_Handler is
    port(
        iCLK      : IN std_logic;
        reset     : IN std_logic;
        state     : IN std_logic_vector(3 downto 0);
        LCD_Data  : OUT std_logic_vector(11 downto 0)
    );
end LCD_GM_Handler;

ARCHITECTURE LOGIC OF LCD_GM_Handler is

signal str_in : string(1 to 1) := "F";
signal ascii_value : std_logic_vector(7 downto 0);  -- 8-bit ASCII output

begin

    -- Convert character to ASCII and then to std_logic_vector
    ascii_value <= CONV_STD_LOGIC_VECTOR(CHARACTER'POS(str_in(1)), 8);

    -- Concatenate the binary prefix with ASCII value
    LCD_Data <= "0001" & ascii_value(7 downto 0);  -- Using lower 4 bits for 12-bit output

end LOGIC;
