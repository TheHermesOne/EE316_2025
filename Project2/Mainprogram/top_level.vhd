
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top_level is
  port (
    iClk      : in std_logic;
    LCD_EN    : out std_logic; -- LCD Enable
    LCD_RS    : out std_logic; -- LCD Command/Data Select, 0 = Command, 1 = Data
    LCD_DATA  : inout std_logic_vector(7 downto 0); -- LCD Data bus 8 bits
    I2C_SDAT  : inout std_logic; -- I2C Data
    I2C_SCLK  : out std_logic; -- I2C Clock
    SRAM_DQ   : inout std_logic_vector(15 downto 0); -- SRAM Data bus 16 Bits
    SRAM_ADDR : out std_logic_vector(19 downto 0); -- SRAM Address bus 18 Bits
    SRAM_UB_N : out std_logic; -- SRAM High-byte Data Mask
    SRAM_LB_N : out std_logic; -- SRAM Low-byte Data Mask
    SRAM_WE_N : out std_logic; -- SRAM Write Enable
    SRAM_CE_N : out std_logic; -- SRAM Chip Enable
    SRAM_OE_N : out std_logic; -- SRAM Output Enable
    KEY       : in std_logic_vector(3 downto 0); -- Pushbutton[3:0]
    GPIO      : inout std_logic_vector(35 downto 0)
  );
end top_level;

---------------------Architecture---------------------------

architecture Structural of top_level is

  -------------Component Declaration---------------------
  component var_size_counter is
    generic (N : integer := 8);
    port (
      clk, reset : in std_logic;
      syn_clr    : in std_logic;
      en, up     : in std_logic;
      CountStep  : in integer   := 1;
      clk_en     : in std_logic := '1';
      q          : out std_logic_vector(N - 1 downto N - 8) -- takes only the first 8 bits 
    );
  end component;
  	
  component univ_bin_counter is
    generic (N : integer := 8);
    port (
      clk, reset            : in std_logic;
      syn_clr, load, en, up : in std_logic;
      clk_en                : in std_logic := '1';
      d                     : in std_logic_vector(N - 1 downto 0);
      max_tick, min_tick    : out std_logic;
      q                     : out std_logic_vector(N - 1 downto 0)
    );
  end component;

  component clk_enabler is
    generic (
      constant cnt_max : integer := 49999999); --  1.0 Hz 	
    port (
      clock  : in std_logic;
      clk_en : out std_logic
    );
  end component;

  component btn_debounce_toggle is
    generic (
      constant CNTR_MAX : std_logic_vector(15 downto 0) := X"FFFF");
    port (
      BTN_I    : in std_logic;
      CLK      : in std_logic;
      BTN_O    : out std_logic;
      TOGGLE_O : out std_logic;
      PULSE_O  : out std_logic);
  end component;

  component Reset_Delay is
    port (
      signal iCLK   : in std_logic;
      signal oRESET : out std_logic
    );
  end component;
  component SRAM_Controller is
    port (
      clk, reset              : in std_logic;
      mem                     : in std_logic;
      rw                      : in std_logic;
      addr                    : in std_logic_vector(19 downto 0);
      data_f2s                : in std_logic_vector(15 downto 0);
      ready                   : out std_logic;
      data_s2f_r, data_s2f_ur : out std_logic_vector(15 downto 0);
      ad                      : out std_logic_vector(19 downto 0);
      we_n, oe_n              : out std_logic;
      dio                     : inout std_logic_vector(15 downto 0);
      ce_n                    : out std_logic
    );
  end component;

  component Rom is
    port (
      address : in std_logic_vector (7 downto 0);
      clock   : in std_logic := '1';
      q       : out std_logic_vector (15 downto 0)
    );
  end component;

  component statemachine is
  port (
    Clk      : in std_logic;
    reset    : in std_logic;
    CountVal : in std_logic_vector(7 downto 0);
    Keys     : in std_logic_vector(3 downto 0);
    stateOut : out std_logic_vector(3 downto 0)
  );
  end component;

  component LCD_Controller is
    port (
      iClk         : in std_logic;
      LCD_Mode_SW  : in std_logic_vector(3 downto 0); -- switch for state machine input
      SRAM_DATA    : in std_logic_vector(15 downto 0);
      SRAM_ADDRESS : in std_logic_vector(19 downto 0);
      LCD_DATA     : inout std_logic_vector(7 downto 0);
      LCD_EN       : out std_logic;
      LCD_RS       : out std_logic
    );
  end component;
  
  component PWM_gen is
   port(
      clk						: in std_logic;
		en							: in std_logic;
		Sram_DataOut			: in std_logic_vector(15 downto 0);
		StateIn					: in std_logic_vector(1 downto 0);
		PWMout					: out std_logic		
   );
