library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegment is
    Port (
        clk           : in  STD_LOGIC;             -- Clock signal
        reset         : in  STD_LOGIC;             -- Reset signal
        keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit input from keypad
        seg_out       : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display output
        digit_select  : out STD_LOGIC_VECTOR(3 downto 0); -- Select lines for 7-segment displays
        mode          : in  STD_LOGIC              -- Operational (1) or Programming (0)
    );
end SevenSegment;

architecture Behavioral of SevenSegment is


    signal address_buffer : STD_LOGIC_VECTOR(7 downto 0); -- NUM_ADDR_REGS
    signal data_buffer    : STD_LOGIC_VECTOR(15 downto 0); -- NUM_DATA_REGS 
    signal current_digit  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); -- Current digit
    signal digit_index    : INTEGER range 0 to 3 := 0; -- Index for selecting digits
    signal refresh_count  : INTEGER := 0; -- Counter for multiplexing displays

    -- 7-segment encoding function
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
            when others => seg := "1111111"; -- Blank
        end case;
        return seg;
    end hex_to_7seg;

begin

    -- Process for multiplexing and digit selection
    process(clk, reset)
    begin
        if reset = '1' then
            digit_index <= 0;
            refresh_count <= 0;
        elsif rising_edge(clk) then
            refresh_count <= refresh_count + 1;
            if refresh_count = 1000 then -- Adjust for refresh rate
                refresh_count <= 0;
                digit_index <= (digit_index + 1) mod 4;
            end if;
        end if;
    end process;

    -- Assign digit values and select lines based on mode
    process(digit_index, mode, address_buffer, data_buffer)
    begin
        if mode = '0' then
            -- Programming mode: Show one digit at a time from address buffer
            case digit_index is
                when 0 => current_digit <= address_buffer(3 downto 0);
                when 1 => current_digit <= address_buffer(7 downto 4);
                when others => current_digit <= "0000";
            end case;
        else
            -- Operational mode: Show all four digits from data buffer
            case digit_index is
                when 0 => current_digit <= data_buffer(3 downto 0);
                when 1 => current_digit <= data_buffer(7 downto 4);
                when 2 => current_digit <= data_buffer(11 downto 8);
                when 3 => current_digit <= data_buffer(15 downto 12);
                when others => current_digit <= "0000";
            end case;
        end if;
    end process;

    -- Drive the 7-segment display output
    seg_out <= hex_to_7seg(current_digit);

    -- Drive the digit select lines
    digit_select <= "1110" when digit_index = 0 else
                    "1101" when digit_index = 1 else
                    "1011" when digit_index = 2 else
                    "0111";

end Behavioral;
