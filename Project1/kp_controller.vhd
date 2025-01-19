-- kp_controller
-- ava lamontagne 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity KP_Controller is
    Port (
        clk         : in  std_logic;     --1HZ
        reset       : in  std_logic;    
        keypad_rows : in  std_logic_vector(3 downto 0); 
        keypad_columns : out std_logic_vector(4 downto 0);
        key_code    : out std_logic_vector(4 downto 0);
        key_pulse   : out std_logic       
    );
end KP_Controller;

architecture Behavioral of KP_Controller is
-- state machine for key pressing
    type state_type is (STATE_INIT, STATE_FIND_ROW, STATE_VALID_KEY);
    signal current_state, next_state : state_type;

-- separate state machine for each column to be debounced
    type debounce_state_type is (DB_STATE_A, DB_STATE_B, DB_STATE_C, DB_STATE_D);
    signal current_debounce_state, next_debounce_state : debounce_state_type;

    signal key_press         : std_logic;                  
    signal key_valid_signal  : std_logic;      
    signal column_signal     : std_logic_vector(4 downto 0);
    signal row_signal        : std_logic_vector(3 downto 0);
    signal key_position      : integer range 0 to 18;       -- location of key
    signal debounce_counter  : integer range 0 to 5000 := 0; -- 5ms for debouncing             
  

    constant key_layout : std_logic_vector(4 downto 0) := 
        ("00000", "00001", "00010", "00011", "00100", 
         "00101", "00110", "00111", "01000", "01001", 
         "01010", "01011", "01100", "01101", "01110", 
         "01111", "10000", "10001", "10010");        

begin

    keypad_columns <= column_signal;

-- state machine for finding key
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= STATE_INIT;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, key_valid_signal, key_press, row_signal)
    begin
        next_state <= current_state;
        column_signal <= "00001"; 

        case current_state is
            when STATE_INIT =>
                if key_valid_signal = '0' then
                    next_state <= STATE_FIND_ROW;
                end if;

            when STATE_FIND_ROW =>
                for row_index in 0 to 3 loop
                     column_signal(row_index) <= '1';
                    if key_press = '1' then
                        key_position <= row_index * 5 + to_integer(unsigned(column_signal));
                        next_state <= STATE_VALID_KEY;
                    end if;
                end loop;

            when STATE_VALID_KEY =>
                if key_valid_signal = '1' then
                    key_code <= std_logic_vector(to_unsigned(key_position, 5));
                    key_valid_signal <= '1';
                    next_state <= STATE_INIT;
                end if;
        end case;
    end process;

    -- state machine for debouncing
    process(clk, reset)
    begin
        if reset = '1' then
            current_debounce_state <= DB_STATE_A;
        elsif rising_edge(clk) then
            current_debounce_state <= next_debounce_state;
        end if;
    end process;

    process(current_debounce_state, key_press, debounce_counter)
    begin
        next_debounce_state <= current_debounce_state;

        case current_debounce_state is
            when DB_STATE_A =>
                if key_press = '1' then
                    next_debounce_state <= DB_STATE_B;
                end if;

            when DB_STATE_B =>
                if debounce_counter < 5000 then  -- 5ms delay added for db
                    debounce_counter <= debounce_counter + 1;
                else
                    next_debounce_state <= DB_STATE_C;
                end if;

            when DB_STATE_C =>
                if key_press = '0' then
                    next_debounce_state <= DB_STATE_D;
                end if;

            when DB_STATE_D =>
                next_debounce_state <= DB_STATE_A;
        end case;
    end process;

    -- 5ms delay timer/counter
    process(clk, reset)
    begin
        if reset = '1' then
            debounce_counter <= 0;
        elsif rising_edge(clk) then
            if current_debounce_state = DB_STATE_B and debounce_counter < 5000 then
                debounce_counter <= debounce_counter + 1;
            else
                debounce_counter <= 0;
            end if;
        end if;
    end process;

    key_press <= NOT(row_signal(0) AND row_signal(1) AND row_signal(2) AND row_signal(3));

    -- valid debounced key press signal output
    key_valid_signal <= '1' when current_debounce_state = DB_STATE_C else '0';

end Behavioral;
