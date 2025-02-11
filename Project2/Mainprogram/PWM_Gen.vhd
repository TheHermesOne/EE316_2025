-- modified: Deleted Unessasry Load . added variable to change count, Jan 30, 2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_gen is
   port(
      clk,en					: in std_logic;
		Sram_DataOut			: in std_logic_vector(15 downto 0);
		StateIn					: in std_logic_vector(1 downto 0);
		PWMout					: out std_logic		
   );
end PWM_gen;

architecture arch of PWM_gen is
	signal SRAMDATA 		: unsigned(15 downto 0);
   signal Sram_data_cut : unsigned(7 downto 0);
   signal r_reg			: unsigned(7 downto 0) := (others => '0');
   signal r_next			: unsigned(7 downto 0) := (others => '0');

begin
	SRAMDATA <= unsigned(Sram_DataOut);
		
	SRAMDataCut:process(StateIn,SRAMDATA)
		begin
			if(StateIn = "11") then
				Sram_data_cut(5 downto 0) <= SRAMDATA(15 downto 10);
				Sram_data_cut(7 downto 6) <= "00";
			else
				Sram_data_cut <= SRAMDATA(15 downto 8);
			end if;
	end process;
	
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
				if(r_reg < Sram_data_cut) then
					PWMout <= '1';
				else
					PWMout <= '0';
				end if;
			end if;
	end process;			
				
end arch;

