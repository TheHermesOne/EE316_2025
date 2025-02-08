LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity i2c_user_logic is
PORT(
    clk       : IN     STD_LOGIC;                    --system clock
    data_wr   : out     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
end i2c_user_logic;

ARCHITECTURE logic OF i2c_user_logic IS

component i2c_master IS
  GENERIC(
    input_clk : INTEGER := 100_000_000; --input clock speed from user logic in Hz
    bus_clk   : INTEGER := 400_000);   --speed the i2c bus (scl) will run at in Hz
  PORT(
    clk       : IN     STD_LOGIC;                    --system clock
    reset_n   : IN     STD_LOGIC;                    --active low reset
    ena       : IN     STD_LOGIC;                    --latch in command
    addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
    rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
    data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
    busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
    data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
    ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
END component;

TYPE machine IS(start, write_data, repeat,); --needed states
signal cont			: unsigned(19 downto 0):=X"03FFF";
signal state		: machine;
signal reset_n   	: STD_LOGIC;                    --active low reset
signal busy    	: STD_LOGIC;                    --indicates transaction in progress
signal data_rd  	: STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
signal i2c_ena   	: STD_LOGIC;                    --latch in command
signal addr      	: STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
signal rw        	: STD_LOGIC;                    --'0' is write, '1' is read


process(clk)
begin
	if(clk'EVENT and clk = '1') then
		CASE state is
			when start =>
				if cont /= X"00000" then
					cont 	  	<= cont - 1;
					reset_n 	<= '0';
					state 	<= start;
					i2c_ena 	<= 0;
				else
					reset_n 		<= '1';
					i2c_ena 		<= '1';
					i2c_addr	 	<= slave_addr;
					i2c_rw 		<= '0';
					i2c_data_wr <= data_wr;
					state			<= write_data;
				end if
			when write_data =>
					
			
			when repeat =>
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

inst_i2c_master : i2c_master
	 clk     => clk           
    reset_n => reset_n     
    ena     
    addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
    rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
    data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
    busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
    data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
    ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
