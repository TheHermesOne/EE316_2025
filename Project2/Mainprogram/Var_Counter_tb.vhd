library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Var_counter_tb is
-- No ports in the testbench entity
end Var_counter_tb;

architecture behav of Var_counter_tb is

	component var_size_counter is
   generic(N: integer := 8;M: integer := 1);
   port(
      clk, reset				: in std_logic;
		syn_clr					: in std_logic;
      en, up					: in std_logic;
		clk_en 					: in std_logic := '1';
      q							: out std_logic_vector(N-1 downto N-9) -- takes only the first 8 bits 
   );
	end component;

	signal clk :STD_LOGIC := '0';
	signal reset : std_LOGIC := '0';
	signal syn_clr : std_logic;
	signal en,up	: std_LOGIC;
	signal q: std_LOGIC_vector(31 downto 0);

	
	begin
	clk <= not clk after 5 ns;

	DUT:Var_size_counter
		generic map(N => 32,M => 833489)
		port map (
			Clk => clk,
			reset => reset,
			syn_clr => syn_clr,
			en => en,
			up => up,
			q => q
		);
	
	process
		begin					
			en <= '1';
			wait;
	end process;
end behav;