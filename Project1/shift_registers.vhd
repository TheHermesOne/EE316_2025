library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ShiftRegisters is
    Generic (
        NUM_ADDR_REGS : integer := 2; -- Number of 4-bit registers for address buffer
        NUM_DATA_REGS : integer := 4  -- Number of 4-bit registers for data buffer
    );
    Port (
        clk           : in  STD_LOGIC;             -- Clock signal
        reset         : in  STD_LOGIC;             -- Reset signal
        keypad_input  : in  STD_LOGIC_VECTOR(4 downto 0); -- 5-bit from keypad
        address_buffer: out STD_LOGIC_VECTOR((NUM_ADDR_REGS * 4 - 1) downto 0); -- Addr buffer
        data_buffer   : out STD_LOGIC_VECTOR((NUM_DATA_REGS * 4 - 1) downto 0); -- Data buffer
        display_mode  : out STD_LOGIC              -- '0' for address, '1' for data
    );
end ShiftRegisters;

architecture Behavioral of ShiftRegisters is

    signal addr_buffer : STD_LOGIC_VECTOR((NUM_ADDR_REGS * 4 - 1) downto 0) := (others => '0'); -- Int address buffer
    signal data_buf    : STD_LOGIC_VECTOR((NUM_DATA_REGS * 4 - 1) downto 0) := (others => '0'); -- Int data buffer
    signal mode        : STD_LOGIC := '0'; -- '0' for address, '1' for data

begin

    process(clk, reset)
    begin
        if reset = '1' then
            -- Resets the buffers and mode
            addr_buffer <= (others => '0');
            data_buf <= (others => '0');
            mode <= '0';
        elsif rising_edge(clk) then
            -- Determine mode from keypa
            mode <= keypad_input(4);

            if mode = '0' then
                -- Address Shift input into address buffer
                addr_buffer <= addr_buffer((NUM_ADDR_REGS * 4 - 5) downto 0) & keypad_input(3 downto 0);
            else
                -- Data Shift input into data buffer
                data_buf <= data_buf((NUM_DATA_REGS * 4 - 5) downto 0) & keypad_input(3 downto 0);
            end if;
        end if;
    end process;

    -- outputs
    address_buffer <= addr_buffer;
    data_buffer <= data_buf;
    display_mode <= mode;

end Behavioral;
