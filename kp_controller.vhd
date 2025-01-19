-- kp_controller
-- ava lamontagne 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity KP_Controller is
    Port (
        clk         : in  std_logic;      -- System clock
        reset       : in  std_logic;      -- Reset signal
        rows        : in  std_logic_vector(3 downto 0); 
        cols        : out std_logic_vector(4 downto 0);
        oData       : out std_logic_vector(4 downto 0);
        kp_pulse    : out std_logic       
    );
end KP_Controller;

architecture Behavioral of KP_Controller is
-- state machine for key pressing
    type state_type is (INIT, FIND_ROW, VALID_KEY);
    signal current_state, next_state : state_type;

-- separate state machine for each row to be debounced
    type db_state_type is (A, B, C, D);
    signal current_db_state, next_db_state : db_state_type;

    signal kp             : std_logic;                  
    signal key_valid      : std_logic;      
    signal column_valid   : std_logic_vector(4 downto 0);
    signal row_input      : std_logic_vector(3 downto 0);
    signal key_loc        : integer range 0 to 18;       -- location of key
    signal debounce_int   : integer range 0 to 5000 := 0; -- 5ms for debouncing             
  

    constant key_layout : std_logic_vector(4 downto 0) := 
        ("00000", "00001", "00010", "00011", "00100", 
         "00101", "00110", "00111", "01000", "01001", 
         "01010", "01011", "01100", "01101", "01110", 
         "01111", "10000", "10001", "10010");        

begin

    -- Column Driving Logic
    cols <= col_active;

    -- **Row Scanning State Machine**
    process(clk, reset)
    begin
        if reset = '1' then
            current_scan_state <= IDLE;
        elsif rising_edge(clk) then
            current_scan_state <= next_scan_state;
        end if;
    end process;

    process(current_scan_state, stable_key, kp, row_input)
    begin
        -- Default values
        next_scan_state <= current_scan_state;
        col_active <= "00001"; -- Default first column

        case current_scan_state is
            when IDLE =>
                if stable_key = '0' then
                    next_scan_state <= SCAN_ROW;
                end if;

            when SCAN_ROW =>
                for row_idx in 0 to 3 loop
                    col_active(row_idx) <= '1';
                    if kp = '1' then
                        key_position <= row_idx * 5 + to_integer(unsigned(col_active));
                        next_scan_state <= PROCESS_KEY;
                    end if;
                end loop;

            when PROCESS_KEY =>
                if stable_key = '1' then
                    key_code <= std_logic_vector(to_unsigned(key_position, 5));
                    key_valid <= '1';
                    next_scan_state <= IDLE;
                end if;
        end case;
    end process;

    -- **Debounce State Machine**
    process(clk, reset)
    begin
        if reset = '1' then
            current_debounce_state <= A;
        elsif rising_edge(clk) then
            current_debounce_state <= next_debounce_state;
        end if;
    end process;

    process(current_debounce_state, kp, debounce_timer)
    begin
        -- Default next state
        next_debounce_state <= current_debounce_state;

        case current_debounce_state is
            when A =>
                if kp = '1' then
                    next_debounce_state <= B;
                end if;

            when B =>
                if debounce_timer < 5000 then
                    debounce_timer <= debounce_timer + 1;
                else
                    next_debounce_state <= C;
                end if;

            when C =>
                if kp = '0' then
                    next_debounce_state <= D;
                end if;

            when D =>
                next_debounce_state <= A;
        end case;
    end process;

    -- Debounce Timer Logic
    process(clk, reset)
    begin
        if reset = '1' then
            debounce_timer <= 0;
        elsif rising_edge(clk) then
            if current_debounce_state = B and debounce_timer < 5000 then
                debounce_timer <= debounce_timer + 1;
            else
                debounce_timer <= 0;
            end if;
        end if;
    end process;

    -- Key Press Signal
    kp <= NOT(row_input(0) AND row_input(1) AND row_input(2) AND row_input(3));

    -- Stable Key Signal
    stable_key <= '1' when current_debounce_state = C else '0';

end Behavioral;
