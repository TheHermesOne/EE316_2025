-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Mar 12 00:26:23 2025
-- Host        : UL-31 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/nathani/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_2/ip/design_2_ps2_keyboard_to_ascii_0_0/design_2_ps2_keyboard_to_ascii_0_0_stub.vhdl
-- Design      : design_2_ps2_keyboard_to_ascii_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_2_ps2_keyboard_to_ascii_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    ps2_clk : in STD_LOGIC;
    ps2_data : in STD_LOGIC;
    ascii_new : out STD_LOGIC;
    ascii_code : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end design_2_ps2_keyboard_to_ascii_0_0;

architecture stub of design_2_ps2_keyboard_to_ascii_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,ps2_clk,ps2_data,ascii_new,ascii_code[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "ps2_keyboard_to_ascii,Vivado 2019.1";
begin
end;
