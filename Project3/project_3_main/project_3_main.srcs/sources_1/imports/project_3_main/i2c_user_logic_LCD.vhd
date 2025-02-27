LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity i2c_user_logic_LCD is
PORT(
    clk       : IN         STD_LOGIC;                    --system clock
    reset     : IN         STD_LOGIC;
	 iData     : IN         STD_LOGIC_vector(7 downto 0);
	 BusyOut	  : OUT 			std_LOGIC;
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
end i2c_user_logic_LCD;

ARCHITECTURE logic OF i2c_user_logic_LCD IS

component i2c_master IS
  GENERIC(
    input_clk : INTEGER := 50_000_000; --input clock speed from user logic in Hz
    bus_clk   : INTEGER := 50_000);   --speed the i2c bus (scl) will run at in Hz
  PORT(
    clk       : IN     STD_LOGIC;                    --system clock
    reset_n   : IN     STD_LOGIC;                    --active low reset
    ena       : IN     STD_LOGIC;                    --latch in command
    addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
    rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
    data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
    busy      : OUT    STD_LOGIC;	 				 --indicates transaction in progress
    data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
    ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
END component;

TYPE machine IS(start, ready, writeData); --needed states
signal state		: machine := start;
signal statebuffer  : machine := start;
signal i2c_busy,busy_prev     : STD_LOGIC;                    --indicates transaction in progress
signal data_rd  	: STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
signal i2c_ena   	: STD_LOGIC;                    --latch in command
signal i2c_addr     : STD_LOGIC_VECTOR(7 DOWNTO 0); --address of target slave
signal i2c_rw       : STD_LOGIC;                    --'0' is write, '1' is read
signal byteSel      : integer range 0 to 12 := 0;
signal data_wr		: std_logic_vector(7 downto 0);
signal ack_error	: std_logic;
signal SvnSeg_addr     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
signal LCD_addr     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
signal ADC_addr     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
signal busy_sync   : std_logic_vector(1 downto 0)  := (others => '0');

begin

state <= statebuffer;
SvnSeg_addr <= x"71";
LCD_addr <= x"27";
ADC_addr <= x"90";

inst_i2c_master : i2c_master
port map(
	 clk     	=> clk,           
    reset_n 	=> reset,     
    ena     	=> i2c_ena,
    addr    	=> LCD_addr(6 downto 0),
    rw      	=> '0',
    data_wr 	=> data_wr,
    busy      	=> i2c_busy,                 --indicates transaction in progress
    data_rd   => data_rd,
    ack_error => ack_error,
    sda       => sda,
    scl       => scl
);


process(clk,reset)
begin  
	if reset = '0' then 
		 statebuffer <= start;
		 byteSel <= 0;
	elsif(rising_edge(clk)) then
		CASE state is
			when start =>
				i2c_ena <= '0';
				statebuffer <= ready;
			  when ready => 
				if i2c_busy = '0' then
				  i2c_ena <= '1';
				 statebuffer <= writeData;
				end if; 
--			  when data_valid => 
--				 if i2c_busy = '1' then
--					i2c_ena <= '0';
--					statebuffer <= busy_high;
--				end if;
--			  when busy_high =>
--				if i2c_busy = '0' then
--					statebuffer <= writeData;
--				end if;	
			  when writeData =>
			     if i2c_busy = '0' and busy_prev = '1' then
				    data_wr <= iData;
				 end if;
	  end case;
	end if;  
end process;

process(clk)
begin
	if rising_edge(clk) then
		busy_sync(0) <= i2c_busy;
		busy_sync(1) <= busy_sync(0);
		busyOut <= not busy_sync(1) and busy_sync(0);
	end if;
end process;


end logic;