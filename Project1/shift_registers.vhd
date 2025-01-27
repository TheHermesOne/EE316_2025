library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Needs pulse20 from Keypad 
-- Needs to shift in one at a time (pulse fix that? or need clk enabler?)



entity ShiftRegisters is
    Generic (
        NUM_DATA_REGS : integer := 4  -- Number of 4-bit registers for data buffer
    );
    Port (
        clk					: in STD_LOGIC;             -- Clock signal
        reset				: in STD_LOGIC;             -- Reset signal
        keypad_input		: in STD_LOGIC_VECTOR(4 downto 0); -- 5-bit from keypad
		  keypulse			: in std_LOGIC;
        data_out			: out STD_LOGIC_VECTOR((NUM_DATA_REGS * 4 - 1) downto 0) -- Data buffer
    );
end ShiftRegisters;

architecture Behavioral of ShiftRegisters is

    signal data_buffer : STD_LOGIC_VECTOR((NUM_Data_REGS * 4 - 1) downto 0) := (others => '0'); -- Int address buffer

begin

    process(clk, reset)
    begin
        if reset = '1' then
            -- Resets the buffers and mode
            data_buffer <= (others => '0');
        elsif rising_edge(clk)then
				if (keypad_input(4) /= '1' and keypulse = '1') then
					data_buffer <= data_buffer((NUM_Data_REGS * 4 - 5) downto 0) & keypad_input(3 downto 0);
            end if;
        end if;
			data_out <= data_buffer;
    end process;

end Behavioral;