end component;

component i2c_user_logic is
PORT(
    clk       : IN     STD_LOGIC;                    --system clock
	 iData     : IN  	  STD_LOGIC_vector(15 downto 0);
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
end component;

  -------------------Temp Variables(Internal only)--------------------
  signal clk_enable60ns,clk_enable1hz   : std_logic;
  signal reset,counterReset,Rst   : std_logic;
  signal reset_State             : std_logic;
  signal CountOut_univ        : std_logic_vector(7 downto 0);
  signal CountOut_univ_delay	: std_logic_vector(7 downto 0);
  signal CountOut_var         : std_logic_vector(7 downto 0);
  signal data2Sram            : std_logic_vector(15 downto 0);
  signal SramReady            : std_logic;
  signal SramAddrIn           : std_logic_vector(19 downto 0);
  signal bReadWrite           : std_logic;
  signal SramActive           : std_logic;
  signal data_outR, data_outUR: std_logic_vector(15 downto 0);
  signal romDataOut           : std_logic_vector(15 downto 0);
  signal ErrorVal             : std_logic_vector(3 downto 0);
  signal resetmux             : std_logic;
  signal statereset           : std_logic;
  signal odata                : std_logic_vector(4 downto 0);
--  signal sramAddressout       : std_logic_vector(19 downto 0);
  signal CountStep            : integer;
  signal Cnten                : std_logic;
  signal count_clk_enable		: std_logic;
  signal Cnten_univ           : std_logic;
  signal keys_db				 	: std_logic_vector(3 downto 0):= (others => '0');
  signal StateState				: std_logic_vector(3 downto 0);
  signal dataDisplay				: std_logic_vector(15 downto 0);
  signal addrDisplay				: std_logic_vector(19 downto 0);
  signal PWMen						: std_logic;
  signal PWMDATA					: std_logic_vector(15 downto 0);
begin

  Rst          <= not key(0);
  counterReset <= reset or Rst;
  resetmux     <= counterReset or statereset;

  ------------Entity Instantiation-------------
  Inst_clk_Reset_Delay : Reset_Delay
  port map
  (
    iCLK   => iCLK,
    oRESET => reset
  );
	
   Inst_Key1_debounce : btn_debounce_toggle
   port map
   (
     BTN_I    => not KEY(1),
     CLK      => iCLK,
     BTN_O    => open,
     TOGGLE_O => open,
     PULSE_O  => Keys_db(1)
   );
	   Inst_Key2_debsounce : btn_debounce_toggle
   port map
   (
     BTN_I    => not KEY(2),
     CLK      => iCLK,
     BTN_O    => open,
     TOGGLE_O => open,
     PULSE_O  => Keys_db(2)
   );
	Inst_Key3_debounce : btn_debounce_toggle
   port map
   (
     BTN_I    => not KEY(3),
     CLK      => iCLK,
     BTN_O    => open,
     TOGGLE_O => open,
     PULSE_O  => Keys_db(3)
   );

	Keys_db(0) <= not Key(0);
	
  Inst_clk_enabler60ns : clk_enabler
  generic map(
    cnt_max => 2) --Needs to be set to 60 ns
  port map
  (
    clock  => iclk, -- output from sys_clk
    clk_en => clk_enable60ns -- enable every 10th sys_clk edge
  );
  
    Inst_clk_enabler1hz : clk_enabler
  generic map(
    cnt_max => 49999999) --Needs to be set to 60 ns
  port map
  (
    clock  => iclk, -- output from sys_clk
    clk_en => clk_enable1hz -- enable every 10th sys_clk edge
  );

  Inst_var_size_counter : var_size_counter
  generic map(
    N => 32)
  port map
  (
    clk       => iclk,
    reset     => counterReset,
    syn_clr   => Rst,
    CountStep => countStep,
    en        => Cnten,
    up        => '1',
    q         => CountOut_var
  );

  Inst_univ_bin_counter : univ_bin_counter
  generic map(N => 8)
  port map
  (
    clk      => iclk,
    reset    => counterReset,
    syn_clr  => Rst,
    load     => '0',
    en       => Cnten_univ,
    up       => '1',
    clk_en   => count_clk_enable,
    d 		 => (others => '0'),
    max_tick => open,
    min_tick => open,
    q        => CountOut_univ
  );

  Inst_StateMachine : statemachine
  port map
  (
    clk        => iclk,
    reset      => counterReset,
    countVal   => CountOut_univ,
    keys       => KEYs_db,
    stateOut   => StateState
  );

  Inst_SRAM_Controller : SRAM_Controller
  port map
  (
    clk         => iclk,
    reset       => counterReset,
    mem         => SramActive,
    rw          => bReadWrite,
    addr        => SramAddrIn,
    data_f2s    => data2Sram,
    ready       => SramReady,
    data_s2f_r  => data_outR,
    data_s2f_ur => data_outUR,
    ad          => SRAM_ADDR,
    we_n        => SRAM_WE_N,
    oe_n        => SRAM_OE_N,
    dio         => SRAM_DQ,
    ce_n        => SRAM_CE_N
  );

  Inst_initRom : Rom
  port map
  (
    address => CountOut_univ,
    clock   => iclk,
    q       => RomDataOut
  );

  Inst_LCD_Controller : LCD_Controller
  port map
  (
    iclk         => iclk,
    LCD_Mode_SW  => StateState,
    SRAM_DATA    => dataDisplay,
    SRAM_ADDRESS => addrDisplay, -- Delay before sending to sync correctly
    LCD_DATA     => LCD_DATA,
    LCD_EN       => LCD_EN,
    LCD_RS       => LCD_RS
  );
  
  inst_PWM: PWM_gen
  port map(
	clk => iclk,
	en => PWMen,
	Sram_dataOut => PWMDATA,
	stateIn => StateState(1 downto 0),
	PWMOut => GPIO(2)
  );
  
 inst_I2C: i2c_user_logic
	port map(
		clk  => iclk,
	 iData   => dataDisplay,
    sda     => GPIO(0),
    scl     => GPIO(1)
	);
  
  process(iclk)
	begin
		if (rising_edge(iclk)) then 
			countOut_univ_delay <= countOut_univ;
		end if;
	end process;
	
	UCmux:process(iclk,stateState)
		begin	
			if rising_edge(iclk) then
				case StateState(3 downto 2) is
					when "00" => --Init Mode  		--  This could cause issues
						reset_State <= '1';
						bReadWrite <= '0';
						Cnten_univ <= '1';
						cnten <= '0';
						SramActive <= clk_enable60ns;
						Count_clk_enable <= clk_enable60ns;
						SramAddrIn <= (X"000" & countOut_univ);
						data2Sram <= RomDataOut;
					when"10" => -- Test Mode
						SramActive <= clk_enable1hz; 
						Count_clk_enable <= clk_enable1hz;
						SramAddrIn <= (X"000" & countOut_univ);
						bReadWrite <= '1';
						cnten_univ <= '1';
						cnten <= '0';
						dataDisplay <= data_outR;
						addrDisplay <= (X"000" & countOut_univ_delay);
					when "01" => -- Pause Mode				-- do I need to do anything in this mode?
	--							SramActive <= L_key_Write;
	--							SramAddrIn <= (X"000" & ShiftAddr); 
	--							bReadWrite <= '0';
	--							addrShiftIn <= oData;
	--							addr2Seg <= ShiftAddr;
					when "11" => -- PWM Mode
						SramActive <= iclk;
						bReadWrite <= '1';
						cnten <= '1';
						SramaddrIn <= (X"000" & countOut_var);
						PWMen <= '1';
						PWMDATA <= data_outR;
						case StateState(1 downto 0) is
							when "00" => 
								countStep <= 5153;
							when "10" =>
								countStep <= 10307;
							when "11" =>
								countStep <= 85899;
							when others => ErrorVal <= "0010";
						end case;
					when others=> ErrorVal <= "0001";
				end case;		
			end if;
	end process;
end Structural;
