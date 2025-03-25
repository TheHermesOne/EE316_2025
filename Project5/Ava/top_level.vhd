library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port(
        clk         : in std_logic;
        usb_tx      : in std_logic;
        usb_rx      : out std_logic;
        ps2_clk     : in std_logic; 
        ps2_data    : in std_logic;
        LCD_EN      : out std_logic;
        LCD_RS      : out std_logic;
        LCD_DATA    : out std_logic_vector(7 downto 0)
    );
end top_level;

architecture arch of top_level is 


    component Reset_Delay IS	
        PORT (
            SIGNAL iCLK : IN std_logic;	
            SIGNAL oRESET : OUT std_logic
                );	
    END component; 
    
    component clk_enabler is
        GENERIC (
            CONSTANT cnt_max : integer := 49999999);      --  1.0 Hz 
            port(	
                clock:		in std_logic;	 
                clk_en: 		out std_logic
            );
        end component;

    component ps2_keyboard_to_ascii IS
        GENERIC(
              clk_freq                  : INTEGER := 125_000_000; --system clock frequency in Hz
              ps2_debounce_counter_size : INTEGER := 10);         --set such that 2^size/clk_freq = 5us (size = 8 for 50MHz)
        PORT(
              clk        : IN  STD_LOGIC;                     --system clock input
              ps2_clk    : IN  STD_LOGIC;                     --clock signal from PS2 keyboard
              ps2_data   : IN  STD_LOGIC;                     --data signal from PS2 keyboard
              ascii_new  : OUT STD_LOGIC;                     --output flag indicating new ASCII value
              ascii_code : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --ASCII value
        END component;
        
    component uart is
        port (
                reset       :in  std_logic;
                txclk       :in  std_logic;
                ld_tx_data  :in  std_logic;
                tx_data     :in  std_logic_vector (7 downto 0);
                tx_enable   :in  std_logic;
                tx_out      :out std_logic;
                tx_empty    :out std_logic;
                rxclk       :in  std_logic;
                uld_rx_data :in  std_logic;
                rx_data     :out std_logic_vector (7 downto 0);
                rx_enable   :in  std_logic;
                rx_in       :in  std_logic;
                rx_empty    :out std_logic
            );
        end component;
        
    component LCD_Controller IS
        PORT (
            Reset        : IN std_logic;
            Data         : IN std_logic_vector(7 DOWNTO 0);
            iclk          : IN std_logic;
            LCD_RS, LCD_EN : OUT std_logic;
            LCD_DATA      : OUT std_logic_vector(7 DOWNTO 0)
        );
        END component;   

    signal reset_on         : std_logic;
    signal rx_clken         : std_logic;
    signal tx_clken         : std_logic;
    signal ascii_new        : std_logic;
    signal ascii_data_ps2   : std_logic_vector(7 downto 0);
    signal uart_rx_data     : std_logic_vector(7 downto 0);

begin 

    inst_reset_delay: reset_delay 
        port map(
            iclk    => clk,
            oRESET  => reset_on
        );
    inst_tx_clken: clk_enabler
        GENERIC map (cnt_max => 13201)    
            port map(	
                clock   => clk, 
                clk_en  => tx_clken
            );
    inst_rx_clken: clk_enabler
        GENERIC map (cnt_max => 800)    
            port map(	
                clock   => clk, 
                clk_en  => rx_clken
            );
    inst_keyboard: ps2_keyboard_to_ascii
        GENERIC map(
              clk_freq                  => 125000000, 
              ps2_debounce_counter_size => 10)         
        PORT map(
              clk        => clk,
              ps2_clk    => ps2_clk,
              ps2_data   => ps2_data,
              ascii_new  => ascii_new,
              ascii_code => ascii_data_ps2
        );
    inst_uart: uart
        port map(
            reset       => reset_on,
            txclk       => tx_clken,
            ld_tx_data  => ascii_new,
            tx_data     => ascii_data_ps2,
            tx_enable   => '1',
            tx_out      => usb_rx,
            tx_empty    => open,
            rxclk       => rx_clken,
            uld_rx_data => '1',
            rx_data     => uart_rx_data,
            rx_enable   => '1',
            rx_in       => usb_tx,
            rx_empty    => open
        );
    inst_lcd: LCD_controller
        port map(
            Reset        => reset_on,
            Data         => uart_rx_data,
            iclk         => clk,
            LCD_RS       => LCD_RS,
            LCD_EN       => LCD_EN,
            LCD_DATA     => LCD_DATA
        );
end arch;
        
        