library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LCD_Data_Cutter is
    port(
        iCLK                : IN std_logic;
        ready               : IN std_logic;
        LCD_Data            : IN std_logic_vector(11 downto 0);
        reset               : IN std_logic;
        Next_data           : OUT std_logic;
        LCD_Nibble          : OUT std_logic_vector(7 downto 0)   
        );
end LCD_Data_Cutter;

architecture Behavioral of LCD_Data_Cutter is

type state_type is (hn1, hn2, hn3, ln1, ln2, ln3);
signal current_state : state_type;
signal state_cnt    : integer range 0 to 5 := 0;
signal LCD_Controller_Pulse : std_logic;
signal ndTemp       : std_logic;
signal nd_prev      : std_logic;
signal Next_data_ready  : std_logic;
signal nd_sync   : std_logic_vector(1 downto 0)  := (others => '0');
signal state_cnt_prev   : integer := 0;
signal state_prev       : state_type;

begin

process(iCLK)
begin
    if rising_edge(iCLK) then
        case current_state is
        
            when hn1 =>
                LCD_Nibble <= LCD_Data(7 downto 4) & "100" & LCD_Data(8);
            when hn2 =>
                LCD_Nibble <= LCD_Data(7 downto 4) & "110" & LCD_Data(8);
            when hn3 =>
                LCD_Nibble <= LCD_Data(7 downto 4) & "100" & LCD_Data(8);    
            when ln1 =>
                LCD_Nibble <= LCD_Data(3 downto 0) & "100" & LCD_Data(8);
            when ln2 =>
                LCD_Nibble <= LCD_Data(3 downto 0) & "110" & LCD_Data(8);
            when ln3 =>
                LCD_Nibble <= LCD_Data(3 downto 0) & "100" & LCD_Data(8);  
    
        end case;
    end if;
end process;

--process(iclk)
--begin
--    if rising_edge(iCLK) then
--        state_cnt_prev <= state_cnt;
--        state_prev <= current_state;
--    end if;
--end process;
--process(current_state)
--begin
--    case state_cnt is
--        when 0 =>
--            current_state <= hn1;
--        when 1 =>
--            current_state <= hn2;
--        when 2 =>
--            current_state <= hn3;
--        when 3 =>
--            current_state <= ln1;
--        when 4 =>
--            current_state <= ln2;
--        when 5 =>
--            current_state <= ln3;
--    end case;
--end process;

process(iCLK)
begin
    if rising_edge(iCLK) then
        if reset = '1' then
            state_cnt <= 0;
            current_state <= hn1;  -- Ensure a known initial state
        elsif ready = '1' then
            -- Update state first, then increment state_cnt
            case state_cnt is
                when 0 =>
                    current_state <= hn1;
                when 1 =>
                    current_state <= hn2;
                when 2 =>
                    current_state <= hn3;
                when 3 =>
                    current_state <= ln1;
                when 4 =>
                    current_state <= ln2;
                when 5 =>
                    current_state <= ln3;
                when others =>
                    current_state <= hn1;
            end case;
            if state_cnt = 4 then
               Next_data_ready <= '1';
           else
               Next_data_ready <= '0';  
            end if;
            -- Now increment state_cnt
            if state_cnt = 5 then
                state_cnt <= 0;
            else
                state_cnt <= state_cnt + 1;
            end if;
        end if;
    end if;
end process;
            
process(Next_data_ready)
begin
nd_prev <= Next_data_ready;
	if Next_data_ready = '0' and nd_prev = '1' then
		ndTemp <= '1';
	else
		ndTemp <= '0';
	end if;
end process;

process(iCLK)
begin
	if rising_edge(ICLK) then
		nd_sync(0) <= ndTemp;
		nd_sync(1) <= nd_sync(0);
		Next_data <= not nd_sync(1) and nd_sync(0);
	end if;
end process;

end Behavioral;
        
--    -- Upper and Lower Nibble converter --

--    procedure Convert_To_LCD_4bit(
--        ascii_data : in STD_LOGIC_VECTOR(11 downto 0);
--        lcd_data_high : out STD_LOGIC_VECTOR(7 downto 0);
--        lcd_data_low : out STD_LOGIC_VECTOR(7 downto 0)
--    ) is
--        variable high_nibble : STD_LOGIC_VECTOR(3 downto 0);
--        variable low_nibble : STD_LOGIC_VECTOR(3 downto 0);
--    begin
        
--        high_nibble := ascii_data(7 downto 4);
--        low_nibble := ascii_data(3 downto 0);
        
--        if ascii_data(8) = '1' then
--            lcd_data_high := high_nibble & "1011"; -- RS=1, RW=0, High nibble data
--            lcd_data_low := low_nibble & "1011"; -- RS=1, RW=0, Low nibble data
--        else
--            lcd_data_high := high_nibble & "1010"; -- RS=0, RW=0, High nibble command
--            lcd_data_low := low_nibble & "1010"; -- RS=0, RW=0, Low nibble command
--        end if;
--    end procedure Convert_To_LCD_4bit;

--    -- Temp Signals --
    
--    signal LCD_Unibble     : std_logic_vector(7 downto 0);
--    signal LCD_Lnibble     : std_logic_vector(7 downto 0);
--    signal lcd_data_high    : std_logic_vector(7 downto 0);
--    signal lcd_data_low     : std_logic_vector(7 downto 0);
--    signal clk_cnt          : integer := 0;
--    signal clk_nibble_lim   : integer := 41665;
--    signal nibble_en        : std_logic;
    
       
--begin

--    process(iCLK)
--    begin
--        if rising_edge(iCLK) then
--            clk_cnt <= clk_cnt + 1;
--        end if;
        
--        if clk_cnt >= clk_nibble_lim then
--            nibble_en <= '1';
--            clk_cnt <= 0;
--        else
--            nibble_en <= '0';
--        end if;
--    end process;

         
---- 4-BIT LCD DATA CUT CALL --
--    process(clk_en)
--    begin
--        if clk_en = '1' then
--                 Convert_To_LCD_4bit(LCD_Data, LCD_Unibble, LCD_Lnibble);
--        end if;
--    end process;
    
---- ASCII SPLITTER --

--    process(LCD_Nibble)
--    begin

