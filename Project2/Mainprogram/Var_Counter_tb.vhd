library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Var_counter_tb is
  -- No ports in the testbench entity
end Var_counter_tb;

architecture behav of Var_counter_tb is

  component var_size_counter is
    generic (N : integer := 8);
    port (
      clk, reset : in std_logic;
      syn_clr    : in std_logic;
      en, up     : in std_logic;
      Countstep  : in integer  ;
      clk_en     : in std_logic := '1';
      q          : out std_logic_vector(N - 1 downto N - 8) -- takes only the first 8 bits 
    );
  end component;

  signal clk       : std_logic := '0';
  signal reset     : std_logic := '0';
  signal syn_clr   : std_logic := '0';
  signal en, up    : std_logic := '0';
  signal COuntstep : integer   := 833489;
  signal q         : std_logic_vector(7 downto 0);
begin
  clk <= not clk after 5 ns;

  DUT : Var_size_counter
  generic map(N => 32)
  port map
  (
    Clk       => clk,
    reset     => reset,
    syn_clr   => syn_clr,
    en        => en,
    up        => up,
    countstep => countstep,
    q         => q
  );

  process
  begin
    reset <= '1';
    wait for 10 ns;
    reset <= '0';
    en    <= '1';
    wait;
  end process;
end behav;