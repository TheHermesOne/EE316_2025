// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Mar 10 23:53:22 2025
// Host        : UL-41 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/uonml/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_user_logic_uart_0_1/design_1_user_logic_uart_0_1_stub.v
// Design      : design_1_user_logic_uart_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "user_logic_uart,Vivado 2019.1" *)
module design_1_user_logic_uart_0_1(clk, utx_data, ureset, utxclk, urx_in, utx_en, 
  utx_out)
/* synthesis syn_black_box black_box_pad_pin="clk,utx_data[7:0],ureset,utxclk,urx_in,utx_en,utx_out" */;
  input clk;
  input [7:0]utx_data;
  input ureset;
  input utxclk;
  input urx_in;
  input utx_en;
  output utx_out;
endmodule
