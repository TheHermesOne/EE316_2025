-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Mar 12 03:31:21 2025
-- Host        : UL-31 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/nathani/Documents/GitHub/EE316_2025/Project4/keyboard/project_4.srcs/sources_1/bd/design_1/ip/design_1_user_logic_uart_0_1/design_1_user_logic_uart_0_1_sim_netlist.vhdl
-- Design      : design_1_user_logic_uart_0_1
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_user_logic_uart_0_1_uart is
  port (
    utx_out : out STD_LOGIC;
    tx_enable_reg : out STD_LOGIC;
    utxclk : in STD_LOGIC;
    ureset : in STD_LOGIC;
    tx_enable : in STD_LOGIC;
    utx_en : in STD_LOGIC;
    utx_data : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_user_logic_uart_0_1_uart : entity is "uart";
end design_1_user_logic_uart_0_1_uart;

architecture STRUCTURE of design_1_user_logic_uart_0_1_uart is
  signal \tx_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \tx_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \tx_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \tx_cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal \tx_cnt[3]_i_2_n_0\ : STD_LOGIC;
  signal \tx_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_cnt_reg_n_0_[3]\ : STD_LOGIC;
  signal tx_empty : STD_LOGIC;
  signal tx_is_empty_i_1_n_0 : STD_LOGIC;
  signal tx_is_empty_i_2_n_0 : STD_LOGIC;
  signal tx_out9_out : STD_LOGIC;
  signal tx_out_i_1_n_0 : STD_LOGIC;
  signal tx_out_i_2_n_0 : STD_LOGIC;
  signal tx_out_i_4_n_0 : STD_LOGIC;
  signal tx_out_i_5_n_0 : STD_LOGIC;
  signal tx_reg : STD_LOGIC;
  signal \tx_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \tx_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal \tx_reg_reg_n_0_[2]\ : STD_LOGIC;
  signal \tx_reg_reg_n_0_[3]\ : STD_LOGIC;
  signal \tx_reg_reg_n_0_[4]\ : STD_LOGIC;
  signal \tx_reg_reg_n_0_[5]\ : STD_LOGIC;
  signal \tx_reg_reg_n_0_[6]\ : STD_LOGIC;
  signal \tx_reg_reg_n_0_[7]\ : STD_LOGIC;
  signal \^utx_out\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \tx_cnt[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \tx_cnt[2]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \tx_cnt[3]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of tx_enable_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of tx_is_empty_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of tx_is_empty_i_2 : label is "soft_lutpair2";
begin
  utx_out <= \^utx_out\;
\tx_cnt[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tx_enable,
      I1 => \tx_cnt_reg_n_0_[0]\,
      O => \tx_cnt[0]_i_1_n_0\
    );
\tx_cnt[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"080AA0A0"
    )
        port map (
      I0 => tx_enable,
      I1 => \tx_cnt_reg_n_0_[2]\,
      I2 => \tx_cnt_reg_n_0_[1]\,
      I3 => \tx_cnt_reg_n_0_[3]\,
      I4 => \tx_cnt_reg_n_0_[0]\,
      O => \tx_cnt[1]_i_1_n_0\
    );
\tx_cnt[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2888"
    )
        port map (
      I0 => tx_enable,
      I1 => \tx_cnt_reg_n_0_[2]\,
      I2 => \tx_cnt_reg_n_0_[1]\,
      I3 => \tx_cnt_reg_n_0_[0]\,
      O => \tx_cnt[2]_i_1_n_0\
    );
\tx_cnt[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => tx_empty,
      I1 => tx_enable,
      O => \tx_cnt[3]_i_1_n_0\
    );
\tx_cnt[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2880AA00"
    )
        port map (
      I0 => tx_enable,
      I1 => \tx_cnt_reg_n_0_[2]\,
      I2 => \tx_cnt_reg_n_0_[1]\,
      I3 => \tx_cnt_reg_n_0_[3]\,
      I4 => \tx_cnt_reg_n_0_[0]\,
      O => \tx_cnt[3]_i_2_n_0\
    );
\tx_cnt_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => \tx_cnt[3]_i_1_n_0\,
      CLR => ureset,
      D => \tx_cnt[0]_i_1_n_0\,
      Q => \tx_cnt_reg_n_0_[0]\
    );
\tx_cnt_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => \tx_cnt[3]_i_1_n_0\,
      CLR => ureset,
      D => \tx_cnt[1]_i_1_n_0\,
      Q => \tx_cnt_reg_n_0_[1]\
    );
\tx_cnt_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => \tx_cnt[3]_i_1_n_0\,
      CLR => ureset,
      D => \tx_cnt[2]_i_1_n_0\,
      Q => \tx_cnt_reg_n_0_[2]\
    );
\tx_cnt_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => \tx_cnt[3]_i_1_n_0\,
      CLR => ureset,
      D => \tx_cnt[3]_i_2_n_0\,
      Q => \tx_cnt_reg_n_0_[3]\
    );
tx_enable_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B2"
    )
        port map (
      I0 => tx_enable,
      I1 => tx_empty,
      I2 => utx_en,
      O => tx_enable_reg
    );
tx_is_empty_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08F8"
    )
        port map (
      I0 => tx_is_empty_i_2_n_0,
      I1 => tx_enable,
      I2 => tx_empty,
      I3 => utx_en,
      O => tx_is_empty_i_1_n_0
    );
tx_is_empty_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \tx_cnt_reg_n_0_[2]\,
      I1 => \tx_cnt_reg_n_0_[1]\,
      I2 => \tx_cnt_reg_n_0_[3]\,
      I3 => \tx_cnt_reg_n_0_[0]\,
      O => tx_is_empty_i_2_n_0
    );
