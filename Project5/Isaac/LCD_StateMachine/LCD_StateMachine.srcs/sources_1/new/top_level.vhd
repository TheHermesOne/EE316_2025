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
  oSCL          : inout STD_LOGIC                  
  );
end top_level;

architecture Behavioral of top_level is
component I2C_user_logic is							
    Port ( 
           iclk         : in STD_LOGIC;
           oSDA         : inout STD_LOGIC;
           input1       : in     std_logic_vector(127 downto 0);
           input2       : in     std_logic_vector(127 downto 0);
           oSCL         : inout STD_LOGIC
           );
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
ascii_code  : in std_logic_vector(7 downto 0);
ascii_new   : in std_logic;
state_out   : out std_logic_vector(63 downto 0) -- 63 downto 16 = color; 15 downto 8 = cursor size; 7 downto 0 = screen size
);
end component;
-------------------------------------------------------------------------------------------------------------------
-- Signals
signal ascii_new_sig            : std_logic;
signal ascii_new_prev           : std_logic;
signal ascii_code_sig           : std_logic_vector(7 downto 0);
signal sr_in_sig                : std_logic_vector(7 downto 0);
signal state_sig                : std_logic_vector(6 downto 0);
signal sr_out_sig               : std_logic_vector(127 downto 0);
signal back_sig                 : std_logic := '0';
signal sr_en                    : std_logic;
signal sr_reset                 : std_logic;
signal input2_sig               : std_logic_vector(127 downto 0);
signal state_out_sig            : std_logic_vector(63 downto 0) ;
signal red                      : std_logic_vector(7 downto 0);
signal green                    : std_logic_vector(7 downto 0);
signal blue                     : std_logic_vector(7 downto 0);

signal count                    : integer;
--signal muxed_sr_input_prev      : std_logic_vector(7 downto 0);
--signal muxed_sr_input           : std_logic_vector(7 downto 0);
begin



process(ascii_code_sig, ascii_new_sig)
begin
    if ascii_code_sig = x"08" then
        back_sig <= '1'; 
    else
        back_sig <= '0';
    end if;
    if ascii_code_sig = x"0D" then
        if count < 50_000_000 then
            count <= count + 1;
        else
            sr_reset <= '1';
            count <= 0;
        end if;
    else 
        sr_in_sig <= ascii_code_sig;
        sr_reset <= '0';
    end if;
end process;
        
process(iclk)
begin
    if rising_edge(iclk) then

        ascii_new_prev <= ascii_new_sig;
        if ascii_new_sig = '1' and ascii_new_prev = '0' and ascii_code_sig /= x"0D" then
            sr_en <= '1';
        else
            sr_en <= '0';
        end if;
    end if;
end process;      

process(state_out_sig)
begin
    input2_sig <= x"63" & state_out_sig(63 downto 16) & x"2077" & state_out_sig(15 downto 8) & x"2073" & state_out_sig(7 downto 0) & x"202020"; -- led 2nd line display
--    red   <= unsigned(state_out_sig(63 downto 48));
--    green <= unsigned(state_out_sig(47 downto 32));
--    blue  <= unsigned(state_out_sig(31 downto 16));
--    if red > green and red > blue then -- red
--        led0_r     <= '1';
--        led0_g     <= '0';
--        led0_b     <= '0';
--    elsif green > blue and green > red then -- green
--        led0_r     <= '0';
--        led0_g     <= '1';
--        led0_b     <= '0';
--    elsif blue > red and blue > green then -- blue
--        led0_r     <= '0';
--        led0_g     <= '0';
--        led0_b     <= '1';
--    elsif blue = red and blue /= green then-- purple
--        led0_r     <= '1';
--        led0_g     <= '0';
--        led0_b     <= '1';
--    elsif green = red and green /= blue then-- orange
--        led0_r     <= '1';
--        led0_g     <= '1';
--        led0_b     <= '0';
--    elsif green = blue and green /= red then -- cyan
--        led0_r     <= '0';
--        led0_g     <= '1';
--        led0_b     <= '1';
--    elsif green = 65535 and red = 65535 and blue = 65535 then -- white
--        led0_r     <= '1';
--        led0_g     <= '1';
--        led0_b     <= '1';
--    elsif green = 0 and red = 0 and blue = 0 then -- black
--        led0_r     <= '0';
--        led0_g     <= '0';
--        led0_b     <= '0';
--    end if;
end process;
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
        ascii_code  => ascii_code_sig
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
        sr_out  => sr_out_sig
        );
 
inst_shift_uart: shift_register
    generic map(
        sr_depth => 128
        )
    port map(
        clock   => iclk,
        reset   => sr_reset,
        en      => sr_en,
        back    => back_sig,
        sr_in   => ascii_code_sig,
        sr_out  => sr_out_sig
        );       

inst_LCD: I2C_user_logic
    port map(
        iclk    => iclk,
        oSDA    => oSDA,
        oSCL    => oSCL,
        input1  => sr_out_sig,
        input2  => input2_sig
        );

inst_state: state_machine
    port map(
        clk         => iclk,
        ascii_code  => ascii_code_sig,
        ascii_new   => ascii_new_sig,
        lcd_data    => sr_out_sig,
        state_out   => state_out_sig
        );

end Behavioral;
