library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegment is
    Port (
        clk           : in  STD_LOGIC;             -- Clock from keypad
        reset         : in  STD_LOGIC;             -- Reset signal
        keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit from keypad
        seg_out       : out STD_LOGIC_VECTOR(6 downto 0); -- 7-seg display output
        digit_select  : out STD_LOGIC_VECTOR(3 downto 0)  -- Select lines for the 7-segment displays
    );
end SevenSegment;

architecture Behavioral of SevenSegment is

    component ShiftRegisters
        Generic (
            NUM_ADDR_REGS : integer := 2; -- # of 4-bit registers for address buffer
            NUM_DATA_REGS : integer := 4  -- # of 4-bit registers for data buffer
        );
        Port (
            clk           : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0);
            address_buffer: out STD_LOGIC_VECTOR((NUM_ADDR_REGS * 4 - 1) downto 0);
            data_buffer   : out STD_LOGIC_VECTOR((NUM_DATA_REGS * 4 - 1) downto 0);
            display_mode  : out STD_LOGIC
        );
    end component;

    signal address_buffer : STD_LOGIC_VECTOR(7 downto 0); -- NUM_ADDR_REGS
    signal data_buffer    : STD_LOGIC_VECTOR(15 downto 0); -- NUM_DATA_REGS 
    signal display_mode   : STD_LOGIC;
    signal current_digit  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); -- Current digit
    signal digit_index    : INTEGER range 0 to 3 := 0; -- updates digit

    -- 7-segment encoding 
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

    U_ShiftRegisters: ShiftRegisters
        Generic Map (
            NUM_ADDR_REGS => 2, -- Matches the default for address registers
            NUM_DATA_REGS => 4  -- Matches the default for data registers
        )
        Port Map (
            clk => clk,
            reset => reset,
            keypad_input => keypad_input,
            address_buffer => address_buffer,
            data_buffer => data_buffer,
            display_mode => display_mode
        );

    -- Assign  7-segment output based on the current digit
    process(digit_index, display_mode)
    begin
        if display_mode = '0' then
            -- Address mode
            case digit_index is
                when 0 => current_digit <= address_buffer(3 downto 0); -- Least significant bit
                when 1 => current_digit <= address_buffer(7 downto 4); -- Most sig bit
                when others => current_digit <= "0000"; -- otherwise blak
            end case;
        else
            -- Data mode
            case digit_index is
                when 0 => current_digit <= data_buffer(3 downto 0); -- Least sig bit
                when 1 => current_digit <= data_buffer(7 downto 4);
                when 2 => current_digit <= data_buffer(11 downto 8);
                when 3 => current_digit <= data_buffer(15 downto 12); -- Most sig bit
                when others => current_digit <= "0000"; 
            end case;
        end if;
    end process;

    seg_out <= hex_to_7seg(current_digit);

    -- Digit select
    digit_select <= "1110" when digit_index = 0 else
                    "1101" when digit_index = 1 else
                    "1011" when digit_index = 2 else
                    "0111";

end Behavioral;
