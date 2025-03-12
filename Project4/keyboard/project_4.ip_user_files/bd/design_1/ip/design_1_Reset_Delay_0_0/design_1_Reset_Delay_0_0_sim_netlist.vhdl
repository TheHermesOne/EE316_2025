-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Tue Mar 11 22:20:18 2025
-- Host        : UL-31 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/nathani/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_Reset_Delay_0_0/design_1_Reset_Delay_0_0_sim_netlist.vhdl
-- Design      : design_1_Reset_Delay_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Reset_Delay_0_0_Reset_Delay is
  port (
    oRESET : out STD_LOGIC;
    iCLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_Reset_Delay_0_0_Reset_Delay : entity is "Reset_Delay";
end design_1_Reset_Delay_0_0_Reset_Delay;

architecture STRUCTURE of design_1_Reset_Delay_0_0_Reset_Delay is
  signal \Cont[0]_i_2_n_0\ : STD_LOGIC;
  signal Cont_reg : STD_LOGIC_VECTOR ( 19 downto 0 );
  signal \Cont_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \Cont_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \Cont_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \Cont_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \Cont_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \Cont_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \Cont_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \Cont_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \Cont_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \Cont_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \Cont_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \Cont_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \Cont_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \Cont_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \Cont_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \Cont_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \Cont_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \Cont_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \Cont_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \Cont_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \Cont_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \Cont_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \Cont_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \Cont_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \Cont_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \Cont_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \Cont_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \Cont_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \Cont_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \Cont_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \Cont_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \Cont_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \Cont_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \Cont_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \Cont_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \Cont_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \Cont_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \Cont_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \Cont_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal oRESET_i_2_n_0 : STD_LOGIC;
  signal oRESET_i_3_n_0 : STD_LOGIC;
  signal oRESET_i_4_n_0 : STD_LOGIC;
  signal sel : STD_LOGIC;
  signal \NLW_Cont_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
begin
\Cont[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Cont_reg(0),
      O => \Cont[0]_i_2_n_0\
    );
\Cont_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[0]_i_1_n_7\,
      Q => Cont_reg(0),
      R => '0'
    );
\Cont_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \Cont_reg[0]_i_1_n_0\,
      CO(2) => \Cont_reg[0]_i_1_n_1\,
      CO(1) => \Cont_reg[0]_i_1_n_2\,
      CO(0) => \Cont_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \Cont_reg[0]_i_1_n_4\,
      O(2) => \Cont_reg[0]_i_1_n_5\,
      O(1) => \Cont_reg[0]_i_1_n_6\,
      O(0) => \Cont_reg[0]_i_1_n_7\,
      S(3 downto 1) => Cont_reg(3 downto 1),
      S(0) => \Cont[0]_i_2_n_0\
    );
\Cont_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[8]_i_1_n_5\,
      Q => Cont_reg(10),
      R => '0'
    );
\Cont_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[8]_i_1_n_4\,
      Q => Cont_reg(11),
      R => '0'
    );
\Cont_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[12]_i_1_n_7\,
      Q => Cont_reg(12),
      R => '0'
    );
\Cont_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Cont_reg[8]_i_1_n_0\,
      CO(3) => \Cont_reg[12]_i_1_n_0\,
      CO(2) => \Cont_reg[12]_i_1_n_1\,
      CO(1) => \Cont_reg[12]_i_1_n_2\,
      CO(0) => \Cont_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Cont_reg[12]_i_1_n_4\,
      O(2) => \Cont_reg[12]_i_1_n_5\,
      O(1) => \Cont_reg[12]_i_1_n_6\,
      O(0) => \Cont_reg[12]_i_1_n_7\,
      S(3 downto 0) => Cont_reg(15 downto 12)
    );
\Cont_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[12]_i_1_n_6\,
      Q => Cont_reg(13),
      R => '0'
    );
\Cont_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[12]_i_1_n_5\,
      Q => Cont_reg(14),
      R => '0'
    );
\Cont_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[12]_i_1_n_4\,
      Q => Cont_reg(15),
      R => '0'
    );
\Cont_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[16]_i_1_n_7\,
      Q => Cont_reg(16),
      R => '0'
    );
\Cont_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Cont_reg[12]_i_1_n_0\,
      CO(3) => \NLW_Cont_reg[16]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \Cont_reg[16]_i_1_n_1\,
      CO(1) => \Cont_reg[16]_i_1_n_2\,
      CO(0) => \Cont_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Cont_reg[16]_i_1_n_4\,
      O(2) => \Cont_reg[16]_i_1_n_5\,
      O(1) => \Cont_reg[16]_i_1_n_6\,
      O(0) => \Cont_reg[16]_i_1_n_7\,
      S(3 downto 0) => Cont_reg(19 downto 16)
    );
