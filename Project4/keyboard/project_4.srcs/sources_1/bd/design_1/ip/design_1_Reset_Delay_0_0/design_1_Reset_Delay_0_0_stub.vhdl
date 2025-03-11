-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Mar 10 23:49:11 2025
-- Host        : UL-41 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/uonml/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_Reset_Delay_0_0/design_1_Reset_Delay_0_0_stub.vhdl
-- Design      : design_1_Reset_Delay_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_Reset_Delay_0_0 is
  Port ( 
    iCLK : in STD_LOGIC;
    oRESET : out STD_LOGIC
  );

end design_1_Reset_Delay_0_0;

architecture stub of design_1_Reset_Delay_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "iCLK,oRESET";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "Reset_Delay,Vivado 2019.1";
begin
end;
