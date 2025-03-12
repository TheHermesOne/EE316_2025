// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Mar 12 02:42:47 2025
// Host        : UL-31 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/nathani/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_baud_rate_0_0/design_1_baud_rate_0_0_stub.v
// Design      : design_1_baud_rate_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "baud_rate,Vivado 2019.1" *)
module design_1_baud_rate_0_0(clk, baud)
/* synthesis syn_black_box black_box_pad_pin="clk,baud" */;
  input clk;
  output baud;
endmodule
