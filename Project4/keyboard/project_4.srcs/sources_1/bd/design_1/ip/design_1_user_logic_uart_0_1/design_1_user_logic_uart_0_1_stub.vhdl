-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Mar 12 03:31:21 2025
-- Host        : UL-31 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/nathani/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_user_logic_uart_0_1/design_1_user_logic_uart_0_1_stub.vhdl
-- Design      : design_1_user_logic_uart_0_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_user_logic_uart_0_1 is
  Port ( 
    clk : in STD_LOGIC;
    utx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    ureset : in STD_LOGIC;
    utxclk : in STD_LOGIC;
    utx_en : in STD_LOGIC;
    utx_out : out STD_LOGIC
  );

end design_1_user_logic_uart_0_1;

architecture stub of design_1_user_logic_uart_0_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,utx_data[7:0],ureset,utxclk,utx_en,utx_out";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "user_logic_uart,Vivado 2019.1";
begin
end;
