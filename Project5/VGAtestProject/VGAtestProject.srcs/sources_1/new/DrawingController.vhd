library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;



entity DrawingController is
    Port ( clk: IN STD_LOGIC;
           Key : in STD_LOGIC;
           reset: in STD_LOGIC;
           RAMAddress : out STD_LOGIC_VECTOR(15 downto 0);
           RAMDataWrite: OUT STD_LOGIC_VECTOR(2 downto 0);
           RAMWriteEnable: OUT STD_LOGIC);
end DrawingController;

architecture Behavioral of DrawingController is

signal ramAddressTemp : unsigned(15 downto 0) := (others => '0');
    signal writing        : std_logic:= '1';

begin


    -- Always writing 101
    RAMDataWrite <= "101";
    RAMAddress   <= std_logic_vector(ramAddressTemp);
    RAMWriteEnable <= '1' when writing = '1' else '0';

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '0' then
                ramAddressTemp <= (others => '0');
                writing <= '1';
            elsif writing = '1' then
                if ramAddressTemp = to_unsigned(65535, 16) then
                    writing <= '0'; -- Done writing
                else
                    ramAddressTemp <= ramAddressTemp + 1;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