\Cont_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[16]_i_1_n_6\,
      Q => Cont_reg(17),
      R => '0'
    );
\Cont_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[16]_i_1_n_5\,
      Q => Cont_reg(18),
      R => '0'
    );
\Cont_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[16]_i_1_n_4\,
      Q => Cont_reg(19),
      R => '0'
    );
\Cont_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[0]_i_1_n_6\,
      Q => Cont_reg(1),
      R => '0'
    );
\Cont_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[0]_i_1_n_5\,
      Q => Cont_reg(2),
      R => '0'
    );
\Cont_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[0]_i_1_n_4\,
      Q => Cont_reg(3),
      R => '0'
    );
\Cont_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[4]_i_1_n_7\,
      Q => Cont_reg(4),
      R => '0'
    );
\Cont_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Cont_reg[0]_i_1_n_0\,
      CO(3) => \Cont_reg[4]_i_1_n_0\,
      CO(2) => \Cont_reg[4]_i_1_n_1\,
      CO(1) => \Cont_reg[4]_i_1_n_2\,
      CO(0) => \Cont_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Cont_reg[4]_i_1_n_4\,
      O(2) => \Cont_reg[4]_i_1_n_5\,
      O(1) => \Cont_reg[4]_i_1_n_6\,
      O(0) => \Cont_reg[4]_i_1_n_7\,
      S(3 downto 0) => Cont_reg(7 downto 4)
    );
\Cont_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[4]_i_1_n_6\,
      Q => Cont_reg(5),
      R => '0'
    );
\Cont_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[4]_i_1_n_5\,
      Q => Cont_reg(6),
      R => '0'
    );
\Cont_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[4]_i_1_n_4\,
      Q => Cont_reg(7),
      R => '0'
    );
\Cont_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[8]_i_1_n_7\,
      Q => Cont_reg(8),
      R => '0'
    );
\Cont_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Cont_reg[4]_i_1_n_0\,
      CO(3) => \Cont_reg[8]_i_1_n_0\,
      CO(2) => \Cont_reg[8]_i_1_n_1\,
      CO(1) => \Cont_reg[8]_i_1_n_2\,
      CO(0) => \Cont_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Cont_reg[8]_i_1_n_4\,
      O(2) => \Cont_reg[8]_i_1_n_5\,
      O(1) => \Cont_reg[8]_i_1_n_6\,
      O(0) => \Cont_reg[8]_i_1_n_7\,
      S(3 downto 0) => Cont_reg(11 downto 8)
    );
\Cont_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => iCLK,
      CE => sel,
      D => \Cont_reg[8]_i_1_n_6\,
      Q => Cont_reg(9),
      R => '0'
    );
oRESET_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFBF"
    )
        port map (
      I0 => oRESET_i_2_n_0,
      I1 => Cont_reg(0),
      I2 => Cont_reg(1),
      I3 => oRESET_i_3_n_0,
      I4 => oRESET_i_4_n_0,
      O => sel
    );
oRESET_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFFFFFFFFFFFF"
    )
        port map (
      I0 => Cont_reg(6),
      I1 => Cont_reg(7),
      I2 => Cont_reg(4),
      I3 => Cont_reg(5),
      I4 => Cont_reg(3),
      I5 => Cont_reg(2),
      O => oRESET_i_2_n_0
    );
oRESET_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => Cont_reg(18),
      I1 => Cont_reg(19),
      I2 => Cont_reg(16),
      I3 => Cont_reg(17),
      I4 => Cont_reg(15),
      I5 => Cont_reg(14),
      O => oRESET_i_3_n_0
    );
oRESET_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => Cont_reg(12),
      I1 => Cont_reg(13),
      I2 => Cont_reg(10),
      I3 => Cont_reg(11),
      I4 => Cont_reg(9),
      I5 => Cont_reg(8),
      O => oRESET_i_4_n_0
    );
oRESET_reg: unisim.vcomponents.FDRE
     port map (
      C => iCLK,
      CE => '1',
      D => sel,
      Q => oRESET,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Reset_Delay_0_0 is
  port (
    iCLK : in STD_LOGIC;
    oRESET : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_Reset_Delay_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_Reset_Delay_0_0 : entity is "design_1_Reset_Delay_0_0,Reset_Delay,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_Reset_Delay_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_Reset_Delay_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_Reset_Delay_0_0 : entity is "Reset_Delay,Vivado 2019.1";
end design_1_Reset_Delay_0_0;

architecture STRUCTURE of design_1_Reset_Delay_0_0 is
begin
U0: entity work.design_1_Reset_Delay_0_0_Reset_Delay
     port map (
      iCLK => iCLK,
      oRESET => oRESET
    );
end STRUCTURE;
