library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use ieee.std_logic_unsigned.all;

entity Shift_Register is
GENERIC (
CONSTANT sr_depth : integer := 128);    
port(
clock: in std_logic;
reset : in std_logic;
back  : in std_logic;
en: in std_logic;
sr_in: in std_logic_vector(7 downto 0);
sr_out: out std_logic_vector(sr_depth-1 downto 0) :=(others => '0')
);
end Shift_Register;

----------------------------------------------------

architecture behv of Shift_Register is
signal sr      : std_logic_vector(sr_depth - 1 downto 0) := x"20202020202020202020202020202020";
--signal sr_prev : std_logic_vector(sr_depth - 1 downto 0) := x"20202020202020202020202020202020";
--signal sr_prev_2: std_logic_vector(sr_depth - 1 downto 0) := x"20202020202020202020202020202020";
--signal sr_prev_2 : std_logic_vector(sr_depth - 1 downto 0) := (others => '0');

begin

process(clock)
begin
    if (rising_edge(clock)) then
--        sr_prev <= sr;
--        sr_prev_2 <= sr_prev;
        if reset = '1' then
            sr <= x"20202020202020202020202020202020";
        elsif en = '1' then
            if back <= '0' then
                sr <= sr(sr_depth-9 downto 0) & sr_in;
            else 
                sr <= x"20" & sr(sr_depth-1 downto 8);
            end if;
        end if;
    end if;
end process;

sr_out <= sr;

end behv;