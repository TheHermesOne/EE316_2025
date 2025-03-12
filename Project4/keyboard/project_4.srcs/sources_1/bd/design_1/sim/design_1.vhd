--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Wed Mar 12 03:30:43 2025
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
    clk : in STD_LOGIC;
    kb_clk : in STD_LOGIC;
    kb_data : in STD_LOGIC;
    reset : in STD_LOGIC;
    tx_out : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=5,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_util_vector_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Op2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_util_vector_logic_0_0;
  component design_1_ps2_keyboard_to_ascii_0_1 is
  port (
    clk : in STD_LOGIC;
    ps2_clk : in STD_LOGIC;
    ps2_data : in STD_LOGIC;
    ascii_new : out STD_LOGIC;
    ascii_code : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component design_1_ps2_keyboard_to_ascii_0_1;
  component design_1_Reset_Delay_0_0 is
  port (
    iCLK : in STD_LOGIC;
    oRESET : out STD_LOGIC
  );
  end component design_1_Reset_Delay_0_0;
  component design_1_btn_debounce_toggle_0_0 is
  port (
    BTN_I : in STD_LOGIC;
    CLK : in STD_LOGIC;
    BTN_O : out STD_LOGIC;
    TOGGLE_O : out STD_LOGIC;
    PULSE_O : out STD_LOGIC
  );
  end component design_1_btn_debounce_toggle_0_0;
  component design_1_baud_rate_0_0 is
  port (
    clk : in STD_LOGIC;
    baud : out STD_LOGIC
  );
  end component design_1_baud_rate_0_0;
  component design_1_user_logic_uart_0_1 is
  port (
    clk : in STD_LOGIC;
    utx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    ureset : in STD_LOGIC;
    utxclk : in STD_LOGIC;
    utx_en : in STD_LOGIC;
    utx_out : out STD_LOGIC
  );
  end component design_1_user_logic_uart_0_1;
  signal Reset_Delay_0_oRESET : STD_LOGIC;
  signal baud_rate_0_baud : STD_LOGIC;
  signal btn_debounce_toggle_0_BTN_O : STD_LOGIC;
  signal clk_1 : STD_LOGIC;
  signal kb_clk_1 : STD_LOGIC;
  signal kb_data_1 : STD_LOGIC;
  signal ps2_keyboard_to_ascii_0_ascii_code : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal ps2_keyboard_to_ascii_0_ascii_new : STD_LOGIC;
  signal reset_1 : STD_LOGIC;
  signal user_logic_uart_0_utx_out : STD_LOGIC;
  signal util_vector_logic_0_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_btn_debounce_toggle_0_PULSE_O_UNCONNECTED : STD_LOGIC;
  signal NLW_btn_debounce_toggle_0_TOGGLE_O_UNCONNECTED : STD_LOGIC;
begin
  clk_1 <= clk;
  kb_clk_1 <= kb_clk;
  kb_data_1 <= kb_data;
  reset_1 <= reset;
  tx_out <= user_logic_uart_0_utx_out;
Reset_Delay_0: component design_1_Reset_Delay_0_0
     port map (
      iCLK => clk_1,
      oRESET => Reset_Delay_0_oRESET
    );
baud_rate_0: component design_1_baud_rate_0_0
     port map (
      baud => baud_rate_0_baud,
      clk => clk_1
    );
btn_debounce_toggle_0: component design_1_btn_debounce_toggle_0_0
     port map (
      BTN_I => reset_1,
      BTN_O => btn_debounce_toggle_0_BTN_O,
      CLK => clk_1,
      PULSE_O => NLW_btn_debounce_toggle_0_PULSE_O_UNCONNECTED,
      TOGGLE_O => NLW_btn_debounce_toggle_0_TOGGLE_O_UNCONNECTED
    );
ps2_keyboard_to_ascii_0: component design_1_ps2_keyboard_to_ascii_0_1
     port map (
      ascii_code(7 downto 0) => ps2_keyboard_to_ascii_0_ascii_code(7 downto 0),
      ascii_new => ps2_keyboard_to_ascii_0_ascii_new,
      clk => clk_1,
      ps2_clk => kb_clk_1,
      ps2_data => kb_data_1
    );
user_logic_uart_0: component design_1_user_logic_uart_0_1
     port map (
      clk => clk_1,
      ureset => util_vector_logic_0_Res(0),
      utx_data(7 downto 0) => ps2_keyboard_to_ascii_0_ascii_code(7 downto 0),
      utx_en => ps2_keyboard_to_ascii_0_ascii_new,
      utx_out => user_logic_uart_0_utx_out,
      utxclk => baud_rate_0_baud
    );
util_vector_logic_0: component design_1_util_vector_logic_0_0
     port map (
      Op1(0) => btn_debounce_toggle_0_BTN_O,
      Op2(0) => Reset_Delay_0_oRESET,
      Res(0) => util_vector_logic_0_Res(0)
    );
end STRUCTURE;
