
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ShiftRegisters is
    Port (
        clk           : in  STD_LOGIC;             -- Clock 
        reset         : in  STD_LOGIC;             -- Reset 
        keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit  keypad
        address_buffer: out STD_LOGIC_VECTOR(7 downto 0); -- address buffer
        data_buffer   : out STD_LOGIC_VECTOR(15 downto 0); --data buffer
        display_mode  : out STD_LOGIC              -- '0' for address, '1' for data
    );
end ShiftRegisters;

architecture Behavioral of ShiftRegisters is

    signal addr_buffer : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); -- address buffer
    signal data_buf    : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); -- data buffer
    signal mode        : STD_LOGIC := '0'; --'0' for address, '1' for data

begin

    process(clk, reset)
    begin
        if reset = '1' then
            -- reset buffers and mode
            addr_buffer <= (others => '0');
            data_buf <= (others => '0');
            mode <= '0';
        elsif rising_edge(clk) then
            -- Determine mode from keypad
            mode <= keypad_input(4);

            if mode = '0' then
                -- Address mode: Shift to address buffer
                addr_buffer <= addr_buffer(3 downto 0) & keypad_input(3 downto 0);
            else
                -- Data mode: Shift to data buffer
                data_buf <= data_buf(11 downto 0) & keypad_input(3 downto 0);
            end if;
        end if;
    end process;

    -- Assign outputs
    address_buffer <= addr_buffer;
    data_buffer <= data_buf;
    display_mode <= mode;

end Behavioral;
