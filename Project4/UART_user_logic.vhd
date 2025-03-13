LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity UART_user_logic is
	port(
		clk	: IN STD_LOGIC;
		reset	: IN std_LOGIC;
		sendButton :IN std_LOGIC;
		UART_rx	: IN STD_LOGIC;
		UART_tx	: OUT	STD_LOGIC
	);
end UART_user_logic;

ARCHITECTURE logic of UART_user_logic is

component uart is
GENERIC(d_width : INTEGER := 8);
  PORT(
    clk      :  IN   STD_LOGIC;                             --system clock
    reset_n  :  IN   STD_LOGIC;                             --ascynchronous reset
    tx_ena   :  IN   STD_LOGIC;                             --initiate transmission
    tx_data  :  IN   STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
    rx       :  IN   STD_LOGIC;                             --receive pin
    rx_busy  :  OUT  STD_LOGIC;                             --data reception in progress
    rx_error :  OUT  STD_LOGIC;                             --start, parity, or stop bit error detected
    rx_data  :  OUT  STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data received
    tx_busy  :  OUT  STD_LOGIC;                             --transmission in progress
    tx       :  OUT  STD_LOGIC);     
end component;


signal tx_ena : std_LOGIC;
signal rx_data : std_LOGIC_VECTOR(7 downto 0);
signal tx_busy: std_LOGIC;
signal sendbuttonPrev: std_LOGIC;
signal rx_busy			: std_LOGIC;
signal rx_busy_prev	: std_LOGIC;
begin
	inst_uart:uart
	port map(
		clk => clk,
		reset_n => reset,
		tx_ena => tx_ena,
		tx_data => rx_data,
		rx		=> UART_rx,
		rx_busy => rx_busy,
		rx_data => rx_data,
		tx_busy => tx_busy,
		tx		=> UART_tx
	);
		
--		tx_ena <= tx_busy nand '0';
		
		process(clk)
		begin
			if rising_edge(clk) then
				rx_busy_prev <= rx_busy;
				if rx_busy = '0' and rx_busy_prev = '1' then
					tx_ena <= '1';
				else
					tx_ena <= '0';
				end if;
			end if;
		end process;
end logic;