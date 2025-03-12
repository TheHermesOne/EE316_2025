--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Wed Mar 12 03:30:43 2025
--Host        : UL-31 running 64-bit major release  (build 9200)
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
    clk : in STD_LOGIC;
    kb_clk : in STD_LOGIC;
    kb_data : in STD_LOGIC;
    reset : in STD_LOGIC;
    tx_out : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    tx_out : out STD_LOGIC;
    kb_clk : in STD_LOGIC;
    kb_data : in STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      clk => clk,
      kb_clk => kb_clk,
      kb_data => kb_data,
      reset => reset,
      tx_out => tx_out
    );
end STRUCTURE;
