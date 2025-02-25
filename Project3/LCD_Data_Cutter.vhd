library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LCD_Data_Cutter is
    port(
        iCLK                : IN std_logic;
        ready               : IN std_logic;
        LCD_Data            : IN std_logic_vector(11 downto 0);
        clk_en              : IN std_logic;
        LCD_Nibble          : OUT std_logic_vector(7 downto 0)   
        );
end LCD_Data_Cutter;

architecture Behavioral of LCD_Data_Cutter is

    -- Upper and Lower Nibble converter --

    procedure Convert_To_LCD_4bit(
        ascii_data : in STD_LOGIC_VECTOR(11 downto 0);
        lcd_data_high : out STD_LOGIC_VECTOR(7 downto 0);
        lcd_data_low : out STD_LOGIC_VECTOR(7 downto 0)
    ) is
        variable high_nibble : STD_LOGIC_VECTOR(3 downto 0);
        variable low_nibble : STD_LOGIC_VECTOR(3 downto 0);
    begin
        
        high_nibble := ascii_data(7 downto 4);
        low_nibble := ascii_data(3 downto 0);
        
        if ascii_data(8) = '1' then
            lcd_data_high := high_nibble & "1011"; -- RS=1, RW=0, High nibble data
            lcd_data_low := low_nibble & "1011"; -- RS=1, RW=0, Low nibble data
        else
            lcd_data_high := high_nibble & "1010"; -- RS=0, RW=0, High nibble command
            lcd_data_low := low_nibble & "1010"; -- RS=0, RW=0, Low nibble command
        end if;
    end procedure Convert_To_LCD_4bit;

    -- Temp Signals --
    
    signal LCD_Unibble     : std_logic_vector(7 downto 0);
    signal LCD_Lnibble     : std_logic_vector(7 downto 0);
    signal lcd_data_high    : std_logic_vector(7 downto 0);
    signal lcd_data_low     : std_logic_vector(7 downto 0);
    signal clk_cnt          : integer := 0;
    signal clk_nibble_lim   : integer := 41665;
    signal nibble_en        : std_logic;
    
       
begin

    process(iCLK)
    begin
        if rising_edge(iCLK) then
            clk_cnt <= clk_cnt + 1;
        end if;
        
        if clk_cnt >= clk_nibble_lim then
            nibble_en <= '1';
            clk_cnt <= 0;
        else
            nibble_en <= '0';
        end if;
    end process;

         
-- 4-BIT LCD DATA CUT CALL --
    process(clk_en)
    begin
        if clk_en = '1' then
                 Convert_To_LCD_4bit(LCD_Data, LCD_Unibble, LCD_Lnibble);
        end if;
    end process;
    
-- ASCII SPLITTER --

    process(LCD_Nibble, iCLK)
    begin
        
    
    
    
    
    




end Behavioral;

