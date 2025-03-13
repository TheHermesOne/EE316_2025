LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity i2c_user_logic_LCD is
PORT(
    clk       : IN         STD_LOGIC;                    --system clock
    reset     : IN         STD_LOGIC;
	 iData     : IN         string(1 to 16);
	 kp_pulse  : IN 			std_LOGIC;
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

component LCD_Data_Cutter is
	port(
		   iCLK                 : IN std_logic;
		   next_data            : IN std_logic;
         reset                : IN std_logic;
			str_in					 : IN string(1 to 16);
			kp_pulse					: in std_logic;
			i2c_ena					: OUT std_logic;
         LCD_Data           : OUT std_logic_vector(11 downto 0) 
		 );
end component; 

TYPE machine IS(start, ready, busy_high, writeData); --needed states
signal state		: machine := start;
signal i2c_busy, busy_prev,busyTemp     : STD_LOGIC;                    --indicates transaction in progress
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
signal byte_cnt	: integer := 1;
signal count_100ms : integer := 0;
signal clk_en_100ms : std_logic;
signal init_data		 : std_logic_vector(7 downto 0);
signal LCD_Data		: STD_LOGIC_VECTOR(11 downto 0);
signal Next_data		: std_logic;
signal LCD_Nibble		: std_LOGIC_vector(47 downto 0);
signal i2c_cnt			: integer range 0 to 5 := 0;
signal i2c_ena_cut	: std_logic;
signal i2c_ena_mux : std_logic;
signal next_data_prev: std_LOGIC;
signal next_data_mux  : std_logic;
begin

next_data_mux <= next_data and not next_data_prev;
SvnSeg_addr <= x"71";
LCD_addr <= x"27";
ADC_addr <= x"90";

inst_LCD_Data_Cutter:LCD_Data_Cutter
	port map(
		iCLK			=> clk,
		reset			=> reset,
		next_data	    => next_data_mux,
		str_in		    => idata,
		kp_pulse		=> kp_pulse,
		i2c_ena		    => i2c_ena_cut,
		LCD_Data		=> LCD_Data
		);

inst_i2c_master : i2c_master
GENERIC MAP(
    input_clk => 125_000_000, --input clock speed from user logic in Hz
    bus_clk => 50_000
    ) 
port map(
	 clk     	=> clk,           
    reset_n 	=> reset,     
    ena     	=> i2c_ena_mux,
    addr    	=> LCD_addr(6 downto 0),
    rw      	=> '0',
    data_wr 	=> init_data,
    busy      	=> i2c_busy,                 --indicates transaction in progress
    data_rd   => data_rd,
    ack_error => ack_error,
    sda       => sda,
    scl       => scl
);

-----------------------------------
--------- i2c enable MUX ----------
-----------------------------------

i2c_ena_mux <= i2c_ena_cut and i2c_ena;

-----------------------------------
--------- 100 ms CLK_en -----------
-----------------------------------

process(clk)
begin

	if rising_edge(clk) then
	  busy_prev <= i2c_busy;
	  next_data_prev <= next_data;
		if count_100ms < 5000000 then
			count_100ms <= count_100ms +1;
			clk_en_100ms <= '0';
		else
			clk_en_100ms <= '1';
--			count_100ms <= 0;
		end if;
	end if;
end process;

-----------------------------
-----Creator of NIBBLES------
-----------------------------

process(LCD_Data)
begin
	LCD_Nibble(7 downto 0)   <= LCD_Data(7 downto 4) & "100" & LCD_Data(8);
	LCD_Nibble(15 downto 8)  <= LCD_Data(7 downto 4) & "110" & LCD_Data(8);
	LCD_Nibble(23 downto 16) <= LCD_Data(7 downto 4) & "100" & LCD_Data(8);    
	LCD_Nibble(31 downto 24) <= LCD_Data(3 downto 0) & "100" & LCD_Data(8);
	LCD_Nibble(39 downto 32) <= LCD_Data(3 downto 0) & "110" & LCD_Data(8);
	LCD_Nibble(47 downto 40) <= LCD_Data(3 downto 0) & "100" & LCD_Data(8);  
end process;

------------------------------
-----SELECTOR OF NIBBLES------
------------------------------

process(i2c_cnt)
begin
	case i2c_cnt is
		when 0 => init_data <= LCD_Nibble(7 downto 0);
		when 1 => init_data <= LCD_Nibble(15 downto 8);
		when 2 => init_data <= LCD_Nibble(23 downto 16);
		when 3 => init_data <= LCD_Nibble(31 downto 24);
		when 4 => init_data <= LCD_Nibble(39 downto 32);
		when 5 => init_data <= LCD_Nibble(47 downto 40);
	end case;
end process;

-----------------------------
--------I2C Process ---------
-----------------------------

process(clk,reset)
begin  
		if reset = '0' then 
			 state <= start;
			 	i2c_cnt <= 0;
		elsif(rising_edge(clk)) and clk_en_100ms = '1' then
			CASE state is
				when start =>
					i2c_ena <= '0';
					state <= ready;
				  when ready => 
					if i2c_busy = '0' then
					  i2c_ena <= '1';
					 state <= busy_high;
					end if; 
				  when busy_high =>
					if i2c_busy = '0' and busy_prev = '1' then
						state <= writeData;
					end if;	
				  when writeData =>
					state <= ready;	-- Resets state diagram
					if i2c_cnt < 5 then
						i2c_cnt <= i2c_cnt + 1;
						next_data <= '0';
					else
						i2c_cnt <= 0;
						next_data <= '1';
					end if;
		  end case;
	end if;
end process;

end logic;