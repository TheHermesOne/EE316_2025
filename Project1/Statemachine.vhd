
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity statemachine is
port(
	Clk :in std_LOGIC;
	reset : in std_logic;
	CountVal: in std_logic;
	kp_data: in std_logic_vector(4 downto 0);
	kp_pulse: in std_logic;
	State: buffer std_logic_vector(3 downto 0)
);
end statemachine;


architecture struct of statemachine is
				type State_type is (INIT,OP_PAUSE_F,OP_PAUSE_B,OP_RUN_F,OP_RUN_B,PROG_ADDR,PROG_DATA);
				signal stateVAR : state_type;
				signal prevCountVal : std_LOGIC;
				signal Lcmd : std_LOGIC := ('1' & X"1");
				signal Hcmd : std_LOGIC := ('1' & X"2");
				signal Shiftcmd: std_logic := ('1' & X"0");
	begin
			prevCountVal <= CountVal;
		process(Iclk)
			begin

				if (reset = '1') then
					stateVAR <= INIT;
				elsif rising_edge(iclk) then
					case stateVAR is
						when INIT =>
							if (prevCountVal = "255" and countVal = "0") then
								stateVAR <= OP_PAUSE_F;
							end if;
						when OP_PAUSE_F =>
							if (kp_data = Lcmd and kp_pulse='1') then
								stateVAR <= OP_PAUSE_B;
							elsif (kp_data = Hcmd and kp_pulse='1') then
								stateVAR <= OP_RUN_F;
							elsif (kp_data = Shiftcmd and kp_pulse='1') then
								stateVAR <= PROG_ADDR;
							end if;
						when OP_PAUSE_B =>
							if (kp_data = Lcmd and kp_pulse='1') then
								stateVAR <= OP_PAUSE_F;
							elsif (kp_data = Hcmd and kp_pulse='1') then
								stateVAR <= OP_RUN_B;
							elsif (kp_data = Shiftcmd and kp_pulse='1') then
								stateVAR <= PROG_ADDR;
							end if;
						when OP_RUN_F =>
							if (kp_data = Lcmd and kp_pulse='1') then
								stateVAR <= OP_RUN_B;
							elsif (kp_data = Hcmd and kp_pulse='1') then
								stateVAR <= OP_PAUSE_F;
							elsif (kp_data = Shiftcmd and kp_pulse='1') then
								stateVAR <= PROG_ADDR;
							end if;
						when OP_RUN_B =>
							if (kp_data = Lcmd and kp_pulse='1') then
								stateVAR <= OP_RUN_F;
							elsif (kp_data = Hcmd and kp_pulse='1') then
								stateVAR <= OP_PAUSE_B;
							elsif (kp_data = Shiftcmd and kp_pulse='1') then
								stateVAR <= PROG_ADDR;
							end if;
						when PROG_ADDR =>
								if (kp_data = Lcmd and kp_pulse='1') then
-- TODO -- needs to write data from screen to SRAM
		  -- does it need to be done outside of this code
								elsif (kp_data = Hcmd and kp_pulse='1') then
									stateVAR <= PROG_DATA;
								elsif (kp_data = Shiftcmd and kp_pulse='1') then
									if(state(1) = "1") then
										stateVAR <= OP_PAUSE_B;
									else
										stateVAR <= OP_PAUSE_F;
									end if;
								end if;
						when PROG_DATA =>
								if (kp_data = Lcmd and kp_pulse='1') then
-- TODO -- needs to write data from screen to SRAM
		  -- does it need to be done outside of this code
		  -- Send out a pulse to read write?
								elsif (kp_data = Hcmd and kp_pulse='1') then
									stateVAR <= PROG_ADDR;
								elsif (kp_data = Shiftcmd and kp_pulse='1') then
									if(state(1) = "1") then
										stateVAR <= OP_PAUSE_B;
									else
										stateVAR <= OP_PAUSE_F;
									end if;
								end if;
						when others => stateVAR <= INIT;		
					end case;		
				end if;
			end process;
		process(stateVar)
			begin
				case stateVAR is  
					when INIT => state <= "0001"; -- In init mode, counter on
					when OP_PAUSE_F => state <= "0100"; -- in OP mode, forward direction, counter off
					when OP_PAUSE_B => state <= "0110"; -- in OP mode, backwards direction, counter off
					when OP_RUN_F => state <= "0101";	-- in OP mode, forward direction, counter on 
					when OP_RUN_B => state <= "0111";	-- in OP mode, backwards direction, counter on
					when PROG_ADDR => state(3 downto 2) <= "10"; state(0) <= "0"; --Changes PROG mode only and turns counter off
					when PROG_DATA => state(3 downto 2) <= "10"; state(0) <= "0";  --Changes PROG mode only and turns counter off
				end case;
		end process;
end struct;