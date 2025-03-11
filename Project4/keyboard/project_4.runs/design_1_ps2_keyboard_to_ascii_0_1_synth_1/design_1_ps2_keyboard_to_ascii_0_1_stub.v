// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Mar 10 23:53:24 2025
// Host        : UL-41 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_ps2_keyboard_to_ascii_0_1_stub.v
// Design      : design_1_ps2_keyboard_to_ascii_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ps2_keyboard_to_ascii,Vivado 2019.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, ps2_clk, ps2_data, ascii_new, ascii_code)
/* synthesis syn_black_box black_box_pad_pin="clk,ps2_clk,ps2_data,ascii_new,ascii_code[7:0]" */;
  input clk;
  input ps2_clk;
  input ps2_data;
  output ascii_new;
  output [7:0]ascii_code;
endmodule
