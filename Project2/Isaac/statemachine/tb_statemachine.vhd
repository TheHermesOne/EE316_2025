library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity statemachine_tb is
end;

architecture bench of statemachine_tb is
  -- Ports
  signal Clk      : std_logic := '0';
  signal reset    : std_logic := '0';
  signal countVal : std_logic_vector(7 downto 0) := (others => '0');
  signal Keys     : std_logic_vector(3 downto 0) := (others => '0');
  signal stateOut : std_logic_vector(3 downto 0);

  component statemachine is
    port (
      Clk      : in std_logic;
      reset    : in std_logic;
      CountVal : in std_logic_vector(7 downto 0);
      Keys     : in std_logic_vector(3 downto 0);
      stateOut : out std_logic_vector(3 downto 0)
    );
  end component;

begin

  -- Clock process (20 ns period -> 50 MHz clock)
  Clk <= not Clk after 10 ns;

  -- DUT Instantiation
  statemachine_inst : statemachine
    port map (
      Clk      => Clk,
      reset    => reset,
      CountVal => countVal,
      Keys     => Keys,
      stateOut => stateOut
    );

  process
  begin
    -- Reset the state machine
    Keys <= "0000";
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 50 ns;

    -- Transition to TEST mode
    countVal <= X"FF";
    wait for 10 ns;
    countVal <= X"00"; 
    wait for 50 ns;

    -- Transition to INIT from TEST
    Keys <= "0001"; 
    wait for 10 ns;
    Keys <= "0000"; 
    wait for 50 ns;

    -- Transition to PAUSE from TEST
    Keys <= "0010"; 
    wait for 10 ns;
    Keys <= "0000"; 
    wait for 50 ns;

    -- Transition to PWM from PAUSE
    Keys <= "0100"; 
    wait for 10 ns;
    Keys <= "0000"; 
    wait for 50 ns;

    -- Cycle through PWM frequency states
    Keys <= "1000"; 
    wait for 10 ns;
    Keys <= "0000"; 
    wait for 50 ns;
    Keys <= "1000"; 
    wait for 10 ns;
    Keys <= "0000"; 
    wait for 50 ns;
    Keys <= "1000"; 
    wait for 10 ns;
    Keys <= "0000"; 
    wait for 50 ns;

    -- Transition back to TEST
    Keys <= "0100"; 
    wait for 10 ns;
    Keys <= "0000"; 
    wait for 50 ns;

    -- Transition back to INIT
    Keys <= "0001"; 
    wait for 10 ns;
    Keys <= "0000"; 
    wait for 50 ns;

    wait;
  end process;
end bench;
