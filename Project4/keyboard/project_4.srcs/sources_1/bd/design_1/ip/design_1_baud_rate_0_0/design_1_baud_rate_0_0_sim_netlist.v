// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Mar 12 02:42:47 2025
// Host        : UL-31 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/nathani/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_baud_rate_0_0/design_1_baud_rate_0_0_sim_netlist.v
// Design      : design_1_baud_rate_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_baud_rate_0_0,baud_rate,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "baud_rate,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module design_1_baud_rate_0_0
   (clk,
    baud);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input clk;
  output baud;

  wire baud;
  wire clk;

  design_1_baud_rate_0_0_baud_rate U0
       (.baud(baud),
        .clk(clk));
endmodule

(* ORIG_REF_NAME = "baud_rate" *) 
module design_1_baud_rate_0_0_baud_rate
   (baud,
    clk);
  output baud;
  input clk;

  wire baud;
  wire clk;
  wire [13:0]clk_cnt;
  wire clk_cnt0_carry__0_n_0;
  wire clk_cnt0_carry__0_n_1;
  wire clk_cnt0_carry__0_n_2;
  wire clk_cnt0_carry__0_n_3;
  wire clk_cnt0_carry__1_n_0;
  wire clk_cnt0_carry__1_n_1;
  wire clk_cnt0_carry__1_n_2;
  wire clk_cnt0_carry__1_n_3;
  wire clk_cnt0_carry_n_0;
  wire clk_cnt0_carry_n_1;
  wire clk_cnt0_carry_n_2;
  wire clk_cnt0_carry_n_3;
  wire [0:0]clk_cnt_0;
  wire clk_en_i_1_n_0;
  wire clk_en_i_2_n_0;
  wire clk_en_i_3_n_0;
  wire [13:1]data0;
  wire [3:0]NLW_clk_cnt0_carry__2_CO_UNCONNECTED;
  wire [3:1]NLW_clk_cnt0_carry__2_O_UNCONNECTED;

  CARRY4 clk_cnt0_carry
       (.CI(1'b0),
        .CO({clk_cnt0_carry_n_0,clk_cnt0_carry_n_1,clk_cnt0_carry_n_2,clk_cnt0_carry_n_3}),
        .CYINIT(clk_cnt[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S(clk_cnt[4:1]));
  CARRY4 clk_cnt0_carry__0
       (.CI(clk_cnt0_carry_n_0),
        .CO({clk_cnt0_carry__0_n_0,clk_cnt0_carry__0_n_1,clk_cnt0_carry__0_n_2,clk_cnt0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S(clk_cnt[8:5]));
  CARRY4 clk_cnt0_carry__1
       (.CI(clk_cnt0_carry__0_n_0),
        .CO({clk_cnt0_carry__1_n_0,clk_cnt0_carry__1_n_1,clk_cnt0_carry__1_n_2,clk_cnt0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S(clk_cnt[12:9]));
  CARRY4 clk_cnt0_carry__2
       (.CI(clk_cnt0_carry__1_n_0),
        .CO(NLW_clk_cnt0_carry__2_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_clk_cnt0_carry__2_O_UNCONNECTED[3:1],data0[13]}),
        .S({1'b0,1'b0,1'b0,clk_cnt[13]}));
  LUT1 #(
    .INIT(2'h1)) 
    \clk_cnt[0]_i_1 
       (.I0(clk_cnt[0]),
        .O(clk_cnt_0));
  FDRE \clk_cnt_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(clk_cnt_0),
        .Q(clk_cnt[0]),
        .R(1'b0));
  FDRE \clk_cnt_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[10]),
        .Q(clk_cnt[10]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[11]),
        .Q(clk_cnt[11]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[12]),
        .Q(clk_cnt[12]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[13]),
        .Q(clk_cnt[13]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[1]),
        .Q(clk_cnt[1]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[2]),
        .Q(clk_cnt[2]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[3]),
        .Q(clk_cnt[3]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[4]),
        .Q(clk_cnt[4]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[5]),
        .Q(clk_cnt[5]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[6]),
        .Q(clk_cnt[6]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[7]),
        .Q(clk_cnt[7]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[8]),
        .Q(clk_cnt[8]),
        .R(clk_en_i_1_n_0));
  FDRE \clk_cnt_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(data0[9]),
        .Q(clk_cnt[9]),
        .R(clk_en_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000400)) 
    clk_en_i_1
       (.I0(clk_en_i_2_n_0),
        .I1(clk_cnt[3]),
        .I2(clk_cnt[2]),
        .I3(clk_cnt[4]),
        .I4(clk_cnt[5]),
        .I5(clk_en_i_3_n_0),
        .O(clk_en_i_1_n_0));
  LUT4 #(
    .INIT(16'hFF7F)) 
    clk_en_i_2
       (.I0(clk_cnt[7]),
        .I1(clk_cnt[6]),
        .I2(clk_cnt[9]),
        .I3(clk_cnt[8]),
        .O(clk_en_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFF7FFFFFFFFFFFF)) 
    clk_en_i_3
       (.I0(clk_cnt[12]),
        .I1(clk_cnt[13]),
        .I2(clk_cnt[10]),
        .I3(clk_cnt[11]),
        .I4(clk_cnt[1]),
        .I5(clk_cnt[0]),
        .O(clk_en_i_3_n_0));
  FDRE clk_en_reg
       (.C(clk),
        .CE(1'b1),
        .D(clk_en_i_1_n_0),
        .Q(baud),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
