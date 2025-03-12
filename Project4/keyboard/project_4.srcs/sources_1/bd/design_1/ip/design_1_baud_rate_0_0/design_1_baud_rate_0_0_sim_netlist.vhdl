-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Mar 12 02:42:47 2025
-- Host        : UL-31 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/nathani/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_baud_rate_0_0/design_1_baud_rate_0_0_sim_netlist.vhdl
-- Design      : design_1_baud_rate_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_baud_rate_0_0_baud_rate is
  port (
    baud : out STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_baud_rate_0_0_baud_rate : entity is "baud_rate";
end design_1_baud_rate_0_0_baud_rate;

architecture STRUCTURE of design_1_baud_rate_0_0_baud_rate is
  signal clk_cnt : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal \clk_cnt0_carry__0_n_0\ : STD_LOGIC;
  signal \clk_cnt0_carry__0_n_1\ : STD_LOGIC;
  signal \clk_cnt0_carry__0_n_2\ : STD_LOGIC;
  signal \clk_cnt0_carry__0_n_3\ : STD_LOGIC;
  signal \clk_cnt0_carry__1_n_0\ : STD_LOGIC;
  signal \clk_cnt0_carry__1_n_1\ : STD_LOGIC;
  signal \clk_cnt0_carry__1_n_2\ : STD_LOGIC;
  signal \clk_cnt0_carry__1_n_3\ : STD_LOGIC;
  signal clk_cnt0_carry_n_0 : STD_LOGIC;
  signal clk_cnt0_carry_n_1 : STD_LOGIC;
  signal clk_cnt0_carry_n_2 : STD_LOGIC;
  signal clk_cnt0_carry_n_3 : STD_LOGIC;
  signal clk_cnt_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal clk_en_i_1_n_0 : STD_LOGIC;
  signal clk_en_i_2_n_0 : STD_LOGIC;
  signal clk_en_i_3_n_0 : STD_LOGIC;
  signal data0 : STD_LOGIC_VECTOR ( 13 downto 1 );
  signal \NLW_clk_cnt0_carry__2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_clk_cnt0_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
begin
clk_cnt0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => clk_cnt0_carry_n_0,
      CO(2) => clk_cnt0_carry_n_1,
      CO(1) => clk_cnt0_carry_n_2,
      CO(0) => clk_cnt0_carry_n_3,
      CYINIT => clk_cnt(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(4 downto 1),
      S(3 downto 0) => clk_cnt(4 downto 1)
    );
\clk_cnt0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => clk_cnt0_carry_n_0,
      CO(3) => \clk_cnt0_carry__0_n_0\,
      CO(2) => \clk_cnt0_carry__0_n_1\,
      CO(1) => \clk_cnt0_carry__0_n_2\,
      CO(0) => \clk_cnt0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(8 downto 5),
      S(3 downto 0) => clk_cnt(8 downto 5)
    );
\clk_cnt0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clk_cnt0_carry__0_n_0\,
      CO(3) => \clk_cnt0_carry__1_n_0\,
      CO(2) => \clk_cnt0_carry__1_n_1\,
      CO(1) => \clk_cnt0_carry__1_n_2\,
      CO(0) => \clk_cnt0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(12 downto 9),
      S(3 downto 0) => clk_cnt(12 downto 9)
    );
\clk_cnt0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \clk_cnt0_carry__1_n_0\,
      CO(3 downto 0) => \NLW_clk_cnt0_carry__2_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_clk_cnt0_carry__2_O_UNCONNECTED\(3 downto 1),
      O(0) => data0(13),
      S(3 downto 1) => B"000",
      S(0) => clk_cnt(13)
    );
\clk_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => clk_cnt(0),
      O => clk_cnt_0(0)
    );
\clk_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => clk_cnt_0(0),
      Q => clk_cnt(0),
      R => '0'
    );
\clk_cnt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(10),
      Q => clk_cnt(10),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(11),
      Q => clk_cnt(11),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(12),
      Q => clk_cnt(12),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(13),
      Q => clk_cnt(13),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(1),
      Q => clk_cnt(1),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(2),
      Q => clk_cnt(2),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(3),
      Q => clk_cnt(3),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(4),
      Q => clk_cnt(4),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(5),
      Q => clk_cnt(5),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(6),
      Q => clk_cnt(6),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(7),
      Q => clk_cnt(7),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(8),
      Q => clk_cnt(8),
      R => clk_en_i_1_n_0
    );
\clk_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => data0(9),
      Q => clk_cnt(9),
      R => clk_en_i_1_n_0
    );
clk_en_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000400"
    )
        port map (
      I0 => clk_en_i_2_n_0,
      I1 => clk_cnt(3),
      I2 => clk_cnt(2),
      I3 => clk_cnt(4),
      I4 => clk_cnt(5),
      I5 => clk_en_i_3_n_0,
      O => clk_en_i_1_n_0
    );
clk_en_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => clk_cnt(7),
      I1 => clk_cnt(6),
      I2 => clk_cnt(9),
      I3 => clk_cnt(8),
      O => clk_en_i_2_n_0
    );
clk_en_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF7FFFFFFFFFFFF"
    )
        port map (
      I0 => clk_cnt(12),
      I1 => clk_cnt(13),
      I2 => clk_cnt(10),
      I3 => clk_cnt(11),
      I4 => clk_cnt(1),
      I5 => clk_cnt(0),
      O => clk_en_i_3_n_0
    );
clk_en_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => clk_en_i_1_n_0,
      Q => baud,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_baud_rate_0_0 is
  port (
    clk : in STD_LOGIC;
    baud : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_baud_rate_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_baud_rate_0_0 : entity is "design_1_baud_rate_0_0,baud_rate,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_baud_rate_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_baud_rate_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_baud_rate_0_0 : entity is "baud_rate,Vivado 2019.1";
end design_1_baud_rate_0_0;

architecture STRUCTURE of design_1_baud_rate_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0";
begin
U0: entity work.design_1_baud_rate_0_0_baud_rate
     port map (
      baud => baud,
      clk => clk
    );
end STRUCTURE;
