// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Mar 12 00:26:23 2025
// Host        : UL-31 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/nathani/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_2/ip/design_2_ps2_keyboard_to_ascii_0_0/design_2_ps2_keyboard_to_ascii_0_0_stub.v
// Design      : design_2_ps2_keyboard_to_ascii_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ps2_keyboard_to_ascii,Vivado 2019.1" *)
module design_2_ps2_keyboard_to_ascii_0_0(clk, ps2_clk, ps2_data, ascii_new, ascii_code)
/* synthesis syn_black_box black_box_pad_pin="clk,ps2_clk,ps2_data,ascii_new,ascii_code[7:0]" */;
  input clk;
  input ps2_clk;
  input ps2_data;
  output ascii_new;
  output [7:0]ascii_code;
endmodule
