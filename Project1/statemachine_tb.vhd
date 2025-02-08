
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity statemachine_tb is
end;

architecture bench of statemachine_tb is
  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics
  -- Ports
  signal Clk : std_LOGIC;
  signal reset : std_logic;
  signal CountVal : std_logic_vector(7 downto 0);
  signal kp_data : std_logic_vector(4 downto 0);
  signal kp_pulse : std_logic;
  signal stateOut : std_logic_vector(3 downto 0);
  signal resetPulse : std_LOGIC;
  signal ReadWriteOut : std_logic;
  signal Lcommand : std_LOGIC_vector(4 downto 0) := ('1' & X"1");
  signal Hcommand : std_LOGIC_vector(4 downto 0) := ('1' & X"2");
  signal ShiftCommand : std_LOGIC_vector(4 downto 0) := ('1' & X"3");
begin
  statemachine_inst : entity work.statemachine
  port map (
    Clk => Clk,
    reset => reset,
    CountVal => CountVal,
    kp_data => kp_data,
    kp_pulse => kp_pulse,
    stateOut => stateOut,
    resetPulse => resetPulse,
    ReadWriteOut => ReadWriteOut
  );
  clk <= not clk after 10 ns;

	process
		begin	
			reset <= '1';
			wait for 20 ns;
			reset <= '0';
			wait for 50 ns;					
			countVal <= X"FF";
			wait for 50 ns;
			countVal <= X"00";
			wait for 50 ns;
			--Init ends should go to OP_PAUSE_F
			kp_data <= Lcommand;
			kp_pulse <= '1';
			wait for 20 ns;
			kp_pulse <= '0';
			wait for 20 ns;
			--Should go into OP_PAUSE_B
			kp_data <= Hcommand;
			kp_pulse <= '1';
			wait for 20 ns;
			kp_pulse <= '0';
			wait for 20 ns;
			--Should go to OP_RUN_B
			kp_data <= shiftCommand;
			kp_pulse <= '1';
			wait for 20 ns;
			kp_pulse <= '0';
			wait for 20 ns;
			--Should go into PROG_ADDR
			kp_data <= shiftCommand;
			kp_pulse <= '1';
			wait for 20 ns;
			kp_pulse <= '0';
			wait for 50 ns;
			--Should go into OP_PAUSE_B
			reset <= '1';
			wait for 20 ns;
			reset <= '0';
			--Should go Back to INIT
			wait;
	end process;
end bench;