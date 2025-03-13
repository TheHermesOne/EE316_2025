LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;


entity CombineProgram is
    port(
        clk     : IN std_logic;
        reset   : IN std_logic;
        sda_lcd     : INOUT  std_logic;
        scl_lcd     : INOUT std_logic;
        sda_sevSeg  : INOUT  std_logic;
        scl_sevSeg : INOUT std_logic;
        ps2_clk : INOUT std_logic;
        ps2_data: INOUT std_logic 
    );
end CombineProgram;

architecture Behavioral of CombineProgram is
component Hangman is
port(
		clk       	: IN     	STD_LOGIC;                    --system clock
		reset  		: in    		std_logic;
		word 			: IN 			string(1 to 16);
		letter 		: IN 			character;
		newLetterPulse: IN		std_LOGIC;
	   vwrongGuess: OUT	std_logic_vector(3 downto 0);
		vGameOver	: OUT			std_LOGIC_vector(1 downto 0);
  	   vRebuilt 	: out 		string(1 to 16)	
); 			
		
end component Hangman;

component ps2_keyboard_to_ascii is
GENERIC(
      clk_freq                  : INTEGER := 50_000_000; --system clock frequency in Hz
      ps2_debounce_counter_size : INTEGER := 8);         --set such that 2^size/clk_freq = 5us (size = 8 for 50MHz)
  PORT(
      clk        : IN  STD_LOGIC;                     --system clock input
      ps2_clk    : IN  STD_LOGIC;                     --clock signal from PS2 keyboard
      ps2_data   : IN  STD_LOGIC;                     --data signal from PS2 keyboard
      ascii_new  : OUT STD_LOGIC;                     --output flag indicating new ASCII value
      ascii_code : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); --ASCII value
end component ps2_keyboard_to_ascii;

component i2c_user_logic_LCD is
		port (
			clk       : IN         	STD_LOGIC;                    --system clock
			reset     : IN         	STD_LOGIC;
			iData     : IN         	string(1 to 16);
			kp_pulse	 : in 			std_LOGIC;
			sda       : INOUT  		STD_LOGIC;                    --serial data output of i2c bus
			scl       : INOUT  		STD_LOGIC                  --serial clock output of i2c bus
		);
end component i2c_user_logic_LCD;


component i2c_user_logic is
    PORT(
    clk       : IN         STD_LOGIC;                    --system clock
    reset     : IN         STD_LOGIC;
	iData     : IN         STD_LOGIC_vector(15 downto 0);
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
end component;

signal char : std_LOGIC_VECTOR(6 downto 0);
signal pulse: std_LOGIC;
signal rebuiltword: string (1 to 16);
signal wrongguesses: std_logic_vector ( 3 downto 0);
signal combowrongGuesses: std_logic_vector (15 downto 0) := x"000" & wrongGuesses;
begin

inst_Hangman: Hangman	
		port map (
		clk		=> clk, 
		reset => reset,                    --active-high reset
		word		=> "togetherXXXXXXXX",		-- needs to be like this, will need to fill the dictorary/ ROM with words like this
		vwrongGuess =>  wrongGuesses,
		letter 	=> character'val(to_integer(unsigned(char))),
		newLetterPulse => pulse,
		vRebuilt => rebuiltword
		);
inst_ps2_keyboard: ps2_keyboard_to_ascii
	port map(
		clk 	  => clk,
		ps2_clk =>  ps2_clk,
		ps2_data => ps2_data,
		ascii_new => pulse,
		ascii_code => char
	);
	
	Inst_i2c_user_logic_LCD: i2c_user_logic_LCD 
		port map (
			clk      => clk,
			reset 	=> reset,
			iData		=> rebuiltword,
			kp_pulse	=> pulse,
			sda		=> sda_lcd,
			scl		=> scl_lcd
		);
		
Inst_i2c_user_logic_seg: i2c_user_logic
    port map(
    	clk 		=> clk,
		reset 	=> reset,
		iData	=> combowrongGuesses,
		sda		=> sda_sevSeg,
		scl		=> scl_sevSeg
    );
		

end Behavioral;
