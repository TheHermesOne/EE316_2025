// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue Mar 11 00:17:54 2025
// Host        : UL-41 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/uonml/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_btn_debounce_toggle_0_0/design_1_btn_debounce_toggle_0_0_sim_netlist.v
// Design      : design_1_btn_debounce_toggle_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_btn_debounce_toggle_0_0,btn_debounce_toggle,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "btn_debounce_toggle,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module design_1_btn_debounce_toggle_0_0
   (BTN_I,
    CLK,
    BTN_O,
    TOGGLE_O,
    PULSE_O);
  input BTN_I;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  output BTN_O;
  output TOGGLE_O;
  output PULSE_O;

  wire BTN_I;
  wire BTN_O;
  wire CLK;
  wire PULSE_O;
  wire TOGGLE_O;

  design_1_btn_debounce_toggle_0_0_btn_debounce_toggle U0
       (.BTN_I(BTN_I),
        .CLK(CLK),
        .D(BTN_O),
        .PULSE_O(PULSE_O),
        .TOGGLE_O(TOGGLE_O));
endmodule

(* ORIG_REF_NAME = "btn_debounce_toggle" *) 
module design_1_btn_debounce_toggle_0_0_btn_debounce_toggle
   (D,
    PULSE_O,
    TOGGLE_O,
    BTN_I,
    CLK);
  output [0:0]D;
  output PULSE_O;
  output TOGGLE_O;
  input BTN_I;
  input CLK;

  wire BTN_I;
  wire CLK;
  wire [0:0]D;
  wire PULSE_O;
  wire TOGGLE_O;
  wire \btn_cntr[0]_i_1_n_0 ;
  wire \btn_cntr[0]_i_3_n_0 ;
  wire [15:0]btn_cntr_reg;
  wire \btn_cntr_reg[0]_i_2_n_0 ;
  wire \btn_cntr_reg[0]_i_2_n_1 ;
  wire \btn_cntr_reg[0]_i_2_n_2 ;
  wire \btn_cntr_reg[0]_i_2_n_3 ;
  wire \btn_cntr_reg[0]_i_2_n_4 ;
  wire \btn_cntr_reg[0]_i_2_n_5 ;
  wire \btn_cntr_reg[0]_i_2_n_6 ;
  wire \btn_cntr_reg[0]_i_2_n_7 ;
  wire \btn_cntr_reg[12]_i_1_n_1 ;
  wire \btn_cntr_reg[12]_i_1_n_2 ;
  wire \btn_cntr_reg[12]_i_1_n_3 ;
  wire \btn_cntr_reg[12]_i_1_n_4 ;
  wire \btn_cntr_reg[12]_i_1_n_5 ;
  wire \btn_cntr_reg[12]_i_1_n_6 ;
  wire \btn_cntr_reg[12]_i_1_n_7 ;
  wire \btn_cntr_reg[4]_i_1_n_0 ;
  wire \btn_cntr_reg[4]_i_1_n_1 ;
  wire \btn_cntr_reg[4]_i_1_n_2 ;
  wire \btn_cntr_reg[4]_i_1_n_3 ;
  wire \btn_cntr_reg[4]_i_1_n_4 ;
  wire \btn_cntr_reg[4]_i_1_n_5 ;
  wire \btn_cntr_reg[4]_i_1_n_6 ;
  wire \btn_cntr_reg[4]_i_1_n_7 ;
  wire \btn_cntr_reg[8]_i_1_n_0 ;
  wire \btn_cntr_reg[8]_i_1_n_1 ;
  wire \btn_cntr_reg[8]_i_1_n_2 ;
  wire \btn_cntr_reg[8]_i_1_n_3 ;
  wire \btn_cntr_reg[8]_i_1_n_4 ;
  wire \btn_cntr_reg[8]_i_1_n_5 ;
  wire \btn_cntr_reg[8]_i_1_n_6 ;
  wire \btn_cntr_reg[8]_i_1_n_7 ;
  wire btn_pulse_i_1_n_0;
  wire btn_reg_i_1_n_0;
  wire btn_reg_i_2_n_0;
  wire btn_reg_i_3_n_0;
  wire btn_reg_i_4_n_0;
  wire btn_reg_i_5_n_0;
  wire [1:0]btn_sync;
  wire btn_toggle_i_1_n_0;
  wire [3:3]\NLW_btn_cntr_reg[12]_i_1_CO_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hFFFF00800080FFFF)) 
    \btn_cntr[0]_i_1 
       (.I0(btn_reg_i_2_n_0),
        .I1(btn_reg_i_3_n_0),
        .I2(btn_reg_i_4_n_0),
        .I3(btn_reg_i_5_n_0),
        .I4(D),
        .I5(BTN_I),
        .O(\btn_cntr[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \btn_cntr[0]_i_3 
       (.I0(btn_cntr_reg[0]),
        .O(\btn_cntr[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[0]_i_2_n_7 ),
        .Q(btn_cntr_reg[0]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  CARRY4 \btn_cntr_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\btn_cntr_reg[0]_i_2_n_0 ,\btn_cntr_reg[0]_i_2_n_1 ,\btn_cntr_reg[0]_i_2_n_2 ,\btn_cntr_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\btn_cntr_reg[0]_i_2_n_4 ,\btn_cntr_reg[0]_i_2_n_5 ,\btn_cntr_reg[0]_i_2_n_6 ,\btn_cntr_reg[0]_i_2_n_7 }),
        .S({btn_cntr_reg[3:1],\btn_cntr[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[10] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[8]_i_1_n_5 ),
        .Q(btn_cntr_reg[10]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[11] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[8]_i_1_n_4 ),
        .Q(btn_cntr_reg[11]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[12] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[12]_i_1_n_7 ),
        .Q(btn_cntr_reg[12]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  CARRY4 \btn_cntr_reg[12]_i_1 
       (.CI(\btn_cntr_reg[8]_i_1_n_0 ),
        .CO({\NLW_btn_cntr_reg[12]_i_1_CO_UNCONNECTED [3],\btn_cntr_reg[12]_i_1_n_1 ,\btn_cntr_reg[12]_i_1_n_2 ,\btn_cntr_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\btn_cntr_reg[12]_i_1_n_4 ,\btn_cntr_reg[12]_i_1_n_5 ,\btn_cntr_reg[12]_i_1_n_6 ,\btn_cntr_reg[12]_i_1_n_7 }),
        .S(btn_cntr_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[13] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[12]_i_1_n_6 ),
        .Q(btn_cntr_reg[13]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[14] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[12]_i_1_n_5 ),
        .Q(btn_cntr_reg[14]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[15] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[12]_i_1_n_4 ),
        .Q(btn_cntr_reg[15]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[0]_i_2_n_6 ),
        .Q(btn_cntr_reg[1]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[0]_i_2_n_5 ),
        .Q(btn_cntr_reg[2]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[0]_i_2_n_4 ),
        .Q(btn_cntr_reg[3]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[4]_i_1_n_7 ),
        .Q(btn_cntr_reg[4]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  CARRY4 \btn_cntr_reg[4]_i_1 
       (.CI(\btn_cntr_reg[0]_i_2_n_0 ),
        .CO({\btn_cntr_reg[4]_i_1_n_0 ,\btn_cntr_reg[4]_i_1_n_1 ,\btn_cntr_reg[4]_i_1_n_2 ,\btn_cntr_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\btn_cntr_reg[4]_i_1_n_4 ,\btn_cntr_reg[4]_i_1_n_5 ,\btn_cntr_reg[4]_i_1_n_6 ,\btn_cntr_reg[4]_i_1_n_7 }),
        .S(btn_cntr_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[4]_i_1_n_6 ),
        .Q(btn_cntr_reg[5]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[4]_i_1_n_5 ),
        .Q(btn_cntr_reg[6]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[4]_i_1_n_4 ),
        .Q(btn_cntr_reg[7]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[8] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[8]_i_1_n_7 ),
        .Q(btn_cntr_reg[8]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  CARRY4 \btn_cntr_reg[8]_i_1 
       (.CI(\btn_cntr_reg[4]_i_1_n_0 ),
        .CO({\btn_cntr_reg[8]_i_1_n_0 ,\btn_cntr_reg[8]_i_1_n_1 ,\btn_cntr_reg[8]_i_1_n_2 ,\btn_cntr_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\btn_cntr_reg[8]_i_1_n_4 ,\btn_cntr_reg[8]_i_1_n_5 ,\btn_cntr_reg[8]_i_1_n_6 ,\btn_cntr_reg[8]_i_1_n_7 }),
        .S(btn_cntr_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \btn_cntr_reg[9] 
       (.C(CLK),
        .CE(1'b1),
        .D(\btn_cntr_reg[8]_i_1_n_6 ),
        .Q(btn_cntr_reg[9]),
        .R(\btn_cntr[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    btn_pulse_i_1
       (.I0(btn_sync[0]),
        .I1(btn_sync[1]),
        .O(btn_pulse_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    btn_pulse_reg
       (.C(CLK),
        .CE(1'b1),
        .D(btn_pulse_i_1_n_0),
        .Q(PULSE_O),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFF7F0080)) 
    btn_reg_i_1
       (.I0(btn_reg_i_2_n_0),
        .I1(btn_reg_i_3_n_0),
        .I2(btn_reg_i_4_n_0),
        .I3(btn_reg_i_5_n_0),
        .I4(D),
        .O(btn_reg_i_1_n_0));
  LUT4 #(
    .INIT(16'h8000)) 
    btn_reg_i_2
       (.I0(btn_cntr_reg[1]),
        .I1(btn_cntr_reg[0]),
        .I2(btn_cntr_reg[3]),
        .I3(btn_cntr_reg[2]),
        .O(btn_reg_i_2_n_0));
  LUT4 #(
    .INIT(16'h8000)) 
    btn_reg_i_3
       (.I0(btn_cntr_reg[5]),
        .I1(btn_cntr_reg[4]),
        .I2(btn_cntr_reg[7]),
        .I3(btn_cntr_reg[6]),
        .O(btn_reg_i_3_n_0));
  LUT4 #(
    .INIT(16'h8000)) 
    btn_reg_i_4
       (.I0(btn_cntr_reg[13]),
        .I1(btn_cntr_reg[12]),
        .I2(btn_cntr_reg[14]),
        .I3(btn_cntr_reg[15]),
        .O(btn_reg_i_4_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    btn_reg_i_5
       (.I0(btn_cntr_reg[9]),
        .I1(btn_cntr_reg[8]),
        .I2(btn_cntr_reg[11]),
        .I3(btn_cntr_reg[10]),
        .O(btn_reg_i_5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    btn_reg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(btn_reg_i_1_n_0),
        .Q(D),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \btn_sync_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(D),
        .Q(btn_sync[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \btn_sync_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(btn_sync[0]),
        .Q(btn_sync[1]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h6)) 
    btn_toggle_i_1
       (.I0(PULSE_O),
        .I1(TOGGLE_O),
        .O(btn_toggle_i_1_n_0));
  FDRE #(
    .INIT(1'b1)) 
    btn_toggle_reg
       (.C(CLK),
        .CE(1'b1),
        .D(btn_toggle_i_1_n_0),
        .Q(TOGGLE_O),
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
