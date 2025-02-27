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

-- IP VLNV: xilinx.com:module_ref:btn_debounce_toggle:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FullBuild_btn_debounce_toggle_0_0 IS
  PORT (
    BTN_I : IN STD_LOGIC;
    CLK : IN STD_LOGIC;
    BTN_O : OUT STD_LOGIC;
    TOGGLE_O : OUT STD_LOGIC;
    PULSE_O : OUT STD_LOGIC
  );
END FullBuild_btn_debounce_toggle_0_0;

ARCHITECTURE FullBuild_btn_debounce_toggle_0_0_arch OF FullBuild_btn_debounce_toggle_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF FullBuild_btn_debounce_toggle_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT btn_debounce_toggle IS
    GENERIC (
      CNTR_MAX : STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
    PORT (
      BTN_I : IN STD_LOGIC;
      CLK : IN STD_LOGIC;
      BTN_O : OUT STD_LOGIC;
      TOGGLE_O : OUT STD_LOGIC;
      PULSE_O : OUT STD_LOGIC
    );
  END COMPONENT btn_debounce_toggle;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF FullBuild_btn_debounce_toggle_0_0_arch: ARCHITECTURE IS "btn_debounce_toggle,Vivado 2019.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF FullBuild_btn_debounce_toggle_0_0_arch : ARCHITECTURE IS "FullBuild_btn_debounce_toggle_0_0,btn_debounce_toggle,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF FullBuild_btn_debounce_toggle_0_0_arch: ARCHITECTURE IS "FullBuild_btn_debounce_toggle_0_0,btn_debounce_toggle,{x_ipProduct=Vivado 2019.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=btn_debounce_toggle,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,CNTR_MAX=0xFFFF}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF FullBuild_btn_debounce_toggle_0_0_arch: ARCHITECTURE IS "module_ref";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF CLK: SIGNAL IS "XIL_INTERFACENAME CLK, FREQ_HZ 5e+07, PHASE 0.000, CLK_DOMAIN FullBuild_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF CLK: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK CLK";
BEGIN
  U0 : btn_debounce_toggle
    GENERIC MAP (
      CNTR_MAX => X"FFFF"
    )
    PORT MAP (
      BTN_I => BTN_I,
      CLK => CLK,
      BTN_O => BTN_O,
      TOGGLE_O => TOGGLE_O,
      PULSE_O => PULSE_O
    );
END FullBuild_btn_debounce_toggle_0_0_arch;
