LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity i2c_user_logic_LCD is
PORT(
    clk       : IN         STD_LOGIC;                    --system clock
    reset     : IN         STD_LOGIC;
--	 iData     : IN         STD_LOGIC_vector(7 downto 0);
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

begin


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
    data_wr 	=> init_data,
    busy      	=> i2c_busy,                 --indicates transaction in progress
    data_rd   => data_rd,
    ack_error => ack_error,
    sda       => sda,
    scl       => scl
);

--------- 100 ms CLK_en -----------

process(clk)
begin
	if rising_edge(clk) then
		if count_100ms < 5000000 then
			count_100ms <= count_100ms +1;
			clk_en_100ms <= '0';
		else
			clk_en_100ms <= '1';
--			count_100ms <= 0;
		end if;
	end if;
end process;


------------------------------------
------LCD BYTE_CNT DATA SELECT------
------------------------------------

process(byte_cnt)
begin
    case byte_cnt is

        -- 0X30 upload 1
        when 1 => init_data <= X"38";
        when 2 => init_data <= X"3C";
        when 3 => init_data <= X"38";
        when 4 => init_data <= X"08";
        when 5 => init_data <= X"0C";
        when 6 => init_data <= X"08";
        -- 0X30 upload 2
        when 7 => init_data <= X"38";
        when 8 => init_data <= X"3C";
        when 9 => init_data <= X"38";
        when 10 => init_data <= X"08";
        when 11 => init_data <= X"0C";
        when 12 => init_data <= X"08";
        -- 0X30 upload 3
        when 13 => init_data <= X"38";
        when 14 => init_data <= X"3C";
        when 15 => init_data <= X"38";
        when 16 => init_data <= X"08";
        when 17 => init_data <= X"0C";
        when 18 => init_data <= X"08";
        -- 0x20 upload 
        when 19 => init_data <= X"28";
        when 20 => init_data <= X"2C";
        when 21 => init_data <= X"28";
        when 22 => init_data <= X"08";
        when 23 => init_data <= X"0C";
        when 24 => init_data <= X"08";
        -- 0x28 upload 
        when 25 => init_data <= X"28";
        when 26 => init_data <= X"2C";
        when 27 => init_data <= X"28";
        when 28 => init_data <= X"88";
        when 29 => init_data <= X"8C";
        when 30 => init_data <= X"88";
        -- 0x06 upload  -- testing 0x08
        when 31 => init_data <= X"08";
        when 32 => init_data <= X"0C";
        when 33 => init_data <= X"08";
        when 34 => init_data <= X"88";
        when 35 => init_data <= X"8C";
        when 36 => init_data <= X"88";
        -- 0x01 upload  -- testing 0x01
        when 37 => init_data <= X"08";
        when 38 => init_data <= X"0C";
        when 39 => init_data <= X"08";
        when 40 => init_data <= X"18";
        when 41 => init_data <= X"1C";
        when 42 => init_data <= X"18";
        -- 0x0F upload -- testing 0x06
        when 43 => init_data <= X"08";
        when 44 => init_data <= X"0C";
        when 45 => init_data <= X"08";
        when 46 => init_data <= X"68";
        when 47 => init_data <= X"6C";
        when 48 => init_data <= X"68";
		  -- testing 0x0C
        when 49 => init_data <= X"08";
        when 50 => init_data <= X"0C";
        when 51 => init_data <= X"08";
        when 52 => init_data <= X"C8";
        when 53 => init_data <= X"CC";
        when 54 => init_data <= X"C8";
		  -- DATA 0x42 upload -- testing 0x0c
        when 55 => init_data <= X"49";
        when 56 => init_data <= X"4D";
        when 57 => init_data <= X"49";
        when 58 => init_data <= X"29";
        when 59 => init_data <= X"2D";
        when 60 => init_data <= X"29";
        -- DATA 0x45 upload 
        when 61 => init_data <= X"49";
        when 62 => init_data <= X"4D";
        when 63 => init_data <= X"49";
        when 64 => init_data <= X"59";
        when 65 => init_data <= X"5D";
        when 66 => init_data <= X"59";
        -- DATA 0x45 upload 
        when 67 => init_data <= X"49";
        when 68 => init_data <= X"4D";
        when 69 => init_data <= X"49";
        when 70 => init_data <= X"59";
        when 71 => init_data <= X"5D";
        when 72 => init_data <= X"59";
        -- DATA 0x46 upload
        when 73 => init_data <= X"49";
        when 74 => init_data <= X"4D";
        when 75 => init_data <= X"49";
        when 76 => init_data <= X"69";
        when 77 => init_data <= X"6D";
        when 78 => init_data <= X"69";
        
        when others => init_data <= X"20";
    end case;
end process;

process(clk,reset)
begin  
		if reset = '0' then 
			 state <= start;
			 byte_cnt <= 1;
	 
		elsif(rising_edge(clk)) and clk_en_100ms = '1' then
         busy_prev <= i2c_busy;
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
					if byte_cnt < 78 then
						byte_cnt <= byte_cnt +1;
					else 
						i2c_ena <= '0';
					end if; 
		  end case;
--		end if;  
	end if;
end process;

--process(i2c_busy)
--begin
--busy_prev <= i2c_busy;
--	if i2c_busy = '0' and busy_prev = '1' then
--		busyTemp <= '1';
--	else
--		busyTemp <= '0';
--	end if;
--end process;
--
--process(clk)
--begin
--	if rising_edge(clk) then
--		busy_sync(0) <= busyTemp;
--		busy_sync(1) <= busy_sync(0);
--		busyOut <= not busy_sync(1) and busy_sync(0);
--	end if;
--end process;


end logic;