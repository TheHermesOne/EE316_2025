library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top_level is
  port (
    Clk      	: in std_logic;
    reset    	: in std_logic;
    Keys_I     : in std_logic_vector(3 downto 0);
    stateOut 	: out std_logic_vector(3 downto 0)
  );
end top_level;

architecture struct of top_level is

signal q8 		: std_logic_vector(7 downto 0);
component statemachine is
  port (
    Clk      : in std_logic;
    reset    : in std_logic;
    CountVal : in std_logic_vector(7 downto 0);
    Keys     : in std_logic_vector(3 downto 0);
    stateOut : out std_logic_vector(3 downto 0)
  );
end component;

component univ_bin_counter is
   generic(N: integer := 8; N2: integer := 255; N1: integer := 0);
   port(
			clk, reset				: in std_logic;
			syn_clr, load, en, up	: in std_logic;
			clk_en 					: in std_logic := '1';			
			d						: in std_logic_vector(N-1 downto 0);
			max_tick, min_tick		: out std_logic;
			q8						: out std_logic_vector(N-1 downto 0)		
   );
end component;

begin
inst_statemachine: statemachine
	port map (
		clk 		=> clk,
		reset 	=> reset,
		CountVal => q8,
		Keys 		=> Keys_I,
		stateOut => stateOut
		);
		
inst_univ_bin_counter: univ_bin_counter
	Generic Map(N => 8, N2 => 255, N1 => 0)
		Port Map( 
				clk			=> clk,
				clk_en		=> '1',
				reset			=> reset,
				up				=> '1',
				en 			=> '1',
				syn_clr		=>	'0',
				load			=>	'0',
				d				=>	(others =>'0'),
				q8				=> q8,
				max_tick		=> open,
				min_tick		=>	open );
				
end struct;