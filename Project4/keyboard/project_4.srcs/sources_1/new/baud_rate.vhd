----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2025 03:19:15 PM
-- Design Name: 
-- Module Name: baud_rate - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity baud_rate is
GENERIC (
		CONSTANT cnt_max : integer := 5027);-- 9600 baudrate 
    Port ( clk : in STD_LOGIC;
           baud : out STD_LOGIC);
end baud_rate;

architecture Behavioral of baud_rate is
signal clk_cnt  :integer range 0 to cnt_max;
signal clk_en   : std_logic; 

begin
baud<=clk_en; 
clk_en_inst: process(clk)
	begin
	if rising_edge(clk) then
		if (clk_cnt = cnt_max) then
			clk_cnt <= 0;
			clk_en <= '1';
		else
			clk_cnt <= clk_cnt + 1;
			clk_en <= '0';
		end if;
	end if;
end process;


end Behavioral;
