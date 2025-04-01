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
ascii_code  : in std_logic_vector(7 downto 0);
ascii_new   : in std_logic;
state_out   : out std_logic_vector(6 downto 0) -- 6 downto 3 = colo; 2 downto 1 = cursor size; 0 = screen size
);
end state_machine;
-- More Detailed State Out Key
-- Color
-- '0001' = red, '0010' = blue, '0100' = green
-- Cursor Size
-- '01' = 1, '10' = 2, '11' = 3, '00' = 4
-- Screem Size
-- '0' = default, '1' = doubled
architecture Behavioral of state_machine is
TYPE machine IS(ready, new_code, color, cursor, screen, output);              --needed states
SIGNAL state             : machine;                               --state machine
signal ascii_new_prev   : std_logic;
signal count            : integer;
signal number           : integer;
signal state_sig        : std_logic_vector(6 downto 0) := "0010010";
begin

process(clk)
begin
    if rising_edge(clk) then
        ascii_new_prev <= ascii_new;
        case ascii_code is 
            when x"30"  => number <= 0;
            when x"31"  => number <= 1;
            when x"32"  => number <= 2;
            when x"33"  => number <= 3;
            when x"34"  => number <= 4;
            when others => number <= 9;
         end case;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        case state is
            when ready =>
                if ascii_new = '0' and ascii_new_prev = '1' then
                    state <= new_code;
                else
                    state <= ready;
                end if;
            
            when new_code =>
                count <= 0;
                if ascii_code = x"63" then -- lowercase 'c'
                    state <= color;
                elsif ascii_code = x"77" then -- lowercase 'w'
                    state <= cursor;
                elsif ascii_code = x"73" then -- lowercase 's'
                    state <= screen;
                else
                    state <= ready;
                end if;

            when color =>
                if ascii_new = '0' and ascii_new_prev = '1' then
                    case count is
                        when 0 =>
                            if ascii_code /= x"30" then
                                state_sig(6 downto 3) <= "0001";
                                state <= ready;
                            else
                                count <= count + 1;
                                state <= color;
                            end if;
                        when 1 =>
                            if ascii_code /= x"30" then
                                state_sig(6 downto 3) <= "0010";
                                state <= ready;
                            else
                                count <= count + 1;
                                state <= color;
                            end if;
                        when 3 =>
                                state_sig(6 downto 3) <= "0100";
                                state <= ready;
                        when others => state <= ready;
                    end case;
                end if;
           when cursor =>
               if ascii_new = '0' and ascii_new_prev = '1' then
                    case number is 
                    when 1 =>
                        state_sig(2 downto 1) <= "01";
                    when 2 =>
                        state_sig(2 downto 1) <= "10";
                    when 3 =>
                        state_sig(2 downto 1) <= "11";
                    when 4 =>
                        state_sig(2 downto 1) <= "00";
                    when others => null;
                    end case;
                    state <= ready;
               end if;
           when screen => 
               if ascii_new = '0' and ascii_new_prev = '1' then
                    case number is 
                    when 1 =>
                        state_sig(0) <= '0';
                    when 2 =>
                        state_sig(0) <= '1';
                    when others => null;
                    end case;
                    state <= ready;
               end if;
          when others => null;
          end case;
          state_out <= state_sig;
    end if;
end process;        
end Behavioral;
