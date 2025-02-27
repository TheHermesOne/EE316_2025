LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity i2c_user_logic_ADC is
PORT(
    clk       	: IN         STD_LOGIC;                    --system clock
    reset    	: IN         STD_LOGIC;
	 Mchnstate		: IN 				Std_LOGIC_VECTOR(3 downto 0);
	 Data_out	: OUT			std_LOGIC_VECTOR(7 downto 0);
    sda       	: INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       	: INOUT  STD_LOGIC);                   --serial clock output of i2c bus
end i2c_user_logic_ADC;

ARCHITECTURE logic OF i2c_user_logic_ADC IS

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

TYPE machine IS(start, ready, writeState, readState); --needed states
signal state		: machine := start;
signal statebuffer  : machine := start;
signal i2c_busy,reset_h     : STD_LOGIC;                    --indicates transaction in progress
signal busy_prev	: STD_LOGIC;
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
signal i2c_busy_prev: std_LOGIC;
signal mode				: std_LOGIC_VECTOR(7 downto 0) := x"00";
signal mchnStatePrev   : Std_LOGIC_VECTOR(3 downto 0);
begin
reset_h <= not reset;
state <= statebuffer;
SvnSeg_addr <= x"71";
LCD_addr <= x"27";
ADC_addr <= x"90";

inst_i2c_master : i2c_master
generic map(
	bus_clk => 250_000
)
port map(
	 clk     	=> clk,           
    reset_n 	=> reset_h,     
    ena     	=> i2c_ena,
    addr    	=> i2c_addr(7 downto 1),
    rw      	=> i2c_rw,
    data_wr 	=> data_wr,
    busy      	=> i2c_busy,                 --indicates transaction in progress
    data_rd   => data_rd,
    ack_error => ack_error,
    sda       => sda,
    scl       => scl
);

process(Mchnstate)
	begin
		Case Mchnstate(1 downto 0) is
			when "00" => mode <= x"00";		--	Photoresistor
			when "01" => mode <= x"01";		--	Thermisor
			when "10" => mode <= x"02";		-- Analog In
			when "11" => mode <= x"03";		-- Potentiometer
		end case;
end process;

process(clk,reset)
begin  

if reset_h = '0' then 
    statebuffer <= start;
    byteSel <= 0;
elsif(rising_edge(clk)) then
	i2c_busy_prev <= i2c_busy;
	mchnStatePrev <= Mchnstate;
	CASE state is
		when start =>
            i2c_ena <= '0';
            statebuffer <= ready;
				i2c_rw <= '0';
        
		  when ready => 
			if i2c_busy = '0' and i2c_busy_prev = '1' then
              i2c_ena <= '1';
				  i2c_rw <= '0';
				  i2c_addr <= ADC_addr;
              data_wr <= mode;				  
             statebuffer <= writeState;
            end if; 
			
		when writeState =>
			if i2c_busy = '0' and i2c_busy_prev = '1' then
				i2c_rw <= '1';
				statebuffer <= readState;
			end if;
			
		when readState => 
			if i2c_busy = '0' and i2c_busy_prev = '1' then
				Data_out <= data_rd;
			elsif(Mchnstate /= mchnStatePrev) then
			     statebuffer <= start;
			end if;
  end case;
end if;  
end process;
end logic;