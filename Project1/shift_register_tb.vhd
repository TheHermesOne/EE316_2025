-- testbench_shift_registers.vhd
-- Description: Testbench for the ShiftRegisters module.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Testbench_ShiftRegisters is
end Testbench_ShiftRegisters;

architecture Behavioral of Testbench_ShiftRegisters is

    -- Component declaration for the Unit Under Test (UUT)
    component ShiftRegisters
        Generic (
            NUM_ADDR_REGS : integer := 2;
            NUM_DATA_REGS : integer := 4
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

    -- Signals for connecting to UUT
    signal clk           : STD_LOGIC := '0';
    signal reset         : STD_LOGIC := '0';
    signal keypad_input  : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal address_buffer: STD_LOGIC_VECTOR(7 downto 0);
    signal data_buffer   : STD_LOGIC_VECTOR(15 downto 0);
    signal display_mode  : STD_LOGIC;

    -- Clock generation
    constant CLK_PERIOD : time := 10 ns;

    -- Procedure to generate a clock signal
    process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: ShiftRegisters
        Generic Map (
            NUM_ADDR_REGS => 2,
            NUM_DATA_REGS => 4
        )
        Port Map (
            clk => clk,
            reset => reset,
            keypad_input => keypad_input,
            address_buffer => address_buffer,
            data_buffer => data_buffer,
            display_mode => display_mode
        );

    -- Stimulus process
    process
    begin
        -- Reset the system
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Test Address Mode (MSB = 0)
        keypad_input <= "00001"; -- Input 1
        wait for 10 ns;
        keypad_input <= "00010"; -- Input 2
        wait for 10 ns;

        -- Test Data Mode (MSB = 1)
        keypad_input <= "10011"; -- Input 3
        wait for 10 ns;
        keypad_input <= "10100"; -- Input 4
        wait for 10 ns;

        -- Wait for a while to observe results
        wait for 100 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
