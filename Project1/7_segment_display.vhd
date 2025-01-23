library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegment is
    Port (
        clk           : in  STD_LOGIC;             -- Clock from keypad
        reset         : in  STD_LOGIC;             
        keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit input from keypad
        seg_out       : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display output
        digit_select  : out STD_LOGIC_VECTOR(3 downto 0)  -- line select
    );
end SevenSegment;

architecture Behavioral of SevenSegment is

    signal address_buffer : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); 
    signal data_buffer    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); 
    signal current_digit  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
    signal digit_index    : INTEGER range 0 to 3 := 0; -- digit to update
    signal display_mode   : STD_LOGIC := '0'; -- '0' for address, '1' for data

    --encoding for hex digits 0-F
    function hex_to_7seg(hex : STD_LOGIC_VECTOR(3 downto 0)) return STD_LOGIC_VECTOR is
        variable seg : STD_LOGIC_VECTOR(6 downto 0);
    begin
        case hex is
            when "0000" => seg := "1000000"; -- 0
            when "0001" => seg := "1111001"; -- 1
            when "0010" => seg := "0100100"; -- 2
            when "0011" => seg := "0110000"; -- 3
            when "0100" => seg := "0011001"; -- 4
            when "0101" => seg := "0010010"; -- 5
            when "0110" => seg := "0000010"; -- 6
            when "0111" => seg := "1111000"; -- 7
            when "1000" => seg := "0000000"; -- 8
            when "1001" => seg := "0010000"; -- 9
            when "1010" => seg := "0001000"; -- A
            when "1011" => seg := "0000011"; -- B
            when "1100" => seg := "1000110"; -- C
            when "1101" => seg := "0100001"; -- D
            when "1110" => seg := "0000110"; -- E
            when "1111" => seg := "0001110"; -- F
            when others => seg := "1111111"; -- otherwise
        end case;
        return seg;
    end hex_to_7seg;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset everything
            address_buffer <= (others => '0');
            data_buffer <= (others => '0');
            digit_index <= 0;
            display_mode <= '0';
        elsif rising_edge(clk) then
            -- Detect the mode based on keypad input
            display_mode <= keypad_input(4);

            if display_mode = '0' then
                -- Address modee Shift input into the address buffer
                address_buffer <= address_buffer(3 downto 0) & keypad_input(3 downto 0);
            else
                -- Data mode Shift input into the data buffer
                data_buffer <= data_buffer(11 downto 0) & keypad_input(3 downto 0);
            end if;

            -- Cycles through digitst that need to be displayed
            digit_index <= (digit_index + 1) mod 4;
        end if;
    end process;

    -- Assign the output based on the current digit
    process(digit_index, display_mode)
    begin
        if display_mode = '0' then
            -- Address mode
            case digit_index is
                when 0 => current_digit <= address_buffer(3 downto 0); -- Least significant 
                when 1 => current_digit <= address_buffer(7 downto 4); -- Most significant 
                when others => current_digit <= "0000"; -- Blank 
            end case;
        else
            -- Data mode
            case digit_index is
                when 0 => current_digit <= data_buffer(3 downto 0); -- Least significant 
                when 1 => current_digit <= data_buffer(7 downto 4);
                when 2 => current_digit <= data_buffer(11 downto 8);
                when 3 => current_digit <= data_buffer(15 downto 12); -- Most significant 
                when others => current_digit <= "0000"; -- Blank 
            end case;
        end if;
    end process;

    seg_out <= hex_to_7seg(current_digit);

    -- Digit select logic one digit at a time
    digit_select <= "1110" when digit_index = 0 else
                    "1101" when digit_index = 1 else
                    "1011" when digit_index = 2 else
                    "0111";

end Behavioral;
