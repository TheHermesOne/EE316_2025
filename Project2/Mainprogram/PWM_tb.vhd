
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_tb is
end;

architecture bench of PWM_tb is
  -- Ports
  signal clk      : std_logic := '0';
  signal en    : std_logic := '1';
  signal SRAM_DataOut : std_logic_vector(15 downto 0) := (others => '0');
  signal StateIn     : std_logic_vector(1 downto 0);
  signal Pwmout : std_logic;
begin

  Clk <= not Clk after 5 ns;

  pwm_Gen_inst : entity work.PWM_Gen
    port map(
      clk						=> clk,
		en							=> en,
		Sram_DataOut			=> SRAM_DataOut,
		StateIn					=> StateIn,
		PWMout					=> PWMout
   );
    
  process
    begin
		StateIn <= "10";
		SRAM_DataOut <= X"0FFF";  
    wait;
  end process;
end bench;