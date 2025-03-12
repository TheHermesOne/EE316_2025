LIBRARY ieee;
   USE ieee.std_logic_1164.all;

ENTITY DE2_115_Board IS
   PORT (
 -- 			Clock Input	 	     
      CLOCK_50    : IN STD_LOGIC;							-- On Board 50 MHz
--      CLOCK2_50   : IN STD_LOGIC;  							-- On Board 50 MHz
--      CLOCK3_50   : IN STD_LOGIC;  							-- On Board 50 MHz	  
--      EXT_CLOCK   : IN STD_LOGIC;							-- External Clock
-- 			Push Button		      
      KEY         : IN STD_LOGIC_VECTOR(3 DOWNTO 0);		-- Pushbutton[3:0]
-- 			DPDT Switch		      
--      SW          : IN STD_LOGIC_VECTOR(17 DOWNTO 0);		-- Toggle Switch[17:0]

-- 			LED		      
--      LEDG        : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);		-- LED Green[8:0]
--      LEDR        : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);		-- LED Red[17:0]
     
-- 			I2C		      
--      I2C_SDAT     : INOUT STD_LOGIC;						-- I2C Data
--      I2C_SCLK     : OUT STD_LOGIC;							-- I2C Clock
---- 			PS2		      
--      PS2_DAT      : INOUT STD_LOGIC;						-- PS2 Data
--      PS2_CLK      : INOUT STD_LOGIC;						-- PS2 Clock
--      PS2_DAT2     : INOUT STD_LOGIC;						-- PS2 Data2
--      PS2_CLK2     : INOUT STD_LOGIC;						-- PS2 Clock2	  		      

--  Mezzanine Card (HSMC) connector (not implemented)	  
-- 			GPIO	      
      GPIO         : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0)	-- GPIO Connection                                                                                                
   );
END DE2_115_Board;

ARCHITECTURE structural OF DE2_115_Board IS

signal BusyOut : std_logic;
signal iData	: std_logic_vector(7 downto 0);

-- TOP LEVEL COMPONENT

component i2c_user_logic_LCD is
		port (
			clk       : IN         	STD_LOGIC;                    --system clock
			reset     : IN         	STD_LOGIC;
			iData     : IN         	string(1 to 16);
			BusyOut	 : OUT 			std_LOGIC;
			sda       : INOUT  		STD_LOGIC;                    --serial data output of i2c bus
			scl       : INOUT  		STD_LOGIC                  --serial clock output of i2c bus
		);
end component i2c_user_logic_LCD;

BEGIN
   
-- INSTANTIATION OF THE TOP LEVEL COMPONENT

Inst_i2c_user_logic_LCD: i2c_user_logic_LCD 
		port map (
			clk 		=> CLOCK_50,
			reset 	=> KEY(0),
			iData		=> "urmomgey        ",
			BusyOut	=> BusyOut,
			sda		=> GPIO(0),
			scl		=> GPIO(1)
		);

END structural;



