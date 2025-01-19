library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seven_segment is
    Port (
        keypad_input : in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit input from keypad
        HEX0 : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display output for HEX0
        HEX1 : out STD_LOGIC_VECTOR(6 downto 0); -- HEX1
        HEX2 : out STD_LOGIC_VECTOR(6 downto 0); -- HEX2
        HEX3 : out STD_LOGIC_VECTOR(6 downto 0); -- HEX3
        HEX4 : out STD_LOGIC_VECTOR(6 downto 0); -- HEX4
        HEX5 : out STD_LOGIC_VECTOR(6 downto 0)  -- HEX5
    );
end seven_segment;

architecture Behavioral of seven_segment is

    -- 7-segment display encoding for HEX values 0 to F
    function to_7_segment(value : STD_LOGIC_VECTOR(3 downto 0)) return STD_LOGIC_VECTOR is -- Defines a helper function to map a 4-bit binary number (value) to the corresponding 7-segment display
    begin
        case value is -- matches each 4 bit input to 7 segment display
            when "0000" => return "1000000"; -- 0 -- 0 means on 1 means off
            when "0001" => return "1111001"; -- 1
            when "0010" => return "0100100"; -- 2
            when "0011" => return "0110000"; -- 3
            when "0100" => return "0011001"; -- 4
            when "0101" => return "0010010"; -- 5
            when "0110" => return "0000010"; -- 6
            when "0111" => return "1111000"; -- 7
            when "1000" => return "0000000"; -- 8
            when "1001" => return "0010000"; -- 9
            when "1010" => return "0001000"; -- A
            when "1011" => return "0000011"; -- B
            when "1100" => return "1000110"; -- C
            when "1101" => return "0100001"; -- D
            when "1110" => return "0000110"; -- E
            when "1111" => return "0001110"; -- F
            when others => return "1111111"; -- Blank display if unexpected input
        end case;
    end function;

begin
    process(keypad_input)-- main logic that begins process whenever keypad is pressed
    begin
        if keypad_input(4) = '0' then -- checks to see if its Address or DATA
            HEX5 <= to_7_segment(keypad_input(3 downto 0)); -- In address mode, display the 4-bit value on HEX 5
            HEX4 <= "1111111"; -- Blank display since these are unused in address mode
            HEX3 <= "1111111";
            HEX2 <= "1111111";
            HEX1 <= "1111111";
            HEX0 <= "1111111";
        else -- Data mode when most sig bit is 1
            HEX5 <= "1111111"; -- Blank display since these are not used in data mode
            HEX4 <= "1111111";
            HEX3 <= to_7_segment(keypad_input(3 downto 0)); -- in data mode, display the 4-bit value (keypad_input(3 downto 0)) on HEX3
            HEX2 <= "1111111";
            HEX1 <= "1111111";
            HEX0 <= "1111111";
        end if;
    end process;
end Behavioral;
