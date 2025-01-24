library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegment is
    Port (
        clk           : in  STD_LOGIC;             -- Clock from keypad
        reset         : in  STD_LOGIC;             -- Reset 
        keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit keypad
        seg_out       : out STD_LOGIC_VECTOR(6 downto 0); -- 7-seg display output
        digit_select  : out STD_LOGIC_VECTOR(3 downto 0)  -- select 7 segment
    );
end SevenSegment;

architecture Behavioral of SevenSegment is

    component ShiftRegisters
        Port (
            clk           : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0);
            address_buffer: out STD_LOGIC_VECTOR(7 downto 0);
            data_buffer   : out STD_LOGIC_VECTOR(15 downto 0);
            display_mode  : out STD_LOGIC
        );
    end component;

    signal address_buffer : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); -- address buffer
    signal data_buffer    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); -- data buffer
    signal current_digit  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); -- Current nubmer
    signal digit_index    : INTEGER range 0 to 3 := 0; -- Tracks the digit to update
    signal display_mode   : STD_LOGIC := '0'; -- '0' for address, '1' for data

    -- 7-segment encoding for hex digits 0-F
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
            when others => seg := "1111111"; -- otherwsie
        end case;
        return seg;
    end hex_to_7seg;

begin

    U_ShiftRegisters: ShiftRegisters
        Port Map (
            clk => clk,
            reset => reset,
            keypad_input => keypad_input,
            address_buffer => address_buffer,
            data_buffer => data_buffer,
            display_mode => display_mode
        );

    -- choose 7 segment depending on what number is selected
    process(digit_index, display_mode)
    begin
        if display_mode = '0' then
            -- Address mode
            case digit_index is
                when 0 => current_digit <= address_buffer(3 downto 0); -- Least significant bit
                when 1 => current_digit <= address_buffer(7 downto 4); -- Most significant bit
                when others => current_digit <= "0000"; -- otherwise leave it blank
            end case;
        else
            -- Data mode
            case digit_index is
                when 0 => current_digit <= data_buffer(3 downto 0); -- Least significant bit
                when 1 => current_digit <= data_buffer(7 downto 4);
                when 2 => current_digit <= data_buffer(11 downto 8);
                when 3 => current_digit <= data_buffer(15 downto 12); -- Most significant bit
                when others => current_digit <= "0000"; -- otherwise leave it blank
            end case;
        end if;
    end process;

    seg_out <= hex_to_7seg(current_digit);

    -- Digit selects one at a time.
    digit_select <= "1110" when digit_index = 0 else
                    "1101" when digit_index = 1 else
                    "1011" when digit_index = 2 else
                    "0111";

end Behavioral;
