--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Wed Mar 12 01:06:15 2025
--Host        : UL-31 running 64-bit major release  (build 9200)
--Command     : generate_target design_2.bd
--Design      : design_2
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2 is
  port (
    ascii_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ascii_pulse : out STD_LOGIC;
    clk : in STD_LOGIC;
    kb_clk : in STD_LOGIC;
    kb_data : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_2 : entity is "design_2,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_2,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_2 : entity is "design_2.hwdef";
end design_2;

architecture STRUCTURE of design_2 is
  component design_2_ps2_keyboard_to_ascii_0_0 is
  port (
    clk : in STD_LOGIC;
    ps2_clk : in STD_LOGIC;
    ps2_data : in STD_LOGIC;
    ascii_new : out STD_LOGIC;
    ascii_code : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component design_2_ps2_keyboard_to_ascii_0_0;
  signal clk_1 : STD_LOGIC;
  signal kb_clk_1 : STD_LOGIC;
  signal kb_data_1 : STD_LOGIC;
  signal ps2_keyboard_to_ascii_0_ascii_code : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal ps2_keyboard_to_ascii_0_ascii_new : STD_LOGIC;
begin
  ascii_out(7 downto 0) <= ps2_keyboard_to_ascii_0_ascii_code(7 downto 0);
  ascii_pulse <= ps2_keyboard_to_ascii_0_ascii_new;
  clk_1 <= clk;
  kb_clk_1 <= kb_clk;
  kb_data_1 <= kb_data;
ps2_keyboard_to_ascii_0: component design_2_ps2_keyboard_to_ascii_0_0
     port map (
      ascii_code(7 downto 0) => ps2_keyboard_to_ascii_0_ascii_code(7 downto 0),
      ascii_new => ps2_keyboard_to_ascii_0_ascii_new,
      clk => clk_1,
      ps2_clk => kb_clk_1,
      ps2_data => kb_data_1
    );
end STRUCTURE;
