LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY state_machine_tb IS
END state_machine_tb;

ARCHITECTURE behavior OF state_machine_tb IS 
    
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT state_machine
    PORT(
        clk         : IN  std_logic;
        ascii_code  : IN  std_logic_vector(7 downto 0);
        ascii_new   : IN  std_logic;
        state_out   : OUT std_logic_vector(6 downto 0)
    );
    END COMPONENT;
    
    -- Signals to drive the UUT
    SIGNAL clk         : std_logic := '0';
    SIGNAL ascii_code  : std_logic_vector(7 downto 0) := (others => '0');
    SIGNAL ascii_new   : std_logic := '0';
    SIGNAL state_out   : std_logic_vector(6 downto 0);
    
    -- Clock period definition
    CONSTANT clk_period : time := 20 ns;
    
BEGIN
    
    -- Instantiate the Unit Under Test (UUT)
    uut: state_machine PORT MAP (
        clk => clk,
        ascii_code => ascii_code,
        ascii_new => ascii_new,
        state_out => state_out
    );
    
    -- Clock process definitions
    clk_process :PROCESS
    BEGIN
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    END PROCESS;
    
    -- Stimulus process
    stim_proc: PROCESS
    BEGIN	
        -- Wait a bit for initialization
        wait for 20 ns;
        
        -- Simulate entering color state with 'c' (0x63)
        ascii_code <= x"63";
        ascii_new <= '1';
        wait for clk_period;
        ascii_new <= '0';
        wait for 10 * clk_period;
        
        -- Select red (ascii '1' -> 0x31)
        ascii_code <= x"31";
        ascii_new <= '1';
        wait for clk_period;
        ascii_new <= '0';
        wait for 10 * clk_period;
        
        -- Simulate entering cursor state with 'w' (0x77)
        ascii_code <= x"77";
        ascii_new <= '1';
        wait for clk_period;
        ascii_new <= '0';
        wait for 10 * clk_period;
        
        -- Select cursor size 2 (ascii '2' -> 0x32)
        ascii_code <= x"32";
        ascii_new <= '1';
        wait for clk_period;
        ascii_new <= '0';
        wait for 10 * clk_period;
        
        -- Simulate entering screen state with 's' (0x73)
        ascii_code <= x"73";
        ascii_new <= '1';
        wait for clk_period;
        ascii_new <= '0';
        wait for 10 * clk_period;
        
        -- Set screen to doubled (ascii '1' -> 0x31)
        ascii_code <= x"32";
        ascii_new <= '1';
        wait for clk_period;
        ascii_new <= '0';
        wait for 10 * clk_period;
        
        -- Finish simulation
        wait for 50 ns;

        wait;
    END PROCESS;
END behavior;
