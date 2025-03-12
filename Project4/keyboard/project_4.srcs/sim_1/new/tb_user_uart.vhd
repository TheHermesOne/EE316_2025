-------------------------------------------------------
-- Testbench for UART
-------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_user_uart is
end tb_user_uart;

architecture sim of tb_user_uart is

    -- Signal declaration
    signal reset       : std_logic := '0';
    signal txclk       : std_logic := '0';  -- Baud rate clock
    signal ld_tx_data  : std_logic := '0';  -- Load TX data pulse
    signal tx_data     : std_logic_vector(7 downto 0) := (others => '0');  -- TX data
    signal tx_enable   : std_logic := '0';  -- Enable TX
    signal tx_out      : std_logic := '0';  -- TX output
    
    signal rxclk       : std_logic := '0';  -- Baud rate clock for RX
    signal uld_rx_data : std_logic := '0';  -- Unload RX data pulse
    signal rx_enable   : std_logic := '1';  -- Enable RX
    signal rx_in       : std_logic := '1';  -- RX input signal
    signal rx_empty    : std_logic := '1';  -- RX empty signal
    signal rx_data     : std_logic_vector(7 downto 0) := (others => '0');  -- RX data
    signal tx_empty    : std_logic;

begin

    -- Instantiate the UART component
    uut: entity work.uart
    port map (
        reset       => reset,
        txclk       => txclk,
        ld_tx_data  => ld_tx_data,
        tx_data     => tx_data,
        tx_enable   => tx_enable,
        tx_out      => tx_out,
        tx_empty    => tx_empty,  -- Not used
        rxclk       => rxclk,
        uld_rx_data => uld_rx_data,
        rx_enable   => rx_enable,
        rx_in       => rx_in,
        rx_empty    => rx_empty,
        rx_data     => rx_data
    );

    -- Clock generation for txclk and rxclk
    txclk_process :process
    begin
        txclk <= '0';
        wait for 10 ns;
        txclk <= '1';
        wait for 10 ns;
    end process;

    rxclk_process :process
    begin
        rxclk <= '0';
        wait for 10 ns;
        rxclk <= '1';
        wait for 10 ns;
    end process;
process
begin 
wait for 400 ns; 

        
        
    end process;

end architecture;

