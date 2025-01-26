library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity toplevel_tb is
-- No ports in the testbench entity
end toplevel_tb;

architecture behav of toplevel_tb is
	component top_level is
		generic map(N: integer := 8);
		port map (
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
	signal clk : std_logic := 0;
	signal 
end behav;