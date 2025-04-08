----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2025 01:37:33 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
  Port ( 
  iclk          : in std_logic;
  ps2_clk       : IN  STD_LOGIC;                     --clock signal from PS2 keyboard
  ps2_data      : IN  STD_LOGIC; 
  led0_r        : out std_logic;
  led0_g        : out std_logic;
  led0_b        : out std_logic;
  oSDA          : inout STD_LOGIC;   
  oSCL          : inout STD_LOGIC;         
  usb_tx        : in  std_logic;
  usb_rx        : out std_logic;
  A_x           : in std_logic;
  B_x           : in std_logic;
  A_y           : in std_logic;
  B_y           : in std_logic       
  );
end top_level;

architecture Behavioral of top_level is
component Reset_Delay IS  
        PORT (
            SIGNAL iCLK : IN std_logic; 
            SIGNAL oRESET : OUT std_logic
        );  
    END component;
    
 component rotary is
        generic(N: integer := 8; N2: integer := 255; N1: integer := 0);
        port (
        iCLK                    : in std_logic; 
        reset                   : in std_logic;
        A                       : in std_logic; -- A value
        B                       : in std_logic; -- B value
        left_tick               : out std_logic;
        right_tick              : out std_logic
        );
    end component;

component I2C_user_logic is							
    Port ( 
           iclk         : in STD_LOGIC;
           oSDA         : inout STD_LOGIC;
           input1       : in     std_logic_vector(127 downto 0);
           input2       : in     std_logic_vector(127 downto 0);
           oSCL         : inout STD_LOGIC
           );
end component;

component btn_debounce_toggle is
GENERIC (
	CONSTANT CNTR_MAX : std_logic_vector(15 downto 0) := X"FFFF");  
    Port ( BTN_I 	: in  STD_LOGIC;
           CLK 		: in  STD_LOGIC;
           BTN_O 	: out  STD_LOGIC;
           TOGGLE_O : out  STD_LOGIC;
		   PULSE_O  : out STD_LOGIC);
end component; 

component Shift_Register is
    GENERIC (
    CONSTANT sr_depth : integer := 128);    
        port(
        clock: in std_logic;
        reset : in std_logic;
        back : in std_logic;
        en: in std_logic;
        sr_in: in std_logic_vector(7 downto 0);
        sr_out: out std_logic_vector(sr_depth-1 downto 0) :=(others => '0')
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

component state_machine is
port (
clk         : in std_logic;
lcd_data    : in std_logic_vector(127 downto 0);
--ascii_code  : in std_logic_vector(7 downto 0);
--ascii_new   : in std_logic;
state_out   : out std_logic_vector(63 downto 0) -- 63 downto 16 = color; 15 downto 8 = cursor size; 7 downto 0 = screen size
);
end component;

component clk_enabler is
	GENERIC (
		CONSTANT cnt_max : integer);      --  1.0 Hz 
	port(	
		clock:		in std_logic;	 
		clk_en: 		out std_logic
	);
end component;

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
-------------------------------------------------------------------------------------------------------------------
-- Signals
signal ascii_new_sig            : std_logic;
signal ascii_new_prev           : std_logic;
signal ascii_code_sig           : std_logic_vector(7 downto 0);
signal ascii_code_sig_prev      : std_logic_vector(7 downto 0);
signal sr_in_sig                : std_logic_vector(7 downto 0);
signal state_sig                : std_logic_vector(6 downto 0);
signal sr_out_sig               : std_logic_vector(127 downto 0);
signal sr_out_uart_active       : std_logic_vector(127 downto 0);
signal sr_out_uart_final        : std_logic_vector(127 downto 0);
signal sr_out_lcd               : std_logic_vector(127 downto 0);
signal back_sig                 : std_logic := '0';
signal sr_en                    : std_logic;
signal sr_reset                 : std_logic;
signal input2_sig               : std_logic_vector(127 downto 0) := x"63303030303030207731207331202020";
signal state_out_sig            : std_logic_vector(63 downto 0);
signal red                      : std_logic_vector(15 downto 0);
signal green                    : std_logic_vector(15 downto 0);
signal blue                     : std_logic_vector(15 downto 0);
signal rx_clk                   : std_logic;
signal tx_clk                   : std_logic;
signal count                    : integer;
signal shift_count              : integer;
signal tx_out_sig               : std_logic;
signal rx_data_sig              : std_logic_vector(7 downto 0);
signal rx_in_sig                : std_logic;
signal rx_empty_sig             : std_logic;
signal rx_full                  : std_logic;
signal uart_en                  : std_logic;
signal uart_en_prev             : std_logic;
signal ascii_code_uart          : std_logic_vector(7 downto 0);
signal ascii_code_ps2           : std_logic_vector(7 downto 0);
signal enter_flag               : std_logic;
signal rotary_x_left_tick  : std_logic;
    signal rotary_x_right_tick : std_logic;
    signal rotary_y_left_tick  : std_logic;
    signal rotary_y_right_tick : std_logic;
    signal prev_x_left_tick   : std_logic := '0';
    signal prev_x_right_tick  : std_logic := '0';
    signal prev_y_left_tick   : std_logic := '0';
    signal prev_y_right_tick  : std_logic := '0';
signal cursor_x        : integer := 0;                     -- X cursor position
    signal cursor_y        : integer := 0;
signal red_val, blue_val, green_val :integer := 0;
  signal uart_tx_data     : std_logic_vector(7 downto 0);
  signal reset_on         : std_logic;
  signal uart_wr            : std_logic := '0';    
begin    

process(iclk, reset_on) -- ava rotary control
begin
    if reset_on = '1' then
        uart_tx_data <= (others => '0');
        uart_wr <= '0';

        prev_x_left_tick   <= '0';
        prev_x_right_tick  <= '0';
        prev_y_left_tick   <= '0';
        prev_y_right_tick  <= '0';

    elsif rising_edge(iclk) then
        uart_wr <= '0'; -- default no write

        -- Rising edge detection
        if rotary_x_left_tick = '1' and prev_x_left_tick = '0' then
            uart_tx_data <= x"68"; -- 'f'
            uart_wr <= '1';
        elsif rotary_x_right_tick = '1' and prev_x_right_tick = '0' then
            uart_tx_data <= x"66"; -- 'h'
            uart_wr <= '1';
        elsif rotary_y_left_tick = '1' and prev_y_left_tick = '0' then
            uart_tx_data <= x"67"; -- 't'
            uart_wr <= '1';
        elsif rotary_y_right_tick = '1' and prev_y_right_tick = '0' then
            uart_tx_data <= x"74"; -- 'g'
            uart_wr <= '1';
        end if;

        -- Store previous states
        prev_x_left_tick   <= rotary_x_left_tick;
        prev_x_right_tick  <= rotary_x_right_tick;
        prev_y_left_tick   <= rotary_y_left_tick;
        prev_y_right_tick  <= rotary_y_right_tick;
    end if;
end process;

process(iclk) -- keyboard/lcd/led control
begin
    if rising_edge(iclk) then
        ascii_new_prev      <= ascii_new_sig;
        uart_en_prev        <= uart_en;
        ascii_code_sig_prev <= ascii_code_sig;

        sr_en     <= '0';
        sr_reset  <= '0';
        back_sig  <= '0';

        if uart_en_prev = '1' and uart_en = '0' and ascii_code_uart /= x"0D" then
            ascii_code_sig <= ascii_code_uart;
            sr_en <= '1';
        elsif ascii_new_prev = '0' and ascii_new_sig = '1' then
            if ascii_code_ps2 /= x"0D" then
                ascii_code_sig <= ascii_code_ps2;
                sr_en <= '1';
            end if;
        end if;

        if ascii_code_ps2 = x"08" then
            back_sig <= '1';
        end if;

        if ascii_new_prev = '0' and ascii_new_sig = '1' then
        --------------------------------------------------------------------------------------------------------------------
            if ascii_code_ps2 = x"0D" then
                enter_flag <= '1';
                input2_sig <= x"63" & state_out_sig(63 downto 16) & x"2077" & state_out_sig(15 downto 8) & x"2073" & state_out_sig(7 downto 0) & x"202020";
                count <= 0;
                red   <= state_out_sig(63 downto 48);
                green <= state_out_sig(47 downto 32);
                blue  <= state_out_sig(31 downto 16);

                red_val   <= to_integer(unsigned(red));
                green_val <= to_integer(unsigned(green));
                blue_val  <= to_integer(unsigned(blue));

   

                if red_val > green_val and red_val > blue_val then -- red
                    led0_r <= '1';
                    led0_g <= '0';
                    led0_b <= '0';
                elsif green_val > red_val and green_val > blue_val then
                    led0_r <= '0';
                    led0_g <= '1';
                    led0_b <= '0';
                elsif blue_val > red_val and blue_val > green_val then
                    led0_r <= '0';
                    led0_g <= '0';
                    led0_b <= '1';
                elsif red_val = blue_val and red_val /= green_val then
                    led0_r <= '1';
                    led0_g <= '0';
                    led0_b <= '1'; -- purple
                elsif red_val = green_val and red_val /= blue_val then
                    led0_r <= '1';
                    led0_g <= '1';
                    led0_b <= '0'; -- orange
                elsif green_val = blue_val and green_val /= red_val then
                    led0_r <= '0';
                    led0_g <= '1';
                    led0_b <= '1'; -- cyan
                elsif red_val = 26214 and green_val = 26214 and blue_val = 26214 then
                    led0_r <= '1';
                    led0_g <= '1';
                    led0_b <= '1'; -- white
                elsif red_val = 0 and green_val = 0 and blue_val = 0 then
                    led0_r <= '0';
                    led0_g <= '0';
                    led0_b <= '0'; -- black
                end if;
            end if;
        end if;
        if enter_flag = '1' then
            if count < 1000 then
                count <= count + 1;
            else
                sr_reset <= '1';
                enter_flag <= '0';
            end if;
        end if;

        
    end if;
end process;
    

rx_full <= not rx_empty_sig;

inst_reset_delay: reset_delay 
        port map(
            iclk    => iclk,
            oRESET  => reset_on
        );

     -- Rotary Encoder Component
inst_rotary_x: rotary
        port map (
            iCLK        => iclk,
            reset       => reset_on,
            A           => A_x,
            B           => B_x,
            left_tick   => rotary_x_left_tick,
            right_tick  => rotary_x_right_tick
        );

    -- Rotary Encoder for Y (reuse A/B for demo or expand as needed)
inst_rotary_y: rotary
        port map (
            iCLK        => iclk,
            reset       => reset_on,
            A           => A_y,
            B           => B_y,
            left_tick   => rotary_y_left_tick,
            right_tick  => rotary_y_right_tick
        );   

inst_keyboard: ps2_keyboard_to_ascii
    GENERIC MAP(
        clk_freq                  => 125_000_000,
        ps2_debounce_counter_size => 10
        )
    PORT MAP(
        clk => iclk, 
        ps2_clk     => ps2_clk,
        ps2_data    => ps2_data,
        ascii_new   => ascii_new_sig,
        ascii_code  => ascii_code_ps2
        );

inst_shift_lcd: shift_register
    generic map(
        sr_depth => 128
        )
    port map(
        clock   => iclk,
        reset   => sr_reset,
        en      => sr_en,
        back    => back_sig,
        sr_in   => ascii_code_sig,
        sr_out  => sr_out_lcd
        );
    

inst_LCD: I2C_user_logic
    port map(
        iclk    => iclk,
        oSDA    => oSDA,
        oSCL    => oSCL,
        input1  => sr_out_lcd,
        input2  => input2_sig
        );

inst_state: state_machine
    port map(
        clk         => iclk,
--        ascii_code  => ascii_code_sig_prev,
--        ascii_new   => ascii_new_sig,
        lcd_data    => sr_out_lcd,
        state_out   => state_out_sig
        );
        
inst_uart: uart 
    port map(
            reset       => reset_on,
            txclk       => tx_clk,
            ld_tx_data  => '1',
            tx_data     => uart_tx_data,
            tx_enable   => '1',
            tx_out      => usb_rx,
            tx_empty    => open,
            rxclk       => rx_clk,
            uld_rx_data => '1',
            rx_data     => ascii_code_uart,
            rx_enable   => '1',
            rx_in       => usb_tx,
            rx_empty    => rx_empty_sig
            );

tx_inst: clk_enabler
    GENERIC map(
        cnt_max => 13201  
    )     
    PORT map(    
        clock  => iclk,     
        clk_en => tx_clk
    );  
    
rx_inst: clk_enabler
    GENERIC map(
        cnt_max => 13201  
    )     
    PORT map(    
        clock  => iclk,     
        clk_en => rx_clk
    );  

inst_debounce: btn_debounce_toggle 
GENERIC map(
	 CNTR_MAX => X"0001"
	 )  
    Port map
    (       BTN_I 	=> rx_full,
           CLK 		=> iclk,
           BTN_O 	=> open,
           TOGGLE_O => open,
		   PULSE_O  => uart_en
);

end behavioral;