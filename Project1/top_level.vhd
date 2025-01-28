library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
		generic(N: integer := 8);
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
		KEY0        							: IN STD_LOGIC;								-- Pushbutton[3:0]
		GPIO										: INOUT STD_LOGIC_VECTOR(35 downto 0)
		);
end top_level;

---------------------Architecture---------------------------

architecture Structural of top_level is
	
	-------------Component Declaration---------------------
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
    Generic (
	 NUM_SEG_DISPLAY : integer := 4  
	 );
	 Port (
		  
        clk           : in  STD_LOGIC;             -- Clock signal
        reset         : in  STD_LOGIC;             -- Reset signal
		  data_in       : in  STD_LOGIC_VECTOR((NUM_SEG_DISPLAY * 4 - 1) downto 0);
		  data_out		 : out STD_LOGIC_VECTOR((NUM_SEG_DISPLAY * 7 - 1) downto 0)
    );
	end component;

	component SRAM_Controller is
		Port(
			clk,reset					: in std_logic;
			mem							: in std_logic;
			rw								: in std_logic;
			addr							: in std_logic_vector(19 downto 0);
			data_f2s						: in std_logic_vector(15 downto 0);
			ready							: out std_logic;
			data_s2f_r, data_s2f_ur : out std_logic_vector(15 downto 0);
			ad								: out std_logic_vector(19 downto 0);
			we_n, oe_n					: out std_logic;
			dio							: inout std_logic_vector(15 downto 0);
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
	
	component statemachine is
		port(
			Clk :in std_LOGIC;
			reset : in std_logic;
			CountVal: in std_logic_vector(7 downto 0);
			kp_data: in std_logic_vector(4 downto 0);
			kp_pulse: in std_logic;
			stateOut: out std_logic_vector(3 downto 0);
			ReadWriteOut : out std_logic
		);
	end component;
	
	
	component ShiftRegisters is
    Generic (
        NUM_DATA_REGS : integer := 4  -- Number of 4-bit registers for data buffer
    );
    Port (
        clk					: in STD_LOGIC;             -- Clock signal
        reset				: in STD_LOGIC;             -- Reset signal
        keypad_input		: in STD_LOGIC_VECTOR(4 downto 0); -- 5-bit from keypad
		  keypulse			: in std_LOGIC;
        data_out			: out STD_LOGIC_VECTOR((NUM_DATA_REGS * 4 - 1) downto 0) -- Data buffer
    );
	end component;
	-------------------Temp Variables(Internal only)--------------------
	signal Count_clk_enable,clk_enable60ns,clk_enable1hz, Rst		: std_logic;
	signal reset, Counterreset	: std_logic;
  	signal Counterreset_n      : std_logic;	
	signal Qsignal					: std_logic_vector(7 downto 0);
	signal reset_db				: std_logic;
	signal iData					: std_logic_vector(N-1 downto 0);
	signal CountOut				: std_logic_vector(N-1 downto 0);
	signal data2Sram				: std_logic_vector(15 downto 0);
	signal SramReady				: std_logic;
	signal SramAddrIn				: std_logic_vector(19 downto 0);
	signal bReadWrite				: std_logic;
	signal SramActive				: std_logic;
	signal data_outR,data_outUR: std_logic_vector(15 downto 0);
	signal romDataOut				: std_LOGIC_VECTOR(15 downto 0);
	signal oState					: std_logIC_VECTOR(3 downto 0);
	signal L_key_Write			: std_LOGIC;
	signal ShiftAddr	 			: std_LOGIC_VECTOR(7 downto 0);
	signal ShiftData				: std_LOGIC_VECTOR(15 downto 0);
	signal ShiftDisplay			: std_LOGIC;
	signal CntDir					: std_LOGIC;
	signal Cnten					: std_LOGIC;
	signal StateState				: std_LOGIC_VECTOR(1 downto 0);
	signal ErrorVal				: std_logic_vector(3 downto 0);
	signal kp_pulse				: std_LOGIC;
	signal shiftmode				: std_LOGIC;
	signal addrShiftIn			: std_LOGIC_VECTOR(4 downto 0);
	signal dataShiftIn			: std_LOGIC_VECTOR(4 downto 0);
	signal data2Seg				: std_LOGIC_vector(15 downto 0);
	signal Addr2Seg				: std_LOGIC_vector(7 downto 0);
	signal SegData2Board			: std_LOGIC_vector(27 downto 0);
	signal SegAddr2Board			: std_LOGIC_vector(13 downto 0);
	--Signals below are made to satiate inputs and outputs temporaly
	-- unitl we can figure out what goes where
	-----------------------------------------
	signal odata					: std_LOGIC_VECTOR(4 downto 0);
	signal seg_out					: std_LOGIC_VECTOR(6 downto 0);
	signal digit_select			: std_LOGIC_VECTOR(3 downto 0);
	-----------------------------------------
	
begin
	
		Rst 					<= not reset_db;--iReset_n;?
		CounterReset 		<= reset or Rst;
		CounterReset_n  	<= not CounterReset;
		CntDir				<= not oState(1);
		Cnten					<= oState(0);
		StateState			<= oState(3 downto 2);
		------------Entity Instantiation-------------
		Inst_clk_Reset_Delay: Reset_Delay	
				port map(
				  iCLK 		=> iCLK,	
				  oRESET    => reset
					);			

		Inst_reset_debounce: btn_debounce_toggle
			port map(
				BTN_I => KEY0,
				CLK => iCLK,
				BTN_O => Reset_db,
				TOGGLE_O => open,
				PULSE_O => open
			);
					
		Inst_clk_enabler60ns: clk_enabler  
				generic map(
					cnt_max 	=> 2) --Needs to be set to 60 ns
				port map( 
					clock 		=> iclk, 			-- output from sys_clk
					clk_en 		=> clk_enable60ns  -- enable every 10th sys_clk edge
				);
		Inst_clk_enabler1hz: clk_enabler
				generic map(
					cnt_max => 49999999) --Needs to be set to 1hz
				port map(
					clock => iclk,
					clk_en => clk_enable1hz
				);
				
		Inst_univ_bin_counter: univ_bin_counter
			generic map(N => N)
			port map(
				clk 			=> iclk,
				reset 		=> CounterReset,
				syn_clr		=> Rst, 
				load			=> '0', 
				en				=> Cnten, 
				up				=> CntDir, 
				clk_en 		=> Count_clk_enable,
				d				=> iData,
				max_tick		=> open, 
				min_tick 	=> open,
				q				=> CountOut
			);
		Inst_StateMachine: statemachine
			port map(
				clk => iclk,
				reset => counterReset,
				countVal => CountOut,
				kp_data => oData,
				kp_pulse => kp_pulse,
				stateOut => oState,
				ReadWriteOut => L_key_Write
			);
		Inst_kp_controller : kp_controller
			  port map (
				clk         => iclk,
				rows        => GPIO(4 downto 0),
				columns     => GPIO(8 downto 5),
				oData       => oData,
				kp_pulse20    => kp_pulse
			  );

		Inst_SevenSegmentDATA : SevenSegment
			Generic map(NUM_SEG_DISPLAY =>  4  )
			Port map (
				clk           => iclk,
				reset         => counterReset,
				data_in       => data2Seg,
				data_out		 => segData2Board
				);
		Inst_SevenSegmentADDR : SevenSegment
			Generic map(NUM_SEG_DISPLAY => 2)
			Port map (
        clk           => iclk,
        reset         => counterReset,
		  data_in       => Addr2Seg,
		  data_out		 => segAddr2Board
		);
			
		Inst_SRAM_Controller : SRAM_Controller
			PORT map(
			clk			=> iclk,
			reset			=> CounterReset,
			mem			=> SramActive,
			rw				=> bReadWrite,
			addr			=> SramAddrIn,
			data_f2s		=> data2Sram,
			ready			=> SramReady,
			data_s2f_r	=> data_outR,
			data_s2f_ur	=> data_outUR,
			ad				=> SRAM_ADDR,
			we_n			=> SRAM_WE_N,
			oe_n			=> SRAM_OE_N,
			dio			=> SRAM_DQ,
			ce_n			=> SRAM_CE_N
			);
		
		Inst_initRom : initRom
			PORT map (
			address	=> CountOut,
			clock		=> iclk,
			q			=> RomDataOut
			);
		
		Inst_AddrShifters : shiftRegisters
			generic map(Num_DATA_REGS => 2)
			port map(
				clk => iclk,         
				reset => counterReset,
				keypad_input => addrShiftIn,
				keypulse => kp_pulse,
				data_out => ShiftAddr
			);
		
		Inst_dataShifters : shiftRegisters
			generic map(Num_DATA_REGS => 4)
			port map(
				clk => iclk,         
				reset => counterReset,
				keypad_input => dataShiftIn,
				keypulse => kp_pulse,
				data_out => ShiftData
			);
		
		
		
		SevSegMux:process(segData2Board,segAddr2Board)
			begin
				HEX0 <= segData2Board(6 downto 0);
				HEX1 <= segData2Board(13 downto 7);
				HEX2 <= segData2Board(20 downto 14);
				HEX3 <= segData2Board(27 downto 21);
				HEX4 <= segAddr2Board(6 downto 0);
				HEX5 <= segAddr2Board(13 downto 7);
			end process;
		
		
		UCmux:process(iclk,stateState)
			begin		
				if rising_edge(iclk) then
					case StateState is
						when"00" => --Init Mode
							SramActive <= clk_enable60ns;
							Count_clk_enable <= clk_enable60ns;
							SramAddrIn <= (X"000" & countOut);
							bReadWrite <= '0';
							data2Sram <= RomDataOut;
						when"01" => -- OP mode
							SramActive <= clk_enable1hz; -- Does this need to be turned off if system is in pause mode?
							Count_clk_enable <= clk_enable1hz;
							SramAddrIn <= (X"000" & countOut);
							bReadWrite <= '1';
							data2Seg <= data_outR;
							addr2Seg <= countOut;
						when "10" => -- PROG mode
							SramActive <= L_key_Write;
							SramAddrIn <= (X"000" & ShiftAddr); 
							bReadWrite <= '0';
							addrShiftIn <= oData;
						when "11" => -- PROG mode
							SramActive <= L_key_Write;
							data2Sram <= ShiftData;
							bReadWrite <= '0';
							dataShiftIn <= oData;
						when others=> ErrorVal <= "0001";
					end case;		
				end if;
		end process;
end Structural;