tx_is_empty_reg: unisim.vcomponents.FDPE
     port map (
      C => utxclk,
      CE => '1',
      D => tx_is_empty_i_1_n_0,
      PRE => ureset,
      Q => tx_empty
    );
tx_out_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => tx_out_i_2_n_0,
      I1 => tx_out9_out,
      I2 => \^utx_out\,
      O => tx_out_i_1_n_0
    );
tx_out_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330030FEA802A8"
    )
        port map (
      I0 => tx_out_i_4_n_0,
      I1 => \tx_cnt_reg_n_0_[1]\,
      I2 => \tx_cnt_reg_n_0_[0]\,
      I3 => \tx_cnt_reg_n_0_[2]\,
      I4 => tx_out_i_5_n_0,
      I5 => \tx_cnt_reg_n_0_[3]\,
      O => tx_out_i_2_n_0
    );
tx_out_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00440444"
    )
        port map (
      I0 => tx_empty,
      I1 => tx_enable,
      I2 => \tx_cnt_reg_n_0_[1]\,
      I3 => \tx_cnt_reg_n_0_[3]\,
      I4 => \tx_cnt_reg_n_0_[2]\,
      O => tx_out9_out
    );
tx_out_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FCAF0CAFFCA00CA0"
    )
        port map (
      I0 => \tx_reg_reg_n_0_[0]\,
      I1 => \tx_reg_reg_n_0_[1]\,
      I2 => \tx_cnt_reg_n_0_[0]\,
      I3 => \tx_cnt_reg_n_0_[1]\,
      I4 => \tx_reg_reg_n_0_[2]\,
      I5 => \tx_reg_reg_n_0_[3]\,
      O => tx_out_i_4_n_0
    );
tx_out_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FCAF0CAFFCA00CA0"
    )
        port map (
      I0 => \tx_reg_reg_n_0_[4]\,
      I1 => \tx_reg_reg_n_0_[5]\,
      I2 => \tx_cnt_reg_n_0_[0]\,
      I3 => \tx_cnt_reg_n_0_[1]\,
      I4 => \tx_reg_reg_n_0_[6]\,
      I5 => \tx_reg_reg_n_0_[7]\,
      O => tx_out_i_5_n_0
    );
tx_out_reg: unisim.vcomponents.FDPE
     port map (
      C => utxclk,
      CE => '1',
      D => tx_out_i_1_n_0,
      PRE => ureset,
      Q => \^utx_out\
    );
\tx_reg[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => utx_en,
      I1 => tx_empty,
      O => tx_reg
    );
\tx_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => tx_reg,
      CLR => ureset,
      D => utx_data(0),
      Q => \tx_reg_reg_n_0_[0]\
    );
\tx_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => tx_reg,
      CLR => ureset,
      D => utx_data(1),
      Q => \tx_reg_reg_n_0_[1]\
    );
\tx_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => tx_reg,
      CLR => ureset,
      D => utx_data(2),
      Q => \tx_reg_reg_n_0_[2]\
    );
\tx_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => tx_reg,
      CLR => ureset,
      D => utx_data(3),
      Q => \tx_reg_reg_n_0_[3]\
    );
\tx_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => tx_reg,
      CLR => ureset,
      D => utx_data(4),
      Q => \tx_reg_reg_n_0_[4]\
    );
\tx_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => tx_reg,
      CLR => ureset,
      D => utx_data(5),
      Q => \tx_reg_reg_n_0_[5]\
    );
\tx_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => tx_reg,
      CLR => ureset,
      D => utx_data(6),
      Q => \tx_reg_reg_n_0_[6]\
    );
\tx_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => utxclk,
      CE => tx_reg,
      CLR => ureset,
      D => utx_data(7),
      Q => \tx_reg_reg_n_0_[7]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_user_logic_uart_0_1_user_logic_uart is
  port (
    utx_out : out STD_LOGIC;
    utxclk : in STD_LOGIC;
    ureset : in STD_LOGIC;
    utx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    utx_en : in STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_user_logic_uart_0_1_user_logic_uart : entity is "user_logic_uart";
end design_1_user_logic_uart_0_1_user_logic_uart;

architecture STRUCTURE of design_1_user_logic_uart_0_1_user_logic_uart is
  signal tx_enable : STD_LOGIC;
  signal uut_n_1 : STD_LOGIC;
begin
tx_enable_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => uut_n_1,
      Q => tx_enable,
      R => '0'
    );
uut: entity work.design_1_user_logic_uart_0_1_uart
     port map (
      tx_enable => tx_enable,
      tx_enable_reg => uut_n_1,
      ureset => ureset,
      utx_data(7 downto 0) => utx_data(7 downto 0),
      utx_en => utx_en,
      utx_out => utx_out,
      utxclk => utxclk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_user_logic_uart_0_1 is
  port (
    clk : in STD_LOGIC;
    utx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    ureset : in STD_LOGIC;
    utxclk : in STD_LOGIC;
    utx_en : in STD_LOGIC;
    utx_out : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_user_logic_uart_0_1 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_user_logic_uart_0_1 : entity is "design_1_user_logic_uart_0_1,user_logic_uart,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_user_logic_uart_0_1 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_user_logic_uart_0_1 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_user_logic_uart_0_1 : entity is "user_logic_uart,Vivado 2019.1";
end design_1_user_logic_uart_0_1;

architecture STRUCTURE of design_1_user_logic_uart_0_1 is
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0";
begin
U0: entity work.design_1_user_logic_uart_0_1_user_logic_uart
     port map (
      clk => clk,
      ureset => ureset,
      utx_data(7 downto 0) => utx_data(7 downto 0),
      utx_en => utx_en,
      utx_out => utx_out,
      utxclk => utxclk
    );
end STRUCTURE;
