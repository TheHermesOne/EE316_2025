-- modified: Deleted Unessasry Load . added variable to change count, Jan 30, 2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_gen is
   port(
        clk,en					: in std_logic;
		iData			: in std_logic_vector(7 downto 0);
--		StateIn					: in std_logic_vector(1 downto 0);
		PWMout					: out std_logic		
   );
end PWM_gen;

architecture arch of PWM_gen is
	signal DATA 		: unsigned(7 downto 0);
   signal data_cut      : unsigned(7 downto 0);
   signal r_reg			: unsigned(7 downto 0) := (others => '0');
   signal r_next	    : unsigned(7 downto 0) := (others => '0');

begin
	DATA <= unsigned(iData);
		
--	SRAMDataCut:process(StateIn,DATA)
--		begin
--			if(StateIn = "11") then
--				data_cut(5 downto 0) <= DATA(15 downto 10);
--				data_cut(7 downto 6) <= "00";
--			else
--				data_cut <= DATA(15 downto 8);
--			end if;
--	end process;
	
   InternalCounter:process(clk)
		begin
			if (en = '0') then
				r_reg <= (others=>'0');
			elsif (rising_edge(clk))then
				r_reg <= r_next;
			end if;
		end process;
	r_next <= r_reg + 1 when en ='1' else
					 r_reg;
		
	PWM: process(clk)
		begin
			if (en = '1') then
				if(r_reg < DATA) then
					PWMout <= '1';
				else
					PWMout <= '0';
				end if;
			end if;
	end process;			
				
end arch;

