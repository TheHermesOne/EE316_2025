library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_ctrl_test is
	port(
		clk, reset: in std_logic;
		sw: in std_logic_vector(3 downto 0);
		btn: in std_logic_vector(2 downto 0);
		led: out std_logic_vector(3 downto 0);
		ad: out std_logic_vector(18 downto 0);
		we_n,oe_n: out std_logic;
		dio: inout std_logic_vector(7 downto 0);
		ce_n: out std_logic
	);
end ram_ctrl_test;

architecture arch of ram_ctrl_test is

	constant ADDR_W: integer:= 19;
	constant DATA_W: integer:= 8;
	signal addr: std_logic_vector(ADDR_W-1 downto 0);
	signal data_f2s,data_s2f: std_logic_vector(DATA_W-1 downto 0);
	signal mem,rw: std_logic;
	signal data_reg: std_logic_vector(3 downto 0);
	signal db_btn: std_logic_vector(2 downto 0);
	
	component SRAM_Controller is
		
	
begin
	ctrl_unit: entity work.SRAM_Controller
			port map(
				clk => clk,
				reset => reset,
				mem => mem,
				rw => rw,
				addr => addr,
				data_f2s => data_f2s,
				ready => open, 
				data_s2f_r => data_s2f,
				data_s2f_ur => open,
				ad => ad,
				we_n => we_n,
				oe_n => oe_n,
				dio => dio,
				ce_n => ce_n			
			);
	debounce_0: entity work.btn_debounce_toggle
		port map(
			clk =>clk,
			BTN_I => btn(0),
			PULSE_O => db_btn(0),
			BTN_O => open,
			TOGGLE_O => open
	);
	debounce_1: entity work.btn_debounce_toggle
		port map(
			clk =>clk,
			BTN_I => btn(1),
			PULSE_O => db_btn(1),
			BTN_O => open,
			TOGGLE_O => open
	);

	debounce_2: entity work.btn_debounce_toggle
		port map(
			clk =>clk,
			BTN_I => btn(2),
			PULSE_O => db_btn(2),
			BTN_O => open,
			TOGGLE_O => open
	);

	process(clk)
		begin
			if (clk'event and clk = '1') then
				if (db_btn(0) = '1') then
					data_reg <= sw;
				end if;
			end if;
		end process;
	
	addr <= "0000000000000000" & sw;
	
	process(db_btn, data_reg)
		begin
			data_f2s <= (others => '0'); -- Write
			if(db_btn(1) = '1') then
				mem <= '1';
				rw <= '0';
				data_f2s <= "0000" & data_reg;
			elsif (db_btn(2) = '1') then --Read
				mem <= '1';
				rw <= '1';
			else
				mem <= '0';
				rw <= '1';
			end if;
		end process;
		led <= data_s2f(3 downto 0);
	end arch;
	