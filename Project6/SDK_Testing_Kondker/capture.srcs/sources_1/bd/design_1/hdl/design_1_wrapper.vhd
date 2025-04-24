--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Thu Apr 24 11:46:58 2025
--Host        : UL-41 running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    BTN_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    DCmotor : out STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    LED_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    RGB_tri_io : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    Servo : out STD_LOGIC;
    Vaux6_v_n : in STD_LOGIC;
    Vaux6_v_p : in STD_LOGIC;
    Vaux9_v_n : in STD_LOGIC;
    Vaux9_v_p : in STD_LOGIC;
    buzzer_O : out STD_LOGIC;
    capturetrig0_0 : in STD_LOGIC;
    capturetrig1_0 : in STD_LOGIC;
    oSCL_0 : inout STD_LOGIC;
    oSDA_0 : inout STD_LOGIC;
    pwm0_0 : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    capturetrig0_0 : in STD_LOGIC;
    capturetrig1_0 : in STD_LOGIC;
    pwm0_0 : out STD_LOGIC;
    buzzer_O : out STD_LOGIC;
    oSDA_0 : inout STD_LOGIC;
    oSCL_0 : inout STD_LOGIC;
    Servo : out STD_LOGIC;
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    LED_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BTN_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    RGB_tri_i : in STD_LOGIC_VECTOR ( 2 downto 0 );
    RGB_tri_o : out STD_LOGIC_VECTOR ( 2 downto 0 );
    RGB_tri_t : out STD_LOGIC_VECTOR ( 2 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    DCmotor : out STD_LOGIC;
    Vaux6_v_n : in STD_LOGIC;
    Vaux6_v_p : in STD_LOGIC;
    Vaux9_v_n : in STD_LOGIC;
    Vaux9_v_p : in STD_LOGIC
  );
  end component design_1;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal RGB_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal RGB_tri_i_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal RGB_tri_i_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal RGB_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal RGB_tri_io_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal RGB_tri_io_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal RGB_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal RGB_tri_o_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal RGB_tri_o_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal RGB_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal RGB_tri_t_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal RGB_tri_t_2 : STD_LOGIC_VECTOR ( 2 to 2 );
begin
RGB_tri_iobuf_0: component IOBUF
     port map (
      I => RGB_tri_o_0(0),
      IO => RGB_tri_io(0),
      O => RGB_tri_i_0(0),
      T => RGB_tri_t_0(0)
    );
RGB_tri_iobuf_1: component IOBUF
     port map (
      I => RGB_tri_o_1(1),
      IO => RGB_tri_io(1),
      O => RGB_tri_i_1(1),
      T => RGB_tri_t_1(1)
    );
RGB_tri_iobuf_2: component IOBUF
     port map (
      I => RGB_tri_o_2(2),
      IO => RGB_tri_io(2),
      O => RGB_tri_i_2(2),
      T => RGB_tri_t_2(2)
    );
design_1_i: component design_1
     port map (
      BTN_tri_i(3 downto 0) => BTN_tri_i(3 downto 0),
      DCmotor => DCmotor,
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      LED_tri_o(3 downto 0) => LED_tri_o(3 downto 0),
      RGB_tri_i(2) => RGB_tri_i_2(2),
      RGB_tri_i(1) => RGB_tri_i_1(1),
      RGB_tri_i(0) => RGB_tri_i_0(0),
      RGB_tri_o(2) => RGB_tri_o_2(2),
      RGB_tri_o(1) => RGB_tri_o_1(1),
      RGB_tri_o(0) => RGB_tri_o_0(0),
      RGB_tri_t(2) => RGB_tri_t_2(2),
      RGB_tri_t(1) => RGB_tri_t_1(1),
      RGB_tri_t(0) => RGB_tri_t_0(0),
      Servo => Servo,
      Vaux6_v_n => Vaux6_v_n,
      Vaux6_v_p => Vaux6_v_p,
      Vaux9_v_n => Vaux9_v_n,
      Vaux9_v_p => Vaux9_v_p,
      buzzer_O => buzzer_O,
      capturetrig0_0 => capturetrig0_0,
      capturetrig1_0 => capturetrig1_0,
      oSCL_0 => oSCL_0,
      oSDA_0 => oSDA_0,
      pwm0_0 => pwm0_0
    );
end STRUCTURE;
