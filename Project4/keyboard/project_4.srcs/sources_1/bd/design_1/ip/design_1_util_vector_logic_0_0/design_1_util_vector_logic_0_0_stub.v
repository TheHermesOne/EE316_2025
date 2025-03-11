// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Mar 10 23:49:11 2025
// Host        : UL-41 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/uonml/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_util_vector_logic_0_0/design_1_util_vector_logic_0_0_stub.v
// Design      : design_1_util_vector_logic_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "util_vector_logic_v2_0_1_util_vector_logic,Vivado 2019.1" *)
module design_1_util_vector_logic_0_0(Op1, Op2, Res)
/* synthesis syn_black_box black_box_pad_pin="Op1[0:0],Op2[0:0],Res[0:0]" */;
  input [0:0]Op1;
  input [0:0]Op2;
  output [0:0]Res;
endmodule
