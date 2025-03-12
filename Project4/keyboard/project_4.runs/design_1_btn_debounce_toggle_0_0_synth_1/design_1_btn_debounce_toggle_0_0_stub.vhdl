-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Tue Mar 11 22:20:17 2025
-- Host        : UL-31 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_btn_debounce_toggle_0_0_stub.vhdl
-- Design      : design_1_btn_debounce_toggle_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    BTN_I : in STD_LOGIC;
    CLK : in STD_LOGIC;
    BTN_O : out STD_LOGIC;
    TOGGLE_O : out STD_LOGIC;
    PULSE_O : out STD_LOGIC
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "BTN_I,CLK,BTN_O,TOGGLE_O,PULSE_O";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "btn_debounce_toggle,Vivado 2019.1";
begin
end;
