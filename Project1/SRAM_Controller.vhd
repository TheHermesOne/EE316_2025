library ieee ;
use ieee.std_logic_1164.all;

entity SRAM_Controller is
	port(
		clk,reset: in std_logic;
		mem: in std_logic;
		rw: in std_logic;
		addr: in std_logic_vector(7 downto 0);
		data_f2s: in std_logic_vector(7 downto 0);
		ready: out std_logic;
		data_s2f_r, data_s2f_ur: out std_logic_vector(7 downto 0);
		ad: out std_logic_vector (18 down 0);
		we_n, oe_n: out std_logic;
		dio: inout std_logic_vector(7 downto 0);
		ce_n: out std_logic
	);
	end SRAM_Controller;
	
	architecture arch of SRAM_Controller is
		type state_type is (idle,r1,r2,w1,w2);
				signal state_reg, state_next: state_type;
				signal data_f2s_reg, data_f2s_next: std_logic_vector(7 downto 0);
				signal data_s2f_reg, data_s2f_next: std_logic_vector(7 downto 0);
				signal addr_reg, addr_next: std_logic_vector(18 downto 0);
				signal we_buf, oe_buf, tri_buf,: std_logic;
				signal we_reg, oe_reg, tri_reg,: std_logic;
				
				
		begin
		process(clk,reset)
			begin
				if (reset = '1') then
					state_reg <= idle;
					addr_reg <= (others => '0');
					data_f2s_reg <= (others => '0');
					data_s2f_reg <= (others => '0');
					tri_reg <= '1';
					we_reg <= '1';
					oe_reg <= '1';