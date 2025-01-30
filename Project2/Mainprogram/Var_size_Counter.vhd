-- modified: Deleted Unessasry Load . added variable to change count, Jan 30, 2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity var_size_counter is
   generic(N: integer := 8);
   port(
      clk, reset				: in std_logic;
		syn_clr					: in std_logic;
      en, up					: in std_logic;
		Countstep				: in integer := 1;
		clk_en 					: in std_logic := '1';
      q							: out std_logic_vector(N-1 downto N-9) -- takes only the first 8 bits 
   );
end var_size_counter;

architecture arch of var_size_counter is
   signal r_reg				: unsigned(N-1 downto 0);
   signal r_next				: unsigned(N-1 downto 0);
begin
   -- register
   process(clk,reset)
   begin
      if (reset='1') then
         r_reg <= (others=>'0');
      elsif rising_edge(clk) and clk_en = '1' then
         r_reg <= r_next;
      end if;
   end process;
   -- next-state logic
   r_next <= (others=>'0') when syn_clr='1' else
				 r_reg + countstep     when en ='1' and up='1' else
             r_reg - countstep     when en ='1' and up='0' else
             r_reg;
   -- output logic
   q <= std_logic_vector(r_reg)(N-1 downto N-9);
end arch;

