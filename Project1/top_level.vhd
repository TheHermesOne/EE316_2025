
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity top_level is
		generic(N: integer := 4);
		port (
		iClk										: in std_logic;
		HEX0,HEX1,HEX2,HEX3,HEX4,HEX5		: out std_LOGIC_VECTOR(6 downto 0);
		SRAM_DQ     							: INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);	-- SRAM Data bus 16 Bits
      SRAM_ADDR   							: OUT STD_LOGIC_VECTOR(19 DOWNTO 0);	-- SRAM Address bus 18 Bits
      SRAM_UB_N  								: OUT STD_LOGIC;							-- SRAM High-byte Data Mask
      SRAM_LB_N  								: OUT STD_LOGIC;							-- SRAM Low-byte Data Mask
      SRAM_WE_N   							: OUT STD_LOGIC;							-- SRAM Write Enable
      SRAM_CE_N   							: OUT STD_LOGIC;							-- SRAM Chip Enable
      SRAM_OE_N   							: OUT STD_LOGIC;							-- SRAM Output Enable
		LEDG0       							: OUT STD_LOGIC;							-- LED Green[8:0]
		KEY0        							: IN STD_LOGIC								-- Pushbutton[3:0]
		);
end top_level;

architecture Structural of top_level is
	
	component univ_bin_counter is
		generic(N: integer := 8);
		port(
			clk, reset					: in std_logic;
			syn_clr, load, en, up	: in std_logic;
			clk_en 						: in std_logic := '1';			
			d								: in std_logic_vector(N-1 downto 0);
			max_tick, min_tick		: out std_logic;
			q								: out std_logic_vector(N-1 downto 0)
		);
	end component;

	component clk_enabler is
		 GENERIC (
			CONSTANT cnt_max : integer := 49999999);      --  1.0 Hz 	
		 PORT(	
			clock			 	: in std_logic;	 
			clk_en			: out std_logic
		);
	end component;
	
	component btn_debounce_toggle is
		GENERIC(
			CONSTANT CNTR_MAX : std_logic_vector(15 downto 0) := X"FFFF");  
    Port ( BTN_I 	: in  STD_LOGIC;
           CLK 		: in  STD_LOGIC;
           BTN_O 	: out  STD_LOGIC;
           TOGGLE_O : out  STD_LOGIC;
				PULSE_O  : out STD_LOGIC);
	end component;
	
	component Reset_Delay IS	
		 PORT (
			  SIGNAL iCLK 		: IN std_logic;	
			  SIGNAL oRESET 	: OUT std_logic
				);	
	end component;	

	component KP_Controller is 
		Port ( 
        clk         : in  std_logic;  
        rows        : in  std_logic_vector(4 downto 0);
        columns     : out std_logic_vector(3 downto 0);
        oData       : out std_logic_vector(4 downto 0);
        kp_pulse20  : out std_logic
		);
	end component; 	

	component SevenSegment is
		Port (
        		clk           		: in  STD_LOGIC;    -- Clock from keypad
       		reset         		: in  STD_LOGIC;            -- Reset signal
        		keypad_input  		: in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit input from keypad
        		seg_out       		: out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment output
        		digit_select  		: out STD_LOGIC_VECTOR(3 downto 0)  -- choose 7 segment
   		 );
	end component;


	component SRAM_Controller is
		Port(
			clk,reset					: in std_logic;
			mem							: in std_logic;
			rw								: in std_logic;
			addr							: in std_logic_vector(7 downto 0);
			data_f2s						: in std_logic_vector(7 downto 0);
			ready							: out std_logic;
			data_s2f_r, data_s2f_ur : out std_logic_vector(7 downto 0);
			ad								: out std_logic_vector(18 downto 0);
			we_n, oe_n					: out std_logic;
			dio							: inout std_logic_vector(7 downto 0);
			ce_n							: out std_logic
		);
		end component;

	
	component initRom is
		Port(
			address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	end component;

	signal clk						: std_logic;
	signal clk_enable, Rst		: std_logic;
	signal reset, Counterreset	: std_logic;
  	signal Counterreset_n      : std_logic;	
	signal Qsignal					: std_logic_vector(7 downto 0);
	signal reset_db				: std_logic;
	
	--Signals below are made to satiate inputs and outputs temporaly
	-- unitl we can figure out what goes where
	-----------------------------------------
	signal rows        			: std_logic_vector(4 downto 0); 
   signal columns     			: std_logic_vector(3 downto 0);
	signal odata					: std_LOGIC_VECTOR(4 downto 0);
	signal clk_en_out				: std_LOGIC;
	signal kp_pulse				: std_LOGIC;
	signal et_pulse				: std_LOGIC;
	signal keypad_input			: std_LOGIC_VECTOR(4 downto 0);
	signal seg_out					: std_LOGIC_VECTOR(6 downto 0);
	signal digit_select			: std_LOGIC_VECTOR(3 downto 0);
	-----------------------------------------
	
begin
	
		Rst 					<= not reset_db;--iReset_n;
		CounterReset 		<= reset or Rst;
		CounterReset_n  	<= not CounterReset;
		
		Inst_clk_Reset_Delay: Reset_Delay	
				port map(
				  iCLK 		=> iCLK,	
				  oRESET    => reset
					);			

		Inst_btn_debounce: btn_debounce_toggle
			port map(
				BTN_I => KEY0,
				CLK => iCLK,
				BTN_O => Reset_db,
				TOGGLE_O => open,
				PULSE_O => open
			);
					
		Inst_clk_enabler: clk_enabler
				generic map(
					cnt_max 		=> 9)
				port map( 
					clock 		=> clk, 			-- output from sys_clk
					clk_en 		=> clk_enable  -- enable every 10th sys_clk edge
				);
				
		Inst_univ_bin_counter: univ_bin_counter
			generic map(N => N)
			port map(
				clk 			=> clk,
				reset 		=> CounterReset,
				syn_clr		=> Rst, 
				load			=> iLoad, 
				en				=> iCnt_en, 
				up				=> iUP, 
				clk_en 		=> clk_enable,
				d				=> iData,
				max_tick		=> oMax, 
				min_tick 	=> oMin,
				q				=> oQ
			);
		
		Inst_kp_controller : kp_controller
			  port map (
				clk         => clk,
				rows        => rows,
				columns     => columns,
				oData       => oData,
				kp_pulse20    => kp_pulse
			  );

		Inst_SevenSegment : SevenSegment
			Port map(
				clk           => clk,          
				reset         => reset,        
				keypad_input  => keypad_input,
				seg_out       => seg_out,
				digit_select  => digit_select
				 );
			
		Inst_SRAM_Controller : SRAM_Controller
			PORT map(
			clk			=> clk,
			reset			=> reset_db,
			mem			=> mem,
			rw				=> rw,
			addr			=> addr,
			data_f2s		=> data_f2s,
			ready			=> ready,
			data_s2f_r	=> data_s2f_r,
			data_s2f_ur	=> data_s2f_ur,
			ad				=> SRAM_ADDR,
			we_n			=> SRAM_WE_N,
			ow_n			=> SRAM_OE_N,
			dio			=> SRAM_DQ,
			ce_n			=> SRAM_CE_N
			);
		
		Inst_initRom : initRom
			PORT map (
			address	=> address,
			clock		=> clock,
			q			=> q
			);
			
		
		
end Structural;
