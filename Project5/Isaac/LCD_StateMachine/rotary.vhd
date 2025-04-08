library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity rotary is
    generic(N: integer := 8);
    port (
        iCLK        : in std_logic; 
        reset       : in std_logic;
        A           : in std_logic;
        B           : in std_logic;
        left_tick   : out std_logic;
        right_tick  : out std_logic
    );
end rotary;

architecture Arch of rotary is

    component btn_debounce_toggle is
        generic (
            CNTR_MAX : std_logic_vector(15 downto 0) := X"FFFF"
        );
        port(
            BTN_I     : in std_logic;	 
            clk       : in std_logic;
            BTN_O     : out std_logic;
            TOGGLE_O  : out std_logic;
            PULSE_O   : out std_logic
        );
    end component;

    signal A_db, B_db     : std_logic := '0';
    signal A_prev         : std_logic := '0';

    signal left_tick_int  : std_logic := '0';
    signal right_tick_int : std_logic := '0';

begin

    left_tick  <= left_tick_int;
    right_tick <= right_tick_int;

    process(iCLK)
    begin
        if rising_edge(iCLK) then
            A_prev <= A_db;

            left_tick_int  <= '0';
            right_tick_int <= '0';

            if (A_prev = '0' and A_db = '1') then
                if B_db = '0' then
                    right_tick_int <= '1';  -- Clockwise
             else
                left_tick_int <= '1';   -- Counterclockwise
            end if;
        end if;
    end if;
    end process;



    -- Debounce A
    inst_A: btn_debounce_toggle
        generic map( CNTR_MAX => X"FFFF" )
        port map(
            BTN_I     => A,
            clk       => iCLK,
            BTN_O     => A_db,
            TOGGLE_O  => open,
            PULSE_O   => open
        );

    -- Debounce B
    inst_B: btn_debounce_toggle
        generic map( CNTR_MAX => X"FFFF" )
        port map(
            BTN_I     => B,
            clk       => iCLK,
            BTN_O     => B_db,
            TOGGLE_O  => open,
            PULSE_O   => open
        );

end Arch;
