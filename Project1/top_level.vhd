
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity top_level is
		generic(N: integer := 4);
		port (
		iReset_n				: in std_logic; 
		iClk					: in std_logic; 
		rows					: in std_logic_vector (3 downto 0);
		columns					: out std_logic_vector(4 downto 0);
		HEX0					: out std_LOGIC_VECTOR(6 downto 0);
		HEX1					: out std_LOGIC_VECTOR(6 downto 0);
		HEX2					: out std_LOGIC_VECTOR(6 downto 0);
		HEX3					: out std_LOGIC_VECTOR(6 downto 0);
		HEX4					: out std_LOGIC_VECTOR(6 downto 0);
		HEX5					: out std_LOGIC_VECTOR(6 downto 0)		
		);
end top_level;

architecture Structural of top_level is
	
	component univ_bin_counter is
		generic(N: integer := 8);
		port(
			clk, reset		: in std_logic;
			syn_clr, load, en, up	: in std_logic;
			clk_en 			: in std_logic := '1';			
			d			: in std_logic_vector(N-1 downto 0);
			max_tick, min_tick	: out std_logic;
			q			: out std_logic_vector(N-1 downto 0)
		);
	end component;

	component clk_enabler is
		 GENERIC (
			CONSTANT cnt_max : integer := 49999999);      --  1.0 Hz 	
		 PORT(	
			clock			 : in std_logic;	 
			clk_en			 : out std_logic
		);
	end component;

	component Reset_Delay IS	
		 PORT (
			  SIGNAL iCLK 		: IN std_logic;	
			  SIGNAL oRESET 	: OUT std_logic
				);	
	end component;	

	component KP_Controller is 
		Port ( 
			clk         		: in  std_logic;  
        		rows        		: in  std_logic_vector(4 downto 0); 
        		columns     		: out std_logic_vector(3 downto 0);
       			oData       		: out std_logic_vector(4 downto 0);
        		clk_en_out  		: out std_logic; -- 5ms clock enable
       			kp_pulse    		: out std_logic; -- 5ms for debouncing
        		et_pulse    		: out std_logic -- edge detector pulse
		);
	end component; 	

	component SevenSegment is
		Port (
        		clk           		: in  STD_LOGIC;             -- Clock signal from the keypad logic
       			reset         		: in  STD_LOGIC;             -- Reset signal
        		keypad_input  		: in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit input from keypad
        		seg_out       		: out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment display output
        		digit_select  		: out STD_LOGIC_VECTOR(3 downto 0)  -- Select lines for the 7-segment displays
   		 );
		
	component SRAM is
		Port (
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);

	component SRAM_Controller is
		Port(
			clk,reset		: in std_logic;
			mem			: in std_logic;
			rw			: in std_logic;
			addr			: in std_logic_vector(7 downto 0);
			data_f2s		: in std_logic_vector(7 downto 0);
			ready			: out std_logic;
			data_s2f_r, data_s2f_ur : out std_logic_vector(7 downto 0);
			ad			: out std_logic_vector(18 downto 0);
			we_n, oe_n		: out std_logic;
			dio			: inout std_logic_vector(7 downto 0);
			ce_n			: out std_logic
		);
	
	component initRom is
		Port(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	
	signal clk					: std_logic;
	signal clk_enable, Rst				: std_logic;
	signal reset, Counterreset			: std_logic;
  	signal Counterreset_n        			: std_logic;	
	signal Qsignal					: std_logic_vector(7 downto 0);

	begin
	
  	Rst 			<= not iReset_n;
	CounterReset 		<= reset or Rst;
	CounterReset_n  	<= not CounterReset;
	
	Inst_clk_Reset_Delay: Reset_Delay	
			port map(
			  iCLK 		=> iCLK,	
			  oRESET    => reset
				);			

	Inst_clk_enabler: clk_enabler
			generic map(
			cnt_max 		=> 9)
			port map( 
			clock 		=> clk, 			-- output from sys_clk
			clk_en 		=> clk_enable  -- enable every 10th sys_clk edge
			);
			
--		
--	Inst_univ_bin_counter: univ_bin_counter
--		generic map(N => N)
--		port map(
--			clk 			=> clk,
--			reset 		=> CounterReset,
--			syn_clr		=> Rst, 
--			load			=> iLoad, 
--			en				=> iCnt_en, 
--			up				=> iUP, 
--			clk_en 		=> clk_enable,
--			d				=> iData,
--			max_tick		=> oMax, 
--			min_tick 	=> oMin,
--			q				=> oQ
--		);
-			
	Inst_kp_controller : kp_controller
		  port map (
		 	clk         => clk,
        		rows        => rows,
        		columns     => columns,
       			oData       => oData,
        		clk_en_out  => clk_en_out,
       			kp_pulse    => kp_pulse,
        		et_pulse    => et_pulse
		  );

	Inst_SevenSegment : SevenSegment
		Port (
        		clk           => clk,          
       			reset         => reset,        
        		keypad_input  => keypad_input,
        		seg_out       => seg_out,
        		digit_select  => digit_select,
   		 );
		
	Inst_SRAM : SRAM
		PORT (
		address		=> address,
		clock		=> clock,
		data		=> data,
		wren		=> wren,
		q		=> q
	);
		
	Inst_SRAM_Controller : SRAM_Controller
		PORT(
		clk		=> clk,
		reset		=> reset,
		mem		=> mem,
		rw		=> rw,
		addr		=> addr,
		data_f2s	=> data_f2s,
		ready		=> ready,
		data_s2f_r	=> data_s2f_r,
		data_s2f_ur	=> data_s2f_ur,
		ad		=> ad,
		we_n		=> we_n,
		ow_n		=> ow_n,
		dio		=> dio,
		ce_n		=> ce_n,
		);
	
	Inst_initRom : initRom
		PORT(
		address		=> address,
		clock		=> clock,
		q		=> q
		);
end Structural;
