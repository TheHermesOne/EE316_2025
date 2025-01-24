library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity statemachine_tb is
-- No ports in the testbench entity
end statemachine_tb;

architecture behav of statemachine_tb is

	component Statemachine is
		port(
			Clk :in std_LOGIC;
			reset : in std_logic;
			CountVal: in std_logic_vector(7 downto 0);
			kp_data: in std_logic_vector(4 downto 0);
			kp_pulse: in std_logic;
			State: buffer std_logic_vector(3 downto 0)
		);
	end component;

	signal clk :STD_LOGIC := '0';
	signal reset : std_LOGIC;
	signal countVal : std_logic_vector(7 downto 0);
	signal kp_data : std_LOGIC_vector(4 downto 0);
	signal kp_pulse : std_LOGIC;
	signal state: std_LOGIC_vector(3 downto 0);

	signal Lcommand : std_LOGIC_vector(4 downto 0) := ('1' & X"1");
	signal Hcommand : std_LOGIC_vector(4 downto 0) := ('1' & X"2");
	signal ShiftCommand : std_LOGIC_vector(4 downto 0) := ('1' & X"0");
	
	begin
	clk <= not clk after 5 ns;

	DUT:Statemachine
		port map (
			Clk => clk,
			reset => reset,
			countVal => countVal,
			kp_data => kp_data,
			kp_pulse => kp_pulse,
			state => state
		);
	
	process
		begin
			
			countVal <= X"FF";
			wait for 200ns;
			countVal <= X"00";
			wait for 200ns;
			--Init ends should go to OP_PAUSE_F
--			kp_data <= Lcommand;
--			kp_pulse <= '1';
--			wait for 20ns;
--			kp_pulse <= '0';
			--Should go into OP_PAUSE_B
			
	end process;
end behav;