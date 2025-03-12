--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Wed Mar 12 01:06:15 2025
--Host        : UL-31 running 64-bit major release  (build 9200)
--Command     : generate_target design_2_wrapper.bd
--Design      : design_2_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_wrapper is
  port (
    ascii_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ascii_pulse : out STD_LOGIC;
    clk : in STD_LOGIC;
    kb_clk : in STD_LOGIC;
    kb_data : in STD_LOGIC
  );
end design_2_wrapper;

architecture STRUCTURE of design_2_wrapper is
  component design_2 is
  port (
    clk : in STD_LOGIC;
    ascii_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ascii_pulse : out STD_LOGIC;
    kb_data : in STD_LOGIC;
    kb_clk : in STD_LOGIC
  );
  end component design_2;
begin
design_2_i: component design_2
     port map (
      ascii_out(7 downto 0) => ascii_out(7 downto 0),
      ascii_pulse => ascii_pulse,
      clk => clk,
      kb_clk => kb_clk,
      kb_data => kb_data
    );
end STRUCTURE;
