-- (c) Copyright 1995-2025 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:vga_controller:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_vga_controller_0_0 IS
  PORT (
    pixel_clk : IN STD_LOGIC;
    reset_n : IN STD_LOGIC;
    h_sync : OUT STD_LOGIC;
    v_sync : OUT STD_LOGIC;
    disp_ena : OUT STD_LOGIC;
    column : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    row : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    n_blank : OUT STD_LOGIC;
    n_sync : OUT STD_LOGIC
  );
END design_1_vga_controller_0_0;

ARCHITECTURE design_1_vga_controller_0_0_arch OF design_1_vga_controller_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_vga_controller_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT vga_controller IS
    GENERIC (
      h_pulse : INTEGER;
      h_bp : INTEGER;
      h_pixels : INTEGER;
      h_fp : INTEGER;
      h_pol : STD_LOGIC;
      v_pulse : INTEGER;
      v_bp : INTEGER;
      v_pixels : INTEGER;
      v_fp : INTEGER;
      v_pol : STD_LOGIC
    );
    PORT (
      pixel_clk : IN STD_LOGIC;
      reset_n : IN STD_LOGIC;
      h_sync : OUT STD_LOGIC;
      v_sync : OUT STD_LOGIC;
      disp_ena : OUT STD_LOGIC;
      column : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      row : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      n_blank : OUT STD_LOGIC;
      n_sync : OUT STD_LOGIC
    );
  END COMPONENT vga_controller;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF design_1_vga_controller_0_0_arch: ARCHITECTURE IS "vga_controller,Vivado 2019.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF design_1_vga_controller_0_0_arch : ARCHITECTURE IS "design_1_vga_controller_0_0,vga_controller,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF design_1_vga_controller_0_0_arch: ARCHITECTURE IS "design_1_vga_controller_0_0,vga_controller,{x_ipProduct=Vivado 2019.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=vga_controller,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,h_pulse=96,h_bp=48,h_pixels=640,h_fp=16,h_pol=0,v_pulse=2,v_bp=33,v_pixels=480,v_fp=10,v_pol=0}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF design_1_vga_controller_0_0_arch: ARCHITECTURE IS "module_ref";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF reset_n: SIGNAL IS "XIL_INTERFACENAME reset_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF reset_n: SIGNAL IS "xilinx.com:signal:reset:1.0 reset_n RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF pixel_clk: SIGNAL IS "XIL_INTERFACENAME pixel_clk, FREQ_HZ 25173966, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF pixel_clk: SIGNAL IS "xilinx.com:signal:clock:1.0 pixel_clk CLK";
BEGIN
  U0 : vga_controller
    GENERIC MAP (
      h_pulse => 96,
      h_bp => 48,
      h_pixels => 640,
      h_fp => 16,
      h_pol => '0',
      v_pulse => 2,
      v_bp => 33,
      v_pixels => 480,
      v_fp => 10,
      v_pol => '0'
    )
    PORT MAP (
      pixel_clk => pixel_clk,
      reset_n => reset_n,
      h_sync => h_sync,
      v_sync => v_sync,
      disp_ena => disp_ena,
      column => column,
      row => row,
      n_blank => n_blank,
      n_sync => n_sync
    );
END design_1_vga_controller_0_0_arch;
