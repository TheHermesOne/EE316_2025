----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2025 12:34:53 PM
-- Design Name: 
-- Module Name: state_machine - Behavioral
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

entity state_machine is
port (
clk         : in std_logic;
lcd_data    : in std_logic_vector(127 downto 0);
ascii_code  : in std_logic_vector(7 downto 0);
ascii_new   : in std_logic;
state_out   : out std_logic_vector(63 downto 0) -- 63 downto 16 = color; 15 downto 8 = cursor size; 7 downto 0 = screen size
);
end state_machine;

architecture Behavioral of state_machine is
TYPE machine IS(ready, new_code, color, cursor, screen, send);              --needed states
SIGNAL state                  : machine;      
signal ascii_new_prev         : std_logic;                       --state machine
signal lcd_data_prev          : std_logic_vector(127 downto 0);
--signal count                  : integer;
--signal number                 : integer;
signal state_sig_active       : std_logic_vector(63 downto 0):= x"6666666666663131"; -- default state (black 1 1)
--signal state_sig_send         : std_logic_vector(6 downto 0) := "0010010"; -- default state
begin

process(clk)
begin
    if rising_edge(clk) then
        lcd_data_prev   <= lcd_data;
        ascii_new_prev  <= ascii_new;
    end if;
end process;

process(clk)
begin
    
    if rising_edge(clk) then
        case state is    
            when ready =>
                if lcd_data(55 downto 48) = x"63" then -- lowercase 'c'
                    state <= color;
                elsif lcd_data(15 downto 8) = x"77" then -- lowercase 'w'
                    state <= cursor;
                elsif lcd_data(15 downto 8) = x"73" then -- lowercase 's'
                    state <= screen;
                elsif lcd_data(7 downto 0) = x"20" and lcd_data_prev(7 downto 0) /= x"20" then
                    state <= send;
                else
                    state <= ready;
                end if;

           when color =>
                state_sig_active(63 downto 16) <= lcd_data(47 downto 0);
                state <= ready;
           when cursor =>
                state_sig_active(15 downto 8) <= lcd_data(7 downto 0);
                state <= ready;
           when screen => 
                state_sig_active(7 downto 0) <= lcd_data(7 downto 0);
                state <= ready;
           when send =>
                state_out <= state_sig_active;
                state <= ready;
          when others => null;
          end case;
          
    end if;
end process;        
end Behavioral;
