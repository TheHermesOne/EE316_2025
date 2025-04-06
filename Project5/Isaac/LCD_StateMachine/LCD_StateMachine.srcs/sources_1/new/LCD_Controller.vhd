----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2025 02:31:34 PM
-- Design Name: 
-- Module Name: LCD_Controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LCD_Controller is
  Port ( 
  iclk      : in std_logic;
  state_in  : in std_logic_vector(63 downto 0);
  output1   : out std_logic_vector(127 downto 0)
  );
end LCD_Controller;

architecture Behavioral of LCD_Controller is

begin

process(iclk)
begin
    if rising_edge(iclk) then

end process;
end Behavioral;
