// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Mar 10 23:53:22 2025
// Host        : UL-41 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_user_logic_uart_0_1_sim_netlist.v
// Design      : design_1_user_logic_uart_0_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_user_logic_uart_0_1,user_logic_uart,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "user_logic_uart,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk,
    utx_data,
    ureset,
    utxclk,
    urx_in,
    utx_en,
    utx_out);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input clk;
  input [7:0]utx_data;
  input ureset;
  input utxclk;
  input urx_in;
  input utx_en;
  output utx_out;

  wire clk;
  wire ureset;
  wire [7:0]utx_data;
  wire utx_en;
  wire utx_out;
  wire utxclk;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_user_logic_uart U0
       (.clk(clk),
        .ureset(ureset),
        .utx_data(utx_data),
        .utx_en(utx_en),
        .utx_out(utx_out),
        .utxclk(utxclk));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_uart
   (utx_out,
    utxclk,
    ureset,
    utx_en,
    ld_tx_data,
    utx_data);
  output utx_out;
  input utxclk;
  input ureset;
  input utx_en;
  input ld_tx_data;
  input [7:0]utx_data;

  wire ld_tx_data;
  wire \tx_cnt[0]_i_1_n_0 ;
  wire \tx_cnt[1]_i_1_n_0 ;
  wire \tx_cnt[2]_i_1_n_0 ;
  wire \tx_cnt[3]_i_1_n_0 ;
  wire \tx_cnt[3]_i_2_n_0 ;
  wire \tx_cnt_reg_n_0_[0] ;
  wire \tx_cnt_reg_n_0_[1] ;
  wire \tx_cnt_reg_n_0_[2] ;
  wire \tx_cnt_reg_n_0_[3] ;
  wire tx_is_empty_i_1_n_0;
  wire tx_is_empty_i_2_n_0;
  wire tx_is_empty_reg_n_0;
  wire tx_out9_out;
  wire tx_out_i_1_n_0;
  wire tx_out_i_2_n_0;
  wire tx_out_i_4_n_0;
  wire tx_out_i_5_n_0;
  wire tx_reg;
  wire \tx_reg_reg_n_0_[0] ;
  wire \tx_reg_reg_n_0_[1] ;
  wire \tx_reg_reg_n_0_[2] ;
  wire \tx_reg_reg_n_0_[3] ;
  wire \tx_reg_reg_n_0_[4] ;
  wire \tx_reg_reg_n_0_[5] ;
  wire \tx_reg_reg_n_0_[6] ;
  wire \tx_reg_reg_n_0_[7] ;
  wire ureset;
  wire [7:0]utx_data;
  wire utx_en;
  wire utx_out;
  wire utxclk;

  LUT2 #(
    .INIT(4'h2)) 
    \tx_cnt[0]_i_1 
       (.I0(utx_en),
        .I1(\tx_cnt_reg_n_0_[0] ),
        .O(\tx_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h080AA0A0)) 
    \tx_cnt[1]_i_1 
       (.I0(utx_en),
        .I1(\tx_cnt_reg_n_0_[2] ),
        .I2(\tx_cnt_reg_n_0_[1] ),
        .I3(\tx_cnt_reg_n_0_[3] ),
        .I4(\tx_cnt_reg_n_0_[0] ),
        .O(\tx_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h2888)) 
    \tx_cnt[2]_i_1 
       (.I0(utx_en),
        .I1(\tx_cnt_reg_n_0_[2] ),
        .I2(\tx_cnt_reg_n_0_[1] ),
        .I3(\tx_cnt_reg_n_0_[0] ),
        .O(\tx_cnt[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h7)) 
    \tx_cnt[3]_i_1 
       (.I0(tx_is_empty_reg_n_0),
        .I1(utx_en),
        .O(\tx_cnt[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h2880AA00)) 
    \tx_cnt[3]_i_2 
       (.I0(utx_en),
        .I1(\tx_cnt_reg_n_0_[2] ),
        .I2(\tx_cnt_reg_n_0_[1] ),
        .I3(\tx_cnt_reg_n_0_[3] ),
        .I4(\tx_cnt_reg_n_0_[0] ),
        .O(\tx_cnt[3]_i_2_n_0 ));
  FDCE \tx_cnt_reg[0] 
       (.C(utxclk),
        .CE(\tx_cnt[3]_i_1_n_0 ),
        .CLR(ureset),
        .D(\tx_cnt[0]_i_1_n_0 ),
        .Q(\tx_cnt_reg_n_0_[0] ));
  FDCE \tx_cnt_reg[1] 
       (.C(utxclk),
        .CE(\tx_cnt[3]_i_1_n_0 ),
        .CLR(ureset),
        .D(\tx_cnt[1]_i_1_n_0 ),
        .Q(\tx_cnt_reg_n_0_[1] ));
  FDCE \tx_cnt_reg[2] 
       (.C(utxclk),
        .CE(\tx_cnt[3]_i_1_n_0 ),
        .CLR(ureset),
        .D(\tx_cnt[2]_i_1_n_0 ),
        .Q(\tx_cnt_reg_n_0_[2] ));
  FDCE \tx_cnt_reg[3] 
       (.C(utxclk),
        .CE(\tx_cnt[3]_i_1_n_0 ),
        .CLR(ureset),
        .D(\tx_cnt[3]_i_2_n_0 ),
        .Q(\tx_cnt_reg_n_0_[3] ));
  LUT4 #(
    .INIT(16'h08F8)) 
    tx_is_empty_i_1
       (.I0(tx_is_empty_i_2_n_0),
        .I1(utx_en),
        .I2(tx_is_empty_reg_n_0),
        .I3(ld_tx_data),
        .O(tx_is_empty_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    tx_is_empty_i_2
       (.I0(\tx_cnt_reg_n_0_[2] ),
        .I1(\tx_cnt_reg_n_0_[1] ),
        .I2(\tx_cnt_reg_n_0_[3] ),
        .I3(\tx_cnt_reg_n_0_[0] ),
        .O(tx_is_empty_i_2_n_0));
  FDPE tx_is_empty_reg
       (.C(utxclk),
        .CE(1'b1),
        .D(tx_is_empty_i_1_n_0),
        .PRE(ureset),
        .Q(tx_is_empty_reg_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    tx_out_i_1
       (.I0(tx_out_i_2_n_0),
        .I1(tx_out9_out),
        .I2(utx_out),
        .O(tx_out_i_1_n_0));
  LUT6 #(
    .INIT(64'h00330030FEA802A8)) 
    tx_out_i_2
       (.I0(tx_out_i_4_n_0),
        .I1(\tx_cnt_reg_n_0_[1] ),
        .I2(\tx_cnt_reg_n_0_[0] ),
        .I3(\tx_cnt_reg_n_0_[2] ),
        .I4(tx_out_i_5_n_0),
        .I5(\tx_cnt_reg_n_0_[3] ),
        .O(tx_out_i_2_n_0));
  LUT5 #(
    .INIT(32'h00440444)) 
    tx_out_i_3
       (.I0(tx_is_empty_reg_n_0),
        .I1(utx_en),
        .I2(\tx_cnt_reg_n_0_[1] ),
        .I3(\tx_cnt_reg_n_0_[3] ),
        .I4(\tx_cnt_reg_n_0_[2] ),
        .O(tx_out9_out));
  LUT6 #(
    .INIT(64'hFCAF0CAFFCA00CA0)) 
    tx_out_i_4
       (.I0(\tx_reg_reg_n_0_[0] ),
        .I1(\tx_reg_reg_n_0_[1] ),
        .I2(\tx_cnt_reg_n_0_[0] ),
        .I3(\tx_cnt_reg_n_0_[1] ),
        .I4(\tx_reg_reg_n_0_[2] ),
        .I5(\tx_reg_reg_n_0_[3] ),
        .O(tx_out_i_4_n_0));
  LUT6 #(
    .INIT(64'hFCAF0CAFFCA00CA0)) 
    tx_out_i_5
       (.I0(\tx_reg_reg_n_0_[4] ),
        .I1(\tx_reg_reg_n_0_[5] ),
        .I2(\tx_cnt_reg_n_0_[0] ),
        .I3(\tx_cnt_reg_n_0_[1] ),
        .I4(\tx_reg_reg_n_0_[6] ),
        .I5(\tx_reg_reg_n_0_[7] ),
        .O(tx_out_i_5_n_0));
  FDPE tx_out_reg
       (.C(utxclk),
        .CE(1'b1),
        .D(tx_out_i_1_n_0),
        .PRE(ureset),
        .Q(utx_out));
  LUT2 #(
    .INIT(4'h8)) 
    \tx_reg[7]_i_1 
       (.I0(ld_tx_data),
        .I1(tx_is_empty_reg_n_0),
        .O(tx_reg));
  FDCE \tx_reg_reg[0] 
       (.C(utxclk),
        .CE(tx_reg),
        .CLR(ureset),
        .D(utx_data[0]),
        .Q(\tx_reg_reg_n_0_[0] ));
  FDCE \tx_reg_reg[1] 
       (.C(utxclk),
        .CE(tx_reg),
        .CLR(ureset),
        .D(utx_data[1]),
        .Q(\tx_reg_reg_n_0_[1] ));
  FDCE \tx_reg_reg[2] 
       (.C(utxclk),
        .CE(tx_reg),
        .CLR(ureset),
        .D(utx_data[2]),
        .Q(\tx_reg_reg_n_0_[2] ));
  FDCE \tx_reg_reg[3] 
       (.C(utxclk),
        .CE(tx_reg),
        .CLR(ureset),
        .D(utx_data[3]),
        .Q(\tx_reg_reg_n_0_[3] ));
  FDCE \tx_reg_reg[4] 
       (.C(utxclk),
        .CE(tx_reg),
        .CLR(ureset),
        .D(utx_data[4]),
        .Q(\tx_reg_reg_n_0_[4] ));
  FDCE \tx_reg_reg[5] 
       (.C(utxclk),
        .CE(tx_reg),
        .CLR(ureset),
        .D(utx_data[5]),
        .Q(\tx_reg_reg_n_0_[5] ));
  FDCE \tx_reg_reg[6] 
       (.C(utxclk),
        .CE(tx_reg),
        .CLR(ureset),
        .D(utx_data[6]),
        .Q(\tx_reg_reg_n_0_[6] ));
  FDCE \tx_reg_reg[7] 
       (.C(utxclk),
        .CE(tx_reg),
        .CLR(ureset),
        .D(utx_data[7]),
        .Q(\tx_reg_reg_n_0_[7] ));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_user_logic_uart
   (utx_out,
    utx_en,
    utxclk,
    ureset,
    utx_data,
    clk);
  output utx_out;
  input utx_en;
  input utxclk;
  input ureset;
  input [7:0]utx_data;
  input clk;

  wire clk;
  wire ld_tx_data;
  wire ureset;
  wire [7:0]utx_data;
  wire utx_en;
  wire utx_out;
  wire utxclk;

  FDRE #(
    .INIT(1'b0)) 
    ld_tx_data_reg
       (.C(clk),
        .CE(1'b1),
        .D(1'b1),
        .Q(ld_tx_data),
        .R(1'b0));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_uart uut
       (.ld_tx_data(ld_tx_data),
        .ureset(ureset),
        .utx_data(utx_data),
        .utx_en(utx_en),
        .utx_out(utx_out),
        .utxclk(utxclk));
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
