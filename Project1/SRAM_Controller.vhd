library ieee ;
use ieee.std_logic_1164.all;

entity SRAM_Controller is
	port(
		clk,reset					: in std_logic; 							-- Set up for 100Mhz clock
		mem							: in std_logic; 							-- when '1' SRAM_Controller is going to be used
		rw								: in std_logic; 							-- read write bit. '1' for read, '0' for write
		addr							: in std_logic_vector(19 downto 0);	-- Address input
		data_f2s						: in std_logic_vector(15 downto 0);	-- Data input to SRAM_Controller
		ready							: out std_logic; 							-- Status signal indcating Controller is ready for input?
		data_s2f_r, data_s2f_ur	: out std_logic_vector(15 downto 0);	-- Data (registered, unregistered) from SRAM_Controller
		ad								: out std_logic_vector(19 downto 0); --address output during read; goes to SRAM
		we_n, oe_n					: out std_logic; 							--Write enable , output enable outputs to the SRAM
		dio							: inout std_logic_vector(15 downto 0);--Data input/output that goes to the SRAM
		ce_n							: out std_logic 							--Chip enable output; goes to SRAM 
	);
	end SRAM_Controller;
	
	architecture arch of SRAM_Controller is
		type state_type is (idle,r1,r2,w1,w2);
				signal state_reg, state_next: state_type;
				signal data_f2s_reg, data_f2s_next: std_logic_vector(15 downto 0);
				signal data_s2f_reg, data_s2f_next: std_logic_vector(15 downto 0);
				signal addr_reg: std_logic_vector(19 downto 0);
				signal addr_next: std_logic_vector(19 downto 0);
				signal we_buf, oe_buf, tri_buf: std_logic;
				signal we_reg, oe_reg, tri_reg: std_logic;
				
				
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
				elsif (clk'event and clk = '1') then
					state_reg <= state_next;
					addr_reg <= addr_next;
					data_f2s_reg <= data_f2s_next;
					data_s2f_reg <= data_s2f_next;
					tri_reg <= tri_buf;
					we_reg <= we_buf;
					oe_reg <= oe_buf;
				end if;
			end process;
	-- Next state Logic
	
		process(state_reg, mem, rw, dio, addr, data_f2s, data_f2s_reg, data_s2f_reg, addr_reg)
			begin
				addr_next <= addr_reg;
				data_f2s_next <= data_f2s_reg;
				data_s2f_next <= data_s2f_reg;
				ready <= '0';
				case state_reg is
					when idle => 
						if (mem = '0') then
							state_next <= idle;
						else
							addr_next <= addr;
							if (rw = '0') then -- writing
								state_next <= w1;
								data_f2s_next <= data_f2s;
							else
								state_next <= r1;
							end if;
						end if;
						ready <= '1';
					when w1 => 
						state_next <= w2;
					when w2 => 
						state_next <= idle;
					when r1 => 
						state_next <= r2;
					when r2 => 
						data_f2s_next <= dio;
						state_next <= idle;
				end case;
			end process;
		-- Look-ahead output logic
		process(state_next)
			begin
				tri_buf <= '1';
				we_buf <= '1';
				oe_buf <= '1';
				case state_next is
					when idle => 
					when w1 =>
						tri_buf <= '0';
						we_buf <= '0';
					when w2 => 
						tri_buf <= '0';
					when r1 => 
						oe_buf <= '0';
					when r2 =>
						oe_buf <= '0';
				end case;
		end process;
	-- to main system
		data_s2f_r <= data_s2f_reg;
		data_s2f_ur <= dio;
	-- To SRAM
		we_n <= we_reg;
		oe_n <= oe_reg;
		ad <= addr_reg;
	-- I/O for SRAM chip
		ce_n <= '0';
		dio <= data_f2s_reg when tri_reg = '0'
			else (others => 'Z');
	end arch;
			