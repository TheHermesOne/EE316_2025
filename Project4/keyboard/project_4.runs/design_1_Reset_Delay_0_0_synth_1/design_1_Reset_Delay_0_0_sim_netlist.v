// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Mar 10 23:49:10 2025
// Host        : UL-41 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_Reset_Delay_0_0_sim_netlist.v
// Design      : design_1_Reset_Delay_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z007sclg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Reset_Delay
   (oRESET,
    iCLK);
  output oRESET;
  input iCLK;

  wire \Cont[0]_i_2_n_0 ;
  wire [19:0]Cont_reg;
  wire \Cont_reg[0]_i_1_n_0 ;
  wire \Cont_reg[0]_i_1_n_1 ;
  wire \Cont_reg[0]_i_1_n_2 ;
  wire \Cont_reg[0]_i_1_n_3 ;
  wire \Cont_reg[0]_i_1_n_4 ;
  wire \Cont_reg[0]_i_1_n_5 ;
  wire \Cont_reg[0]_i_1_n_6 ;
  wire \Cont_reg[0]_i_1_n_7 ;
  wire \Cont_reg[12]_i_1_n_0 ;
  wire \Cont_reg[12]_i_1_n_1 ;
  wire \Cont_reg[12]_i_1_n_2 ;
  wire \Cont_reg[12]_i_1_n_3 ;
  wire \Cont_reg[12]_i_1_n_4 ;
  wire \Cont_reg[12]_i_1_n_5 ;
  wire \Cont_reg[12]_i_1_n_6 ;
  wire \Cont_reg[12]_i_1_n_7 ;
  wire \Cont_reg[16]_i_1_n_1 ;
  wire \Cont_reg[16]_i_1_n_2 ;
  wire \Cont_reg[16]_i_1_n_3 ;
  wire \Cont_reg[16]_i_1_n_4 ;
  wire \Cont_reg[16]_i_1_n_5 ;
  wire \Cont_reg[16]_i_1_n_6 ;
  wire \Cont_reg[16]_i_1_n_7 ;
  wire \Cont_reg[4]_i_1_n_0 ;
  wire \Cont_reg[4]_i_1_n_1 ;
  wire \Cont_reg[4]_i_1_n_2 ;
  wire \Cont_reg[4]_i_1_n_3 ;
  wire \Cont_reg[4]_i_1_n_4 ;
  wire \Cont_reg[4]_i_1_n_5 ;
  wire \Cont_reg[4]_i_1_n_6 ;
  wire \Cont_reg[4]_i_1_n_7 ;
  wire \Cont_reg[8]_i_1_n_0 ;
  wire \Cont_reg[8]_i_1_n_1 ;
  wire \Cont_reg[8]_i_1_n_2 ;
  wire \Cont_reg[8]_i_1_n_3 ;
  wire \Cont_reg[8]_i_1_n_4 ;
  wire \Cont_reg[8]_i_1_n_5 ;
  wire \Cont_reg[8]_i_1_n_6 ;
  wire \Cont_reg[8]_i_1_n_7 ;
  wire iCLK;
  wire oRESET;
  wire oRESET_i_2_n_0;
  wire oRESET_i_3_n_0;
  wire oRESET_i_4_n_0;
  wire sel;
  wire [3:3]\NLW_Cont_reg[16]_i_1_CO_UNCONNECTED ;

  LUT1 #(
    .INIT(2'h1)) 
    \Cont[0]_i_2 
       (.I0(Cont_reg[0]),
        .O(\Cont[0]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[0] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[0]_i_1_n_7 ),
        .Q(Cont_reg[0]),
        .R(1'b0));
  CARRY4 \Cont_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\Cont_reg[0]_i_1_n_0 ,\Cont_reg[0]_i_1_n_1 ,\Cont_reg[0]_i_1_n_2 ,\Cont_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\Cont_reg[0]_i_1_n_4 ,\Cont_reg[0]_i_1_n_5 ,\Cont_reg[0]_i_1_n_6 ,\Cont_reg[0]_i_1_n_7 }),
        .S({Cont_reg[3:1],\Cont[0]_i_2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[10] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[8]_i_1_n_5 ),
        .Q(Cont_reg[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[11] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[8]_i_1_n_4 ),
        .Q(Cont_reg[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[12] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[12]_i_1_n_7 ),
        .Q(Cont_reg[12]),
        .R(1'b0));
  CARRY4 \Cont_reg[12]_i_1 
       (.CI(\Cont_reg[8]_i_1_n_0 ),
        .CO({\Cont_reg[12]_i_1_n_0 ,\Cont_reg[12]_i_1_n_1 ,\Cont_reg[12]_i_1_n_2 ,\Cont_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\Cont_reg[12]_i_1_n_4 ,\Cont_reg[12]_i_1_n_5 ,\Cont_reg[12]_i_1_n_6 ,\Cont_reg[12]_i_1_n_7 }),
        .S(Cont_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[13] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[12]_i_1_n_6 ),
        .Q(Cont_reg[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[14] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[12]_i_1_n_5 ),
        .Q(Cont_reg[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[15] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[12]_i_1_n_4 ),
        .Q(Cont_reg[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[16] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[16]_i_1_n_7 ),
        .Q(Cont_reg[16]),
        .R(1'b0));
  CARRY4 \Cont_reg[16]_i_1 
       (.CI(\Cont_reg[12]_i_1_n_0 ),
        .CO({\NLW_Cont_reg[16]_i_1_CO_UNCONNECTED [3],\Cont_reg[16]_i_1_n_1 ,\Cont_reg[16]_i_1_n_2 ,\Cont_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\Cont_reg[16]_i_1_n_4 ,\Cont_reg[16]_i_1_n_5 ,\Cont_reg[16]_i_1_n_6 ,\Cont_reg[16]_i_1_n_7 }),
        .S(Cont_reg[19:16]));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[17] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[16]_i_1_n_6 ),
        .Q(Cont_reg[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[18] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[16]_i_1_n_5 ),
        .Q(Cont_reg[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[19] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[16]_i_1_n_4 ),
        .Q(Cont_reg[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[1] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[0]_i_1_n_6 ),
        .Q(Cont_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[2] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[0]_i_1_n_5 ),
        .Q(Cont_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[3] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[0]_i_1_n_4 ),
        .Q(Cont_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[4] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[4]_i_1_n_7 ),
        .Q(Cont_reg[4]),
        .R(1'b0));
  CARRY4 \Cont_reg[4]_i_1 
       (.CI(\Cont_reg[0]_i_1_n_0 ),
        .CO({\Cont_reg[4]_i_1_n_0 ,\Cont_reg[4]_i_1_n_1 ,\Cont_reg[4]_i_1_n_2 ,\Cont_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\Cont_reg[4]_i_1_n_4 ,\Cont_reg[4]_i_1_n_5 ,\Cont_reg[4]_i_1_n_6 ,\Cont_reg[4]_i_1_n_7 }),
        .S(Cont_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[5] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[4]_i_1_n_6 ),
        .Q(Cont_reg[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[6] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[4]_i_1_n_5 ),
        .Q(Cont_reg[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[7] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[4]_i_1_n_4 ),
        .Q(Cont_reg[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[8] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[8]_i_1_n_7 ),
        .Q(Cont_reg[8]),
        .R(1'b0));
  CARRY4 \Cont_reg[8]_i_1 
       (.CI(\Cont_reg[4]_i_1_n_0 ),
        .CO({\Cont_reg[8]_i_1_n_0 ,\Cont_reg[8]_i_1_n_1 ,\Cont_reg[8]_i_1_n_2 ,\Cont_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\Cont_reg[8]_i_1_n_4 ,\Cont_reg[8]_i_1_n_5 ,\Cont_reg[8]_i_1_n_6 ,\Cont_reg[8]_i_1_n_7 }),
        .S(Cont_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \Cont_reg[9] 
       (.C(iCLK),
        .CE(sel),
        .D(\Cont_reg[8]_i_1_n_6 ),
        .Q(Cont_reg[9]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    oRESET_i_1
       (.I0(oRESET_i_2_n_0),
        .I1(Cont_reg[0]),
        .I2(Cont_reg[1]),
        .I3(oRESET_i_3_n_0),
        .I4(oRESET_i_4_n_0),
        .O(sel));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFF)) 
    oRESET_i_2
       (.I0(Cont_reg[6]),
        .I1(Cont_reg[7]),
        .I2(Cont_reg[4]),
        .I3(Cont_reg[5]),
        .I4(Cont_reg[3]),
        .I5(Cont_reg[2]),
        .O(oRESET_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    oRESET_i_3
       (.I0(Cont_reg[18]),
        .I1(Cont_reg[19]),
        .I2(Cont_reg[16]),
        .I3(Cont_reg[17]),
        .I4(Cont_reg[15]),
        .I5(Cont_reg[14]),
        .O(oRESET_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    oRESET_i_4
       (.I0(Cont_reg[12]),
        .I1(Cont_reg[13]),
        .I2(Cont_reg[10]),
        .I3(Cont_reg[11]),
        .I4(Cont_reg[9]),
        .I5(Cont_reg[8]),
        .O(oRESET_i_4_n_0));
  FDRE oRESET_reg
       (.C(iCLK),
        .CE(1'b1),
        .D(sel),
        .Q(oRESET),
        .R(1'b0));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_Reset_Delay_0_0,Reset_Delay,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "Reset_Delay,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (iCLK,
    oRESET);
  input iCLK;
  output oRESET;

  wire iCLK;
  wire oRESET;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Reset_Delay U0
       (.iCLK(iCLK),
        .oRESET(oRESET));
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
