LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity i2c_user_logic is
PORT(
    clk       : IN     STD_LOGIC;                    --system clock
	 iData     : IN  	  STD_LOGIC_vector(15 downto 0);
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
end i2c_user_logic;

ARCHITECTURE logic OF i2c_user_logic IS

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
    busy      : OUT    STD_LOGIC;	 					  --indicates transaction in progress
    data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
    ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
END component;

TYPE machine IS(start, write_data, repeat); --needed states
signal cont			: unsigned(19 downto 0):=X"03FFF";
signal state		: machine;
signal reset_n   	: STD_LOGIC;                    --active low reset
signal i2c_busy   : STD_LOGIC;                    --indicates transaction in progress
signal busy_prev	: STD_LOGIC;
signal data_rd  	: STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
signal i2c_ena   	: STD_LOGIC;                    --latch in command
signal i2c_addr   : STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
signal i2c_rw        	: STD_LOGIC;                    --'0' is write, '1' is read
signal byteSel    : integer range 0 to 12 := 0;
signal i2c_data_wr: std_logic_vector(7 downto 0);
signal data_wr		: std_logic_vector(7 downto 0);
signal ack_error	: std_logic;
begin

inst_i2c_master : i2c_master
port map(
	 clk     	=> clk,           
    reset_n 	=> reset_n,     
    ena     	=> i2c_ena,
    addr    	=> i2c_addr,
    rw      	=> i2c_rw,
    data_wr 	=> data_wr,
    busy      	=> i2c_busy,                 --indicates transaction in progress
    data_rd   => data_rd,
    ack_error => ack_error,
    sda       => sda,
    scl       => scl
);

process(clk)
begin  
if(rising_edge(clk)) then
  CASE state is
		when start =>
			if cont /= X"00000" then
				cont 	  	<= cont - 1;
				reset_n 	<= '0';
				state 	<= start;
				i2c_ena 	<= '0';
			else
				reset_n 		<= '1';
				i2c_ena 		<= '1';
				i2c_addr	 	<= "1110001";
				i2c_rw 		<= '0';
				state			<= write_data;
			end if;
  when write_data =>		
		busy_prev <= i2c_busy;
			if byteSel =< 12 then
				if i2c_busy = '0' and busy_prev = '1' then
					byteSel <= byteSel + 1;
				end if;
			else 
				byteSel <= 9;
				state <= repeat;
			end if;
				
  when repeat =>
    byteSel <= 0; 
	 i2c_ena <= '0';
    if i2c_busy = '0' then  
        state <= start; 
    else
        state <= repeat; 
	 end if;
  when others => null;

  end case; 
end if;  
end process;
		i2c_data_wr <= data_wr;
process(byteSel)
begin
	case byteSel is
		when 0  => data_wr <= X"76";
		when 1  => data_wr <= X"76";
		when 2  => data_wr <= X"76";
		when 3  => data_wr <= X"7A";
		when 4  => data_wr <= X"FF";
		when 5  => data_wr <= X"77";
		when 6  => data_wr <= X"00";
		when 7  => data_wr <= X"79";
		when 8  => data_wr <= X"00";
		when 9  => data_wr <= X"0"&iData(15 downto 12);
		when 10 => data_wr <= X"0"&iData(11 downto 8);
		when 11 => data_wr <= X"0"&iData(7 downto 4);
		when 12 => data_wr <= X"0"&iData(3 downto 0);
		when others => data_wr <= X"76";
	end case;
end process;



end logic;