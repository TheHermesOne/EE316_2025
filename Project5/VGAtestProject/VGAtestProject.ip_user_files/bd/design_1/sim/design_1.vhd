--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Mon Apr  7 20:42:43 2025
--Host        : UL-31 running 64-bit major release  (build 9200)
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    CLK_I : in STD_LOGIC;
    Key0 : in STD_LOGIC;
    Key1 : in STD_LOGIC;
    VGA_B : out STD_LOGIC_VECTOR ( 3 downto 0 );
    VGA_G : out STD_LOGIC_VECTOR ( 3 downto 0 );
    VGA_HS_O : out STD_LOGIC;
    VGA_R : out STD_LOGIC_VECTOR ( 3 downto 0 );
    VGA_VS_O : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_clk_wiz_0_1 is
  port (
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC
  );
  end component design_1_clk_wiz_0_1;
  component design_1_vga_controller_0_0 is
  port (
    pixel_clk : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    h_sync : out STD_LOGIC;
    v_sync : out STD_LOGIC;
    disp_ena : out STD_LOGIC;
    column : out STD_LOGIC_VECTOR ( 31 downto 0 );
    row : out STD_LOGIC_VECTOR ( 31 downto 0 );
    n_blank : out STD_LOGIC;
    n_sync : out STD_LOGIC
  );
  end component design_1_vga_controller_0_0;
  component design_1_util_vector_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_util_vector_logic_0_0;
  component design_1_blk_mem_gen_0_0 is
  port (
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  end component design_1_blk_mem_gen_0_0;
  component design_1_blk_mem_gen_1_0 is
  port (
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component design_1_blk_mem_gen_1_0;
  component design_1_hw_image_generator_0_0 is
  port (
    disp_ena : in STD_LOGIC;
    pixel_clk : in STD_LOGIC;
    row : in STD_LOGIC_VECTOR ( 31 downto 0 );
    column : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RAMData : in STD_LOGIC_VECTOR ( 2 downto 0 );
    RAMADDR : out STD_LOGIC_VECTOR ( 15 downto 0 );
    letterData : in STD_LOGIC_VECTOR ( 7 downto 0 );
    letterAddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    red : out STD_LOGIC_VECTOR ( 3 downto 0 );
    green : out STD_LOGIC_VECTOR ( 3 downto 0 );
    blue : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component design_1_hw_image_generator_0_0;
  component design_1_DrawingController_0_0 is
  port (
    clk : in STD_LOGIC;
    Key : in STD_LOGIC;
    reset : in STD_LOGIC;
    RAMAddress : out STD_LOGIC_VECTOR ( 15 downto 0 );
    RAMDataWrite : out STD_LOGIC_VECTOR ( 2 downto 0 );
    RAMWriteEnable : out STD_LOGIC
  );
  end component design_1_DrawingController_0_0;
  signal DrawingController_0_RAMAddress : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal DrawingController_0_RAMDataWrite : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal DrawingController_0_RAMWriteEnable : STD_LOGIC;
  signal Key0_1 : STD_LOGIC;
  signal Key_0_1 : STD_LOGIC;
  signal blk_mem_gen_0_doutb : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal blk_mem_gen_1_douta : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal clk_in1_0_1 : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal hw_image_generator_0_RAMADDR : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal hw_image_generator_0_blue : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal hw_image_generator_0_green : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal hw_image_generator_0_letterAddr : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal hw_image_generator_0_red : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal util_vector_logic_0_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal vga_controller_0_column : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal vga_controller_0_disp_ena : STD_LOGIC;
  signal vga_controller_0_h_sync : STD_LOGIC;
  signal vga_controller_0_row : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal vga_controller_0_v_sync : STD_LOGIC;
  signal NLW_vga_controller_0_n_blank_UNCONNECTED : STD_LOGIC;
  signal NLW_vga_controller_0_n_sync_UNCONNECTED : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of CLK_I : signal is "xilinx.com:signal:clock:1.0 CLK.CLK_I CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of CLK_I : signal is "XIL_INTERFACENAME CLK.CLK_I, CLK_DOMAIN design_1_CLK_I, FREQ_HZ 125000000, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of Key0 : signal is "xilinx.com:signal:reset:1.0 RST.KEY0 RST";
  attribute X_INTERFACE_PARAMETER of Key0 : signal is "XIL_INTERFACENAME RST.KEY0, INSERT_VIP 0, POLARITY ACTIVE_LOW";
begin
  Key0_1 <= Key0;
  Key_0_1 <= Key1;
  VGA_B(3 downto 0) <= hw_image_generator_0_blue(3 downto 0);
  VGA_G(3 downto 0) <= hw_image_generator_0_green(3 downto 0);
  VGA_HS_O <= vga_controller_0_h_sync;
  VGA_R(3 downto 0) <= hw_image_generator_0_red(3 downto 0);
  VGA_VS_O <= vga_controller_0_v_sync;
  clk_in1_0_1 <= CLK_I;
DrawingController_0: component design_1_DrawingController_0_0
     port map (
      Key => Key_0_1,
      RAMAddress(15 downto 0) => DrawingController_0_RAMAddress(15 downto 0),
      RAMDataWrite(2 downto 0) => DrawingController_0_RAMDataWrite(2 downto 0),
      RAMWriteEnable => DrawingController_0_RAMWriteEnable,
      clk => clk_in1_0_1,
      reset => util_vector_logic_0_Res(0)
    );
blk_mem_gen_0: component design_1_blk_mem_gen_0_0
     port map (
      addra(15 downto 0) => DrawingController_0_RAMAddress(15 downto 0),
      addrb(15 downto 0) => hw_image_generator_0_RAMADDR(15 downto 0),
      clka => clk_wiz_0_clk_out1,
      clkb => clk_wiz_0_clk_out1,
      dina(2 downto 0) => DrawingController_0_RAMDataWrite(2 downto 0),
      doutb(2 downto 0) => blk_mem_gen_0_doutb(2 downto 0),
      ena => DrawingController_0_RAMWriteEnable,
      enb => '0',
      wea(0) => '0'
    );
blk_mem_gen_1: component design_1_blk_mem_gen_1_0
     port map (
      addra(8 downto 0) => hw_image_generator_0_letterAddr(8 downto 0),
      clka => clk_wiz_0_clk_out1,
      douta(7 downto 0) => blk_mem_gen_1_douta(7 downto 0)
    );
clk_wiz_0: component design_1_clk_wiz_0_1
     port map (
      clk_in1 => clk_in1_0_1,
      clk_out1 => clk_wiz_0_clk_out1
    );
hw_image_generator_0: component design_1_hw_image_generator_0_0
     port map (
      RAMADDR(15 downto 0) => hw_image_generator_0_RAMADDR(15 downto 0),
      RAMData(2 downto 0) => blk_mem_gen_0_doutb(2 downto 0),
      blue(3 downto 0) => hw_image_generator_0_blue(3 downto 0),
      column(31 downto 0) => vga_controller_0_column(31 downto 0),
      disp_ena => vga_controller_0_disp_ena,
      green(3 downto 0) => hw_image_generator_0_green(3 downto 0),
      letterAddr(8 downto 0) => hw_image_generator_0_letterAddr(8 downto 0),
      letterData(7 downto 0) => blk_mem_gen_1_douta(7 downto 0),
      pixel_clk => clk_wiz_0_clk_out1,
      red(3 downto 0) => hw_image_generator_0_red(3 downto 0),
      row(31 downto 0) => vga_controller_0_row(31 downto 0)
    );
util_vector_logic_0: component design_1_util_vector_logic_0_0
     port map (
      Op1(0) => Key0_1,
      Res(0) => util_vector_logic_0_Res(0)
    );
vga_controller_0: component design_1_vga_controller_0_0
     port map (
      column(31 downto 0) => vga_controller_0_column(31 downto 0),
      disp_ena => vga_controller_0_disp_ena,
      h_sync => vga_controller_0_h_sync,
      n_blank => NLW_vga_controller_0_n_blank_UNCONNECTED,
      n_sync => NLW_vga_controller_0_n_sync_UNCONNECTED,
      pixel_clk => clk_wiz_0_clk_out1,
      reset_n => util_vector_logic_0_Res(0),
      row(31 downto 0) => vga_controller_0_row(31 downto 0),
      v_sync => vga_controller_0_v_sync
    );
end STRUCTURE;
