LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY i2c_user_logic_tb IS
END i2c_user_logic_tb;

ARCHITECTURE testbench OF i2c_user_logic_tb IS

    -- DUT component
    COMPONENT i2c_user_logic
    PORT(
        clk     : IN     STD_LOGIC;
        iData   : IN     STD_LOGIC_VECTOR(15 DOWNTO 0);
        sda     : INOUT  STD_LOGIC;
        scl     : INOUT  STD_LOGIC
    );
    END COMPONENT;

    -- Testbench signals
    SIGNAL clk      : STD_LOGIC := '0';
    SIGNAL iData    : STD_LOGIC_VECTOR(15 DOWNTO 0) := X"1234";
    SIGNAL sda      : STD_LOGIC := 'Z';
    SIGNAL scl      : STD_LOGIC := 'Z';
    
    CONSTANT clk_period : TIME := 20 ns; -- 50 MHz clock

BEGIN
    -- Instantiate DUT
    uut: i2c_user_logic
    PORT MAP(
        clk   => clk,
        iData => iData,
        sda   => sda,
        scl   => scl
    );
    
    -- Clock process
    clk_process : PROCESS
    BEGIN
        WHILE NOW < 10 ms LOOP  -- Run simulation for 10ms
            clk <= '0';
            WAIT FOR clk_period / 2;
            clk <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;

    
END testbench;
