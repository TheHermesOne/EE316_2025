-- Testbench for SRAM_Controller
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SramCtrl_tb is
end SramCtrl_tb;

architecture Behavioral of SramCtrl_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component SRAM_Controller
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            addr : in STD_LOGIC_VECTOR(15 downto 0);
            data_in : in STD_LOGIC_VECTOR(15 downto 0);
            data_out : out STD_LOGIC_VECTOR(15 downto 0);
            we : in STD_LOGIC;
            oe : in STD_LOGIC;
            cs : in STD_LOGIC
        );
    end component;

    -- Signal declarations
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal addr : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal data_in : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal data_out : STD_LOGIC_VECTOR(15 downto 0);
    signal we : STD_LOGIC := '0';
    signal oe : STD_LOGIC := '0';
    signal cs : STD_LOGIC := '0';

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: SRAM_Controller
        Port map (
            clk => clk,
            reset => reset,
            addr => addr,
            data_in => data_in,
            data_out => data_out,
            we => we,
            oe => oe,
            cs => cs
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Hold reset state for 20 ns.
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Write operation
        addr <= x"0001";
        data_in <= x"ABCD";
        we <= '1';
        cs <= '1';
        wait for clk_period;
        we <= '0';
        cs <= '0';
        
        -- Read operation
        addr <= x"0001";
        oe <= '1';
        cs <= '1';
        wait for clk_period;
        oe <= '0';
        cs <= '0';
        
        -- Extended test cases
        -- Write another value
        addr <= x"0002";
        data_in <= x"1234";
        we <= '1';
        cs <= '1';
        wait for clk_period;
        we <= '0';
        cs <= '0';
        
        -- Read the new value
        addr <= x"0002";
        oe <= '1';
        cs <= '1';
        wait for clk_period;
        oe <= '0';
        cs <= '0';
        
        -- Test invalid address
        addr <= x"FFFF";
        oe <= '1';
        cs <= '1';
        wait for clk_period;
        oe <= '0';
        cs <= '0';

        -- End simulation
        wait;
    end process;

end Behavioral;
