----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2025 12:55:15 PM
-- Design Name: 
-- Module Name: tb_kb - Behavioral
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


entity tb_kb is
--  Port ( );
end tb_kb;


architecture Behavioral of tb_kb is
component ps2_keyboard is 
PORT(
    clk          : IN  STD_LOGIC;                     --system clock
    ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
    ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
    ps2_code_new : OUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
    ps2_code     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --code received from PS/2
end component; 


component debounce is 
 PORT(
    clk     : in STD_LOGIC;  --input clock
    button  : in STD_LOGIC;  --input signal to be debounced
    result  : out STD_LOGIC); --debounced signal

end component;
    signal clk          : STD_LOGIC:='1';                     --system clock
    signal ps2_clk      : STD_LOGIC:='1';                     --clock signal from PS/2 keyboard
    signal ps2_data     : STD_LOGIC;                     --data signal from PS/2 keyboard
    signal ps2_code_new : STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
    signal ps2_code     : STD_LOGIC_VECTOR(7 DOWNTO 0);--code received from PS/2
    signal button          : STD_LOGIC;  
    signal result          : STD_LOGIC;  
begin
uut: ps2_keyboard port map (
clk             =>  clk,
ps2_clk         =>  ps2_clk,
ps2_data        =>  ps2_data,
ps2_code_new    =>  ps2_code_new,
ps2_code        =>  ps2_code
);

dut: debounce port map (
clk             =>  clk,
button          =>  button,
result          =>  result
);
clk<= not clk after 10 ms;


process 
begin 
wait for 400 ns;
    button<='1';
    
wait for 5 ms;
    button<='0';
    
wait for 5 ms; 
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
    
wait for 20 ns;
    ps2_data<= '0';
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
    
wait for 20 ns;
    ps2_data<= '0';
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
    
wait for 20 ns;
    ps2_data<= '1';
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
wait for 20 ns;
    ps2_data<= '1';
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
    
wait for 20 ns;
    ps2_data<= '0';
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
    
wait for 20 ns;
    ps2_data<= '0';
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
    
wait for 20 ns;
    ps2_data<= '1';
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
    
wait for 20 ns;
    ps2_clk <='0';
    
wait for 20 ns;
    ps2_clk <='1';
    
wait for 20 ns;

end process; 
end Behavioral;
