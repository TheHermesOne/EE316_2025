library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SevenSegment_tb is
-- No ports in the testbench entity
end SevenSegment_tb;

architecture Behavioral of SevenSegment_tb is

    -- Component declaration for the unit under test (UUT)
    component SevenSegment
        Port (
            clk           : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0);
            seg_out       : out STD_LOGIC_VECTOR(6 downto 0);
            digit_select  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal clk           : STD_LOGIC := '0';
    signal reset         : STD_LOGIC := '0';
    signal keypad_input  : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    signal seg_out       : STD_LOGIC_VECTOR(6 downto 0);
    signal digit_select  : STD_LOGIC_VECTOR(3 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: SevenSegment
        Port map (
            clk => clk,
            reset => reset,
            keypad_input => keypad_input,
            seg_out => seg_out,
            digit_select => digit_select
        );

    -- Clock generation process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Reset the system
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        -- Test with keypad input "0010" (decimal 2)
        keypad_input <= "10010";
        wait for clk_period * 10;

        -- Test with keypad input "1010" (hexadecimal A)
        keypad_input <= "01010";
        wait for clk_period * 10;

        -- Test with keypad input "1111" (hexadecimal F)
        keypad_input <= "01111";
        wait for clk_period * 10;

        -- End simulation
        wait;
    end process;

end Behavioral;
