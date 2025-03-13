LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY uart_tb IS
END uart_tb;

ARCHITECTURE behavior OF uart_tb IS
    -- Component declaration of the UART entity
    COMPONENT uart
        PORT (
            reset       : IN  std_logic;
            txclk       : IN  std_logic;
            ld_tx_data  : IN  std_logic;
            tx_data     : IN  std_logic_vector(7 DOWNTO 0);
            tx_enable   : IN  std_logic;
            tx_out      : OUT std_logic;
            tx_empty    : OUT std_logic;
            rxclk       : IN  std_logic;
            uld_rx_data : IN  std_logic;
            rx_enable   : IN  std_logic;
            rx_in       : IN  std_logic;
            rx_empty    : OUT std_logic;
            rx_data     : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Signals for the UART ports
    SIGNAL reset       : std_logic := '0';
    SIGNAL txclk       : std_logic := '0';
    SIGNAL ld_tx_data  : std_logic := '0';
    SIGNAL tx_data     : std_logic_vector(7 DOWNTO 0) := "00000000";
    SIGNAL tx_enable   : std_logic := '1';
    SIGNAL tx_out      : std_logic;
    SIGNAL tx_empty    : std_logic;
    SIGNAL rxclk       : std_logic := '0';
    SIGNAL uld_rx_data : std_logic := '0';
    SIGNAL rx_enable   : std_logic := '1';
    SIGNAL rx_in       : std_logic := '0';
    SIGNAL rx_empty    : std_logic;
    SIGNAL rx_data     : std_logic_vector(7 DOWNTO 0);
    
    -- Clock period definitions
    CONSTANT clk_period : time := 10 ns;
    
BEGIN
    -- Instantiate the UART component
    uut: uart PORT MAP (
        reset       => reset,
        txclk       => txclk,
        ld_tx_data  => ld_tx_data,
        tx_data     => tx_data,
        tx_enable   => tx_enable,
        tx_out      => tx_out,
        tx_empty    => tx_empty,
        rxclk       => rxclk,
        uld_rx_data => uld_rx_data,
        rx_enable   => rx_enable,
        rx_in       => rx_in,
        rx_empty    => rx_empty,
        rx_data     => rx_data
    );
    
    -- Clock generation for txclk and rxclk
    txclk_process : PROCESS
    BEGIN
        txclk <= '0';
        WAIT FOR clk_period/2;
        txclk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    rxclk_process : PROCESS
    BEGIN
        rxclk <= '0';
        WAIT FOR clk_period/2;
        rxclk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- Stimulus process to apply inputs and test the UART functionality
    stimulus_process: PROCESS
    BEGIN
        -- Reset the UART
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        
        -- Transmit a byte (example: 8'b01010101 = 0x55)
        tx_data <= "01010101";
        ld_tx_data <= '1';  -- Load data into the transmitter
        WAIT FOR clk_period;  -- Wait for one clock cycle
        ld_tx_data <= '0';   -- Stop loading data
        
        -- Wait for transmission to complete
        WAIT FOR 90 ns;  -- Total transmission time (9 clock cycles)
        
        -- Test receiving data (simulate input on rx_in)
        rx_in <= '1';    -- Simulate receiving a '1'
        WAIT FOR clk_period;
        rx_in <= '0';    -- Simulate receiving a '0'
        WAIT FOR clk_period;
        rx_in <= '1';    -- Simulate receiving another '1'
        WAIT FOR clk_period;
        -- Repeat for more bits to complete a byte or frame
        
        -- Wait to observe rx_data output
        WAIT FOR 100 ns;

        -- Finish the simulation
        WAIT;
    END PROCESS;
    
END behavior;
