-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"

-- DATE "02/09/2025 15:04:01"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	i2c_user_logic IS
    PORT (
	clk : IN std_logic;
	iData : IN std_logic_vector(15 DOWNTO 0);
	sda : INOUT std_logic;
	scl : INOUT std_logic
	);
END i2c_user_logic;

-- Design Ports Information
-- sda	=>  Location: PIN_F14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- scl	=>  Location: PIN_G14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[10]	=>  Location: PIN_D14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[6]	=>  Location: PIN_Y12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[14]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[2]	=>  Location: PIN_J14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[9]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[5]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[13]	=>  Location: PIN_AA13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[1]	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[8]	=>  Location: PIN_C14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[4]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[12]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[0]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[11]	=>  Location: PIN_D15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[7]	=>  Location: PIN_M28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[15]	=>  Location: PIN_AA12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[3]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF i2c_user_logic IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_iData : std_logic_vector(15 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Add0~6_combout\ : std_logic;
SIGNAL \Add0~8_combout\ : std_logic;
SIGNAL \Add0~12_combout\ : std_logic;
SIGNAL \Add0~30_combout\ : std_logic;
SIGNAL \Add0~32_combout\ : std_logic;
SIGNAL \inst_i2c_master|Equal0~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.command~q\ : std_logic;
SIGNAL \inst_i2c_master|Mux2~3_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~9_combout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector19~0_combout\ : std_logic;
SIGNAL \cont[3]~4_combout\ : std_logic;
SIGNAL \cont[4]~5_combout\ : std_logic;
SIGNAL \cont[6]~7_combout\ : std_logic;
SIGNAL \sda~input_o\ : std_logic;
SIGNAL \scl~input_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \iData[10]~input_o\ : std_logic;
SIGNAL \iData[2]~input_o\ : std_logic;
SIGNAL \iData[5]~input_o\ : std_logic;
SIGNAL \iData[1]~input_o\ : std_logic;
SIGNAL \iData[8]~input_o\ : std_logic;
SIGNAL \iData[12]~input_o\ : std_logic;
SIGNAL \iData[11]~input_o\ : std_logic;
SIGNAL \iData[3]~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \sda~output_o\ : std_logic;
SIGNAL \scl~output_o\ : std_logic;
SIGNAL \inst_i2c_master|bit_cnt[0]~1_combout\ : std_logic;
SIGNAL \cont[0]~1_combout\ : std_logic;
SIGNAL \Add0~1_cout\ : std_logic;
SIGNAL \Add0~2_combout\ : std_logic;
SIGNAL \cont[1]~2_combout\ : std_logic;
SIGNAL \cont[0]~0_combout\ : std_logic;
SIGNAL \Add0~3\ : std_logic;
SIGNAL \Add0~4_combout\ : std_logic;
SIGNAL \cont[2]~3_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Add0~5\ : std_logic;
SIGNAL \Add0~7\ : std_logic;
SIGNAL \Add0~9\ : std_logic;
SIGNAL \Add0~10_combout\ : std_logic;
SIGNAL \cont[5]~6_combout\ : std_logic;
SIGNAL \Add0~11\ : std_logic;
SIGNAL \Add0~13\ : std_logic;
SIGNAL \Add0~14_combout\ : std_logic;
SIGNAL \cont[7]~8_combout\ : std_logic;
SIGNAL \Add0~15\ : std_logic;
SIGNAL \Add0~17\ : std_logic;
SIGNAL \Add0~18_combout\ : std_logic;
SIGNAL \cont[9]~10_combout\ : std_logic;
SIGNAL \Add0~19\ : std_logic;
SIGNAL \Add0~21\ : std_logic;
SIGNAL \Add0~22_combout\ : std_logic;
SIGNAL \cont[11]~12_combout\ : std_logic;
SIGNAL \Add0~23\ : std_logic;
SIGNAL \Add0~25\ : std_logic;
SIGNAL \Add0~26_combout\ : std_logic;
SIGNAL \cont[13]~14_combout\ : std_logic;
SIGNAL \Add0~27\ : std_logic;
SIGNAL \Add0~28_combout\ : std_logic;
SIGNAL \Add0~29\ : std_logic;
SIGNAL \Add0~31\ : std_logic;
SIGNAL \Add0~33\ : std_logic;
SIGNAL \Add0~34_combout\ : std_logic;
SIGNAL \Add0~35\ : std_logic;
SIGNAL \Add0~36_combout\ : std_logic;
SIGNAL \Add0~37\ : std_logic;
SIGNAL \Add0~38_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Add0~16_combout\ : std_logic;
SIGNAL \cont[8]~9_combout\ : std_logic;
SIGNAL \Add0~20_combout\ : std_logic;
SIGNAL \cont[10]~11_combout\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \Add0~24_combout\ : std_logic;
SIGNAL \cont[12]~13_combout\ : std_logic;
SIGNAL \Equal0~4_combout\ : std_logic;
SIGNAL \Equal0~5_combout\ : std_logic;
SIGNAL \Equal0~6_combout\ : std_logic;
SIGNAL \reset_n~0_combout\ : std_logic;
SIGNAL \reset_n~q\ : std_logic;
SIGNAL \inst_i2c_master|count~8_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~3_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~3\ : std_logic;
SIGNAL \inst_i2c_master|Add0~5\ : std_logic;
SIGNAL \inst_i2c_master|Add0~6_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~7\ : std_logic;
SIGNAL \inst_i2c_master|Add0~8_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~9\ : std_logic;
SIGNAL \inst_i2c_master|Add0~11\ : std_logic;
SIGNAL \inst_i2c_master|Add0~12_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~10_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~5_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~6_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~13\ : std_logic;
SIGNAL \inst_i2c_master|Add0~14_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~7_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~15\ : std_logic;
SIGNAL \inst_i2c_master|Add0~16_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~6_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~17\ : std_logic;
SIGNAL \inst_i2c_master|Add0~18_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~3_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~4_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~4_combout\ : std_logic;
SIGNAL \inst_i2c_master|stretch~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|stretch~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|stretch~q\ : std_logic;
SIGNAL \inst_i2c_master|Add0~1\ : std_logic;
SIGNAL \inst_i2c_master|Add0~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~4_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add0~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|count~5_combout\ : std_logic;
SIGNAL \inst_i2c_master|Equal0~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Equal0~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~12_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~8_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~9_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~10_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~11_combout\ : std_logic;
SIGNAL \inst_i2c_master|data_clk~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|process_0~7_combout\ : std_logic;
SIGNAL \inst_i2c_master|data_clk~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|data_clk~q\ : std_logic;
SIGNAL \inst_i2c_master|data_clk_prev~q\ : std_logic;
SIGNAL \inst_i2c_master|process_1~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Equal1~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector21~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.rd~q\ : std_logic;
SIGNAL \inst_i2c_master|state~13_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.slv_ack2~q\ : std_logic;
SIGNAL \inst_i2c_master|Selector20~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector20~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.wr~q\ : std_logic;
SIGNAL \inst_i2c_master|bit_cnt[2]~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector25~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Add1~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|state~14_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.mstr_ack~q\ : std_logic;
SIGNAL \inst_i2c_master|Selector0~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|state~15_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.slv_ack1~q\ : std_logic;
SIGNAL \inst_i2c_master|Selector22~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.stop~q\ : std_logic;
SIGNAL \inst_i2c_master|Selector0~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector0~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|busy~q\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \state.repeat~q\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \state.start~q\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \state.write_data~q\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \i2c_ena~q\ : std_logic;
SIGNAL \inst_i2c_master|Selector17~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.ready~q\ : std_logic;
SIGNAL \inst_i2c_master|Selector18~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|state.start~q\ : std_logic;
SIGNAL \busy_prev~0_combout\ : std_logic;
SIGNAL \busy_prev~q\ : std_logic;
SIGNAL \byteSel~0_combout\ : std_logic;
SIGNAL \Selector7~0_combout\ : std_logic;
SIGNAL \Selector7~1_combout\ : std_logic;
SIGNAL \Selector5~3_combout\ : std_logic;
SIGNAL \Selector6~1_combout\ : std_logic;
SIGNAL \Add1~0_combout\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \Selector4~1_combout\ : std_logic;
SIGNAL \LessThan0~0_combout\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \Selector5~2_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|data_tx[0]~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|data_tx[0]~3_combout\ : std_logic;
SIGNAL \Mux5~2_combout\ : std_logic;
SIGNAL \iData[6]~input_o\ : std_logic;
SIGNAL \iData[14]~input_o\ : std_logic;
SIGNAL \Mux4~2_combout\ : std_logic;
SIGNAL \Mux4~1_combout\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Mux5~1_combout\ : std_logic;
SIGNAL \Mux5~3_combout\ : std_logic;
SIGNAL \Mux4~3_combout\ : std_logic;
SIGNAL \iData[7]~input_o\ : std_logic;
SIGNAL \iData[15]~input_o\ : std_logic;
SIGNAL \Mux4~4_combout\ : std_logic;
SIGNAL \Mux4~5_combout\ : std_logic;
SIGNAL \Mux4~6_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux2~0_combout\ : std_logic;
SIGNAL \iData[9]~input_o\ : std_logic;
SIGNAL \iData[13]~input_o\ : std_logic;
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \Mux6~1_combout\ : std_logic;
SIGNAL \Mux6~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux2~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux2~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux2~4_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~3_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~4_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~5_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux3~3_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux3~2_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux3~5_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux3~4_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~6_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~7_combout\ : std_logic;
SIGNAL \iData[4]~input_o\ : std_logic;
SIGNAL \iData[0]~input_o\ : std_logic;
SIGNAL \Mux7~1_combout\ : std_logic;
SIGNAL \Mux7~2_combout\ : std_logic;
SIGNAL \Mux7~0_combout\ : std_logic;
SIGNAL \Mux7~3_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux4~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Mux4~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector23~8_combout\ : std_logic;
SIGNAL \inst_i2c_master|sda_int~q\ : std_logic;
SIGNAL \inst_i2c_master|Selector29~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|Selector29~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|scl_ena~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|scl_ena~1_combout\ : std_logic;
SIGNAL \inst_i2c_master|scl_ena~q\ : std_logic;
SIGNAL \inst_i2c_master|scl_clk~0_combout\ : std_logic;
SIGNAL \inst_i2c_master|scl_clk~q\ : std_logic;
SIGNAL \inst_i2c_master|scl~1_combout\ : std_logic;
SIGNAL cont : std_logic_vector(19 DOWNTO 0);
SIGNAL byteSel : std_logic_vector(3 DOWNTO 0);
SIGNAL \inst_i2c_master|data_tx\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \inst_i2c_master|count\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \inst_i2c_master|bit_cnt\ : std_logic_vector(2 DOWNTO 0);

BEGIN

ww_clk <= clk;
ww_iData <= iData;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

-- Location: LCCOMB_X49_Y44_N18
\Add0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~6_combout\ = (cont(3) & (!\Add0~5\)) # (!cont(3) & (\Add0~5\ & VCC))
-- \Add0~7\ = CARRY((cont(3) & !\Add0~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101000001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => cont(3),
	datad => VCC,
	cin => \Add0~5\,
	combout => \Add0~6_combout\,
	cout => \Add0~7\);

-- Location: LCCOMB_X49_Y44_N20
\Add0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~8_combout\ = (cont(4) & (\Add0~7\ $ (GND))) # (!cont(4) & ((GND) # (!\Add0~7\)))
-- \Add0~9\ = CARRY((!\Add0~7\) # (!cont(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => cont(4),
	datad => VCC,
	cin => \Add0~7\,
	combout => \Add0~8_combout\,
	cout => \Add0~9\);

-- Location: LCCOMB_X49_Y44_N24
\Add0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~12_combout\ = (cont(6) & (\Add0~11\ $ (GND))) # (!cont(6) & ((GND) # (!\Add0~11\)))
-- \Add0~13\ = CARRY((!\Add0~11\) # (!cont(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => cont(6),
	datad => VCC,
	cin => \Add0~11\,
	combout => \Add0~12_combout\,
	cout => \Add0~13\);

-- Location: LCCOMB_X49_Y43_N10
\Add0~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~30_combout\ = (cont(15) & (\Add0~29\ & VCC)) # (!cont(15) & (!\Add0~29\))
-- \Add0~31\ = CARRY((!cont(15) & !\Add0~29\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => cont(15),
	datad => VCC,
	cin => \Add0~29\,
	combout => \Add0~30_combout\,
	cout => \Add0~31\);

-- Location: LCCOMB_X49_Y43_N12
\Add0~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~32_combout\ = (cont(16) & ((GND) # (!\Add0~31\))) # (!cont(16) & (\Add0~31\ $ (GND)))
-- \Add0~33\ = CARRY((cont(16)) # (!\Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010101111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => cont(16),
	datad => VCC,
	cin => \Add0~31\,
	combout => \Add0~32_combout\,
	cout => \Add0~33\);

-- Location: FF_X48_Y45_N23
\inst_i2c_master|count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|count~9_combout\,
	clrn => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(5));

-- Location: LCCOMB_X47_Y45_N6
\inst_i2c_master|Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Equal0~1_combout\ = (!\inst_i2c_master|count\(3) & (\inst_i2c_master|count\(5) & (\inst_i2c_master|count\(2) & !\inst_i2c_master|count\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|count\(3),
	datab => \inst_i2c_master|count\(5),
	datac => \inst_i2c_master|count\(2),
	datad => \inst_i2c_master|count\(4),
	combout => \inst_i2c_master|Equal0~1_combout\);

-- Location: LCCOMB_X52_Y45_N12
\inst_i2c_master|Selector23~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~0_combout\ = (\inst_i2c_master|bit_cnt\(0) & (((\Mux1~0_combout\)))) # (!\inst_i2c_master|bit_cnt\(0) & ((\inst_i2c_master|bit_cnt\(1) & ((\Mux1~0_combout\))) # (!\inst_i2c_master|bit_cnt\(1) & (\Mux0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|bit_cnt\(0),
	datab => \Mux0~0_combout\,
	datac => \inst_i2c_master|bit_cnt\(1),
	datad => \Mux1~0_combout\,
	combout => \inst_i2c_master|Selector23~0_combout\);

-- Location: LCCOMB_X49_Y45_N12
\inst_i2c_master|Selector23~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~2_combout\ = ((\inst_i2c_master|Equal1~0_combout\ & (!\i2c_ena~q\)) # (!\inst_i2c_master|Equal1~0_combout\ & ((!\inst_i2c_master|sda_int~q\)))) # (!\inst_i2c_master|state.rd~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.rd~q\,
	datab => \i2c_ena~q\,
	datac => \inst_i2c_master|sda_int~q\,
	datad => \inst_i2c_master|Equal1~0_combout\,
	combout => \inst_i2c_master|Selector23~2_combout\);

-- Location: FF_X48_Y45_N13
\inst_i2c_master|state.command\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Selector19~0_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.command~q\);

-- Location: FF_X52_Y45_N9
\inst_i2c_master|data_tx[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Mux7~3_combout\,
	sload => VCC,
	ena => \inst_i2c_master|data_tx[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|data_tx\(0));

-- Location: LCCOMB_X50_Y45_N16
\inst_i2c_master|Mux2~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux2~3_combout\ = (\inst_i2c_master|bit_cnt\(0) & ((\inst_i2c_master|data_tx\(6)))) # (!\inst_i2c_master|bit_cnt\(0) & (\inst_i2c_master|data_tx\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|bit_cnt\(0),
	datac => \inst_i2c_master|data_tx\(7),
	datad => \inst_i2c_master|data_tx\(6),
	combout => \inst_i2c_master|Mux2~3_combout\);

-- Location: LCCOMB_X48_Y45_N22
\inst_i2c_master|count~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~9_combout\ = (\inst_i2c_master|Add0~10_combout\ & !\inst_i2c_master|Equal0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~10_combout\,
	datad => \inst_i2c_master|Equal0~2_combout\,
	combout => \inst_i2c_master|count~9_combout\);

-- Location: FF_X49_Y43_N13
\cont[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Add0~32_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(16));

-- Location: FF_X49_Y44_N11
\cont[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[3]~4_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(3));

-- Location: FF_X49_Y44_N7
\cont[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[4]~5_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(4));

-- Location: FF_X50_Y44_N7
\cont[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[6]~7_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(6));

-- Location: LCCOMB_X50_Y44_N10
\Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = (cont(5) & (cont(7) & (cont(4) & cont(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cont(5),
	datab => cont(7),
	datac => cont(4),
	datad => cont(6),
	combout => \Equal0~2_combout\);

-- Location: FF_X49_Y43_N11
\cont[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Add0~30_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(15));

-- Location: LCCOMB_X49_Y45_N18
\inst_i2c_master|Selector19~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector19~0_combout\ = (\inst_i2c_master|state.start~q\) # ((\inst_i2c_master|state.command~q\ & !\inst_i2c_master|Equal1~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.command~q\,
	datab => \inst_i2c_master|state.start~q\,
	datad => \inst_i2c_master|Equal1~0_combout\,
	combout => \inst_i2c_master|Selector19~0_combout\);

-- Location: LCCOMB_X49_Y44_N10
\cont[3]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[3]~4_combout\ = !\Add0~6_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~6_combout\,
	combout => \cont[3]~4_combout\);

-- Location: LCCOMB_X49_Y44_N6
\cont[4]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[4]~5_combout\ = !\Add0~8_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~8_combout\,
	combout => \cont[4]~5_combout\);

-- Location: LCCOMB_X50_Y44_N6
\cont[6]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[6]~7_combout\ = !\Add0~12_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~12_combout\,
	combout => \cont[6]~7_combout\);

-- Location: IOIBUF_X47_Y73_N15
\scl~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => scl,
	o => \scl~input_o\);

-- Location: IOIBUF_X0_Y36_N8
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: IOIBUF_X52_Y73_N8
\iData[10]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(10),
	o => \iData[10]~input_o\);

-- Location: IOIBUF_X49_Y73_N22
\iData[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(2),
	o => \iData[2]~input_o\);

-- Location: IOIBUF_X52_Y73_N22
\iData[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(5),
	o => \iData[5]~input_o\);

-- Location: IOIBUF_X49_Y73_N15
\iData[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(1),
	o => \iData[1]~input_o\);

-- Location: IOIBUF_X52_Y73_N1
\iData[8]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(8),
	o => \iData[8]~input_o\);

-- Location: IOIBUF_X54_Y73_N1
\iData[12]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(12),
	o => \iData[12]~input_o\);

-- Location: IOIBUF_X58_Y73_N22
\iData[11]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(11),
	o => \iData[11]~input_o\);

-- Location: IOIBUF_X52_Y73_N15
\iData[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(3),
	o => \iData[3]~input_o\);

-- Location: CLKCTRL_G2
\clk~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOOBUF_X45_Y73_N2
\sda~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \inst_i2c_master|Selector29~1_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => \sda~output_o\);

-- Location: IOOBUF_X47_Y73_N16
\scl~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \inst_i2c_master|scl~1_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => \scl~output_o\);

-- Location: LCCOMB_X50_Y45_N18
\inst_i2c_master|bit_cnt[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|bit_cnt[0]~1_combout\ = !\inst_i2c_master|bit_cnt\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|bit_cnt\(0),
	combout => \inst_i2c_master|bit_cnt[0]~1_combout\);

-- Location: LCCOMB_X49_Y44_N0
\cont[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[0]~1_combout\ = cont(0) $ (((!\state.start~q\ & !\Equal0~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \state.start~q\,
	datac => cont(0),
	datad => \Equal0~6_combout\,
	combout => \cont[0]~1_combout\);

-- Location: FF_X49_Y44_N1
\cont[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(0));

-- Location: LCCOMB_X49_Y44_N12
\Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~1_cout\ = CARRY(!cont(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => cont(0),
	datad => VCC,
	cout => \Add0~1_cout\);

-- Location: LCCOMB_X49_Y44_N14
\Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~2_combout\ = (cont(1) & (!\Add0~1_cout\)) # (!cont(1) & (\Add0~1_cout\ & VCC))
-- \Add0~3\ = CARRY((cont(1) & !\Add0~1_cout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(1),
	datad => VCC,
	cin => \Add0~1_cout\,
	combout => \Add0~2_combout\,
	cout => \Add0~3\);

-- Location: LCCOMB_X49_Y44_N2
\cont[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[1]~2_combout\ = !\Add0~2_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Add0~2_combout\,
	combout => \cont[1]~2_combout\);

-- Location: LCCOMB_X50_Y44_N26
\cont[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[0]~0_combout\ = (!\state.start~q\ & !\Equal0~6_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \state.start~q\,
	datad => \Equal0~6_combout\,
	combout => \cont[0]~0_combout\);

-- Location: FF_X49_Y44_N3
\cont[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[1]~2_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(1));

-- Location: LCCOMB_X49_Y44_N16
\Add0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~4_combout\ = (cont(2) & (\Add0~3\ $ (GND))) # (!cont(2) & ((GND) # (!\Add0~3\)))
-- \Add0~5\ = CARRY((!\Add0~3\) # (!cont(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(2),
	datad => VCC,
	cin => \Add0~3\,
	combout => \Add0~4_combout\,
	cout => \Add0~5\);

-- Location: LCCOMB_X49_Y44_N8
\cont[2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[2]~3_combout\ = !\Add0~4_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~4_combout\,
	combout => \cont[2]~3_combout\);

-- Location: FF_X49_Y44_N9
\cont[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[2]~3_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(2));

-- Location: LCCOMB_X49_Y44_N4
\Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = (cont(3) & (cont(1) & (cont(2) & cont(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cont(3),
	datab => cont(1),
	datac => cont(2),
	datad => cont(0),
	combout => \Equal0~1_combout\);

-- Location: LCCOMB_X49_Y44_N22
\Add0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~10_combout\ = (cont(5) & (!\Add0~9\)) # (!cont(5) & (\Add0~9\ & VCC))
-- \Add0~11\ = CARRY((cont(5) & !\Add0~9\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(5),
	datad => VCC,
	cin => \Add0~9\,
	combout => \Add0~10_combout\,
	cout => \Add0~11\);

-- Location: LCCOMB_X50_Y44_N12
\cont[5]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[5]~6_combout\ = !\Add0~10_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~10_combout\,
	combout => \cont[5]~6_combout\);

-- Location: FF_X50_Y44_N13
\cont[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[5]~6_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(5));

-- Location: LCCOMB_X49_Y44_N26
\Add0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~14_combout\ = (cont(7) & (!\Add0~13\)) # (!cont(7) & (\Add0~13\ & VCC))
-- \Add0~15\ = CARRY((cont(7) & !\Add0~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(7),
	datad => VCC,
	cin => \Add0~13\,
	combout => \Add0~14_combout\,
	cout => \Add0~15\);

-- Location: LCCOMB_X50_Y44_N28
\cont[7]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[7]~8_combout\ = !\Add0~14_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Add0~14_combout\,
	combout => \cont[7]~8_combout\);

-- Location: FF_X50_Y44_N29
\cont[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[7]~8_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(7));

-- Location: LCCOMB_X49_Y44_N28
\Add0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~16_combout\ = (cont(8) & (\Add0~15\ $ (GND))) # (!cont(8) & ((GND) # (!\Add0~15\)))
-- \Add0~17\ = CARRY((!\Add0~15\) # (!cont(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => cont(8),
	datad => VCC,
	cin => \Add0~15\,
	combout => \Add0~16_combout\,
	cout => \Add0~17\);

-- Location: LCCOMB_X49_Y44_N30
\Add0~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~18_combout\ = (cont(9) & (!\Add0~17\)) # (!cont(9) & (\Add0~17\ & VCC))
-- \Add0~19\ = CARRY((cont(9) & !\Add0~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(9),
	datad => VCC,
	cin => \Add0~17\,
	combout => \Add0~18_combout\,
	cout => \Add0~19\);

-- Location: LCCOMB_X50_Y44_N22
\cont[9]~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[9]~10_combout\ = !\Add0~18_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~18_combout\,
	combout => \cont[9]~10_combout\);

-- Location: FF_X50_Y44_N23
\cont[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[9]~10_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(9));

-- Location: LCCOMB_X49_Y43_N0
\Add0~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~20_combout\ = (cont(10) & (\Add0~19\ $ (GND))) # (!cont(10) & ((GND) # (!\Add0~19\)))
-- \Add0~21\ = CARRY((!\Add0~19\) # (!cont(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => cont(10),
	datad => VCC,
	cin => \Add0~19\,
	combout => \Add0~20_combout\,
	cout => \Add0~21\);

-- Location: LCCOMB_X49_Y43_N2
\Add0~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~22_combout\ = (cont(11) & (!\Add0~21\)) # (!cont(11) & (\Add0~21\ & VCC))
-- \Add0~23\ = CARRY((cont(11) & !\Add0~21\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(11),
	datad => VCC,
	cin => \Add0~21\,
	combout => \Add0~22_combout\,
	cout => \Add0~23\);

-- Location: LCCOMB_X50_Y44_N30
\cont[11]~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[11]~12_combout\ = !\Add0~22_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~22_combout\,
	combout => \cont[11]~12_combout\);

-- Location: FF_X50_Y44_N31
\cont[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[11]~12_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(11));

-- Location: LCCOMB_X49_Y43_N4
\Add0~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~24_combout\ = (cont(12) & (\Add0~23\ $ (GND))) # (!cont(12) & ((GND) # (!\Add0~23\)))
-- \Add0~25\ = CARRY((!\Add0~23\) # (!cont(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => cont(12),
	datad => VCC,
	cin => \Add0~23\,
	combout => \Add0~24_combout\,
	cout => \Add0~25\);

-- Location: LCCOMB_X49_Y43_N6
\Add0~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~26_combout\ = (cont(13) & (!\Add0~25\)) # (!cont(13) & (\Add0~25\ & VCC))
-- \Add0~27\ = CARRY((cont(13) & !\Add0~25\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(13),
	datad => VCC,
	cin => \Add0~25\,
	combout => \Add0~26_combout\,
	cout => \Add0~27\);

-- Location: LCCOMB_X49_Y43_N24
\cont[13]~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[13]~14_combout\ = !\Add0~26_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~26_combout\,
	combout => \cont[13]~14_combout\);

-- Location: FF_X49_Y43_N25
\cont[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[13]~14_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(13));

-- Location: LCCOMB_X49_Y43_N8
\Add0~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~28_combout\ = (cont(14) & ((GND) # (!\Add0~27\))) # (!cont(14) & (\Add0~27\ $ (GND)))
-- \Add0~29\ = CARRY((cont(14)) # (!\Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(14),
	datad => VCC,
	cin => \Add0~27\,
	combout => \Add0~28_combout\,
	cout => \Add0~29\);

-- Location: FF_X49_Y43_N9
\cont[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Add0~28_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(14));

-- Location: LCCOMB_X49_Y43_N14
\Add0~34\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~34_combout\ = (cont(17) & (\Add0~33\ & VCC)) # (!cont(17) & (!\Add0~33\))
-- \Add0~35\ = CARRY((!cont(17) & !\Add0~33\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(17),
	datad => VCC,
	cin => \Add0~33\,
	combout => \Add0~34_combout\,
	cout => \Add0~35\);

-- Location: FF_X49_Y43_N15
\cont[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Add0~34_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(17));

-- Location: LCCOMB_X49_Y43_N16
\Add0~36\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~36_combout\ = (cont(18) & ((GND) # (!\Add0~35\))) # (!cont(18) & (\Add0~35\ $ (GND)))
-- \Add0~37\ = CARRY((cont(18)) # (!\Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => cont(18),
	datad => VCC,
	cin => \Add0~35\,
	combout => \Add0~36_combout\,
	cout => \Add0~37\);

-- Location: FF_X49_Y43_N17
\cont[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Add0~36_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(18));

-- Location: LCCOMB_X49_Y43_N18
\Add0~38\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add0~38_combout\ = \Add0~37\ $ (!cont(19))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => cont(19),
	cin => \Add0~37\,
	combout => \Add0~38_combout\);

-- Location: FF_X49_Y43_N19
\cont[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Add0~38_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(19));

-- Location: LCCOMB_X49_Y43_N28
\Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = (!cont(16) & (!cont(18) & (!cont(17) & !cont(19))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cont(16),
	datab => cont(18),
	datac => cont(17),
	datad => cont(19),
	combout => \Equal0~0_combout\);

-- Location: LCCOMB_X50_Y44_N20
\cont[8]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[8]~9_combout\ = !\Add0~16_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~16_combout\,
	combout => \cont[8]~9_combout\);

-- Location: FF_X50_Y44_N21
\cont[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[8]~9_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(8));

-- Location: LCCOMB_X50_Y44_N16
\cont[10]~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[10]~11_combout\ = !\Add0~20_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Add0~20_combout\,
	combout => \cont[10]~11_combout\);

-- Location: FF_X50_Y44_N17
\cont[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[10]~11_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(10));

-- Location: LCCOMB_X50_Y44_N8
\Equal0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = (cont(9) & (cont(8) & (cont(11) & cont(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cont(9),
	datab => cont(8),
	datac => cont(11),
	datad => cont(10),
	combout => \Equal0~3_combout\);

-- Location: LCCOMB_X49_Y43_N26
\cont[12]~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \cont[12]~13_combout\ = !\Add0~24_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Add0~24_combout\,
	combout => \cont[12]~13_combout\);

-- Location: FF_X49_Y43_N27
\cont[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \cont[12]~13_combout\,
	ena => \cont[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => cont(12));

-- Location: LCCOMB_X49_Y43_N22
\Equal0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~4_combout\ = (!cont(15) & (!cont(14) & (cont(12) & cont(13))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => cont(15),
	datab => cont(14),
	datac => cont(12),
	datad => cont(13),
	combout => \Equal0~4_combout\);

-- Location: LCCOMB_X50_Y44_N18
\Equal0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~5_combout\ = (\Equal0~3_combout\ & \Equal0~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Equal0~3_combout\,
	datad => \Equal0~4_combout\,
	combout => \Equal0~5_combout\);

-- Location: LCCOMB_X50_Y44_N24
\Equal0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~6_combout\ = (\Equal0~2_combout\ & (\Equal0~1_combout\ & (\Equal0~0_combout\ & \Equal0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~2_combout\,
	datab => \Equal0~1_combout\,
	datac => \Equal0~0_combout\,
	datad => \Equal0~5_combout\,
	combout => \Equal0~6_combout\);

-- Location: LCCOMB_X48_Y45_N30
\reset_n~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \reset_n~0_combout\ = (\state.start~q\ & (\reset_n~q\)) # (!\state.start~q\ & ((\Equal0~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.start~q\,
	datac => \reset_n~q\,
	datad => \Equal0~6_combout\,
	combout => \reset_n~0_combout\);

-- Location: FF_X48_Y45_N31
reset_n : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \reset_n~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \reset_n~q\);

-- Location: LCCOMB_X48_Y45_N28
\inst_i2c_master|count~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~8_combout\ = (\inst_i2c_master|Add0~12_combout\ & !\inst_i2c_master|Equal0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|Add0~12_combout\,
	datad => \inst_i2c_master|Equal0~2_combout\,
	combout => \inst_i2c_master|count~8_combout\);

-- Location: FF_X48_Y45_N29
\inst_i2c_master|count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|count~8_combout\,
	clrn => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(6));

-- Location: LCCOMB_X48_Y45_N26
\inst_i2c_master|count~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~3_combout\ = (\inst_i2c_master|Add0~4_combout\ & !\inst_i2c_master|Equal0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~4_combout\,
	datad => \inst_i2c_master|Equal0~2_combout\,
	combout => \inst_i2c_master|count~3_combout\);

-- Location: FF_X48_Y45_N1
\inst_i2c_master|count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|count~3_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(2));

-- Location: LCCOMB_X48_Y45_N4
\inst_i2c_master|Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~2_combout\ = (\inst_i2c_master|count\(1) & (!\inst_i2c_master|Add0~1\)) # (!\inst_i2c_master|count\(1) & ((\inst_i2c_master|Add0~1\) # (GND)))
-- \inst_i2c_master|Add0~3\ = CARRY((!\inst_i2c_master|Add0~1\) # (!\inst_i2c_master|count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|count\(1),
	datad => VCC,
	cin => \inst_i2c_master|Add0~1\,
	combout => \inst_i2c_master|Add0~2_combout\,
	cout => \inst_i2c_master|Add0~3\);

-- Location: LCCOMB_X48_Y45_N6
\inst_i2c_master|Add0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~4_combout\ = (\inst_i2c_master|count\(2) & (\inst_i2c_master|Add0~3\ $ (GND))) # (!\inst_i2c_master|count\(2) & (!\inst_i2c_master|Add0~3\ & VCC))
-- \inst_i2c_master|Add0~5\ = CARRY((\inst_i2c_master|count\(2) & !\inst_i2c_master|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|count\(2),
	datad => VCC,
	cin => \inst_i2c_master|Add0~3\,
	combout => \inst_i2c_master|Add0~4_combout\,
	cout => \inst_i2c_master|Add0~5\);

-- Location: LCCOMB_X48_Y45_N8
\inst_i2c_master|Add0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~6_combout\ = (\inst_i2c_master|count\(3) & (!\inst_i2c_master|Add0~5\)) # (!\inst_i2c_master|count\(3) & ((\inst_i2c_master|Add0~5\) # (GND)))
-- \inst_i2c_master|Add0~7\ = CARRY((!\inst_i2c_master|Add0~5\) # (!\inst_i2c_master|count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|count\(3),
	datad => VCC,
	cin => \inst_i2c_master|Add0~5\,
	combout => \inst_i2c_master|Add0~6_combout\,
	cout => \inst_i2c_master|Add0~7\);

-- Location: LCCOMB_X48_Y45_N0
\inst_i2c_master|count~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~2_combout\ = (\inst_i2c_master|Add0~6_combout\ & !\inst_i2c_master|Equal0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|Add0~6_combout\,
	datad => \inst_i2c_master|Equal0~2_combout\,
	combout => \inst_i2c_master|count~2_combout\);

-- Location: FF_X48_Y45_N7
\inst_i2c_master|count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|count~2_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(3));

-- Location: LCCOMB_X48_Y45_N10
\inst_i2c_master|Add0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~8_combout\ = (\inst_i2c_master|count\(4) & (\inst_i2c_master|Add0~7\ $ (GND))) # (!\inst_i2c_master|count\(4) & (!\inst_i2c_master|Add0~7\ & VCC))
-- \inst_i2c_master|Add0~9\ = CARRY((\inst_i2c_master|count\(4) & !\inst_i2c_master|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|count\(4),
	datad => VCC,
	cin => \inst_i2c_master|Add0~7\,
	combout => \inst_i2c_master|Add0~8_combout\,
	cout => \inst_i2c_master|Add0~9\);

-- Location: LCCOMB_X47_Y45_N24
\inst_i2c_master|count~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~1_combout\ = (\inst_i2c_master|Add0~8_combout\ & !\inst_i2c_master|Equal0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|Add0~8_combout\,
	datad => \inst_i2c_master|Equal0~2_combout\,
	combout => \inst_i2c_master|count~1_combout\);

-- Location: FF_X48_Y45_N3
\inst_i2c_master|count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|count~1_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(4));

-- Location: LCCOMB_X48_Y45_N12
\inst_i2c_master|Add0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~10_combout\ = (\inst_i2c_master|count\(5) & (!\inst_i2c_master|Add0~9\)) # (!\inst_i2c_master|count\(5) & ((\inst_i2c_master|Add0~9\) # (GND)))
-- \inst_i2c_master|Add0~11\ = CARRY((!\inst_i2c_master|Add0~9\) # (!\inst_i2c_master|count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|count\(5),
	datad => VCC,
	cin => \inst_i2c_master|Add0~9\,
	combout => \inst_i2c_master|Add0~10_combout\,
	cout => \inst_i2c_master|Add0~11\);

-- Location: LCCOMB_X48_Y45_N14
\inst_i2c_master|Add0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~12_combout\ = (\inst_i2c_master|count\(6) & (\inst_i2c_master|Add0~11\ $ (GND))) # (!\inst_i2c_master|count\(6) & (!\inst_i2c_master|Add0~11\ & VCC))
-- \inst_i2c_master|Add0~13\ = CARRY((\inst_i2c_master|count\(6) & !\inst_i2c_master|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|count\(6),
	datad => VCC,
	cin => \inst_i2c_master|Add0~11\,
	combout => \inst_i2c_master|Add0~12_combout\,
	cout => \inst_i2c_master|Add0~13\);

-- Location: LCCOMB_X47_Y45_N2
\inst_i2c_master|process_0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~5_combout\ = (\inst_i2c_master|count~1_combout\) # ((\inst_i2c_master|Add0~2_combout\ & (\inst_i2c_master|count~2_combout\ & \inst_i2c_master|count~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~2_combout\,
	datab => \inst_i2c_master|count~1_combout\,
	datac => \inst_i2c_master|count~2_combout\,
	datad => \inst_i2c_master|count~3_combout\,
	combout => \inst_i2c_master|process_0~5_combout\);

-- Location: LCCOMB_X47_Y45_N16
\inst_i2c_master|process_0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~6_combout\ = (\inst_i2c_master|Add0~14_combout\ & (\inst_i2c_master|Add0~12_combout\ & (\inst_i2c_master|Add0~10_combout\ & \inst_i2c_master|process_0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~14_combout\,
	datab => \inst_i2c_master|Add0~12_combout\,
	datac => \inst_i2c_master|Add0~10_combout\,
	datad => \inst_i2c_master|process_0~5_combout\,
	combout => \inst_i2c_master|process_0~6_combout\);

-- Location: FF_X47_Y45_N5
\inst_i2c_master|count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|count~0_combout\,
	clrn => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(9));

-- Location: LCCOMB_X48_Y45_N16
\inst_i2c_master|Add0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~14_combout\ = (\inst_i2c_master|count\(7) & (!\inst_i2c_master|Add0~13\)) # (!\inst_i2c_master|count\(7) & ((\inst_i2c_master|Add0~13\) # (GND)))
-- \inst_i2c_master|Add0~15\ = CARRY((!\inst_i2c_master|Add0~13\) # (!\inst_i2c_master|count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|count\(7),
	datad => VCC,
	cin => \inst_i2c_master|Add0~13\,
	combout => \inst_i2c_master|Add0~14_combout\,
	cout => \inst_i2c_master|Add0~15\);

-- Location: LCCOMB_X47_Y45_N30
\inst_i2c_master|count~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~7_combout\ = (!\inst_i2c_master|Equal0~2_combout\ & \inst_i2c_master|Add0~14_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Equal0~2_combout\,
	datac => \inst_i2c_master|Add0~14_combout\,
	combout => \inst_i2c_master|count~7_combout\);

-- Location: FF_X47_Y45_N31
\inst_i2c_master|count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|count~7_combout\,
	clrn => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(7));

-- Location: LCCOMB_X48_Y45_N18
\inst_i2c_master|Add0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~16_combout\ = (\inst_i2c_master|count\(8) & (\inst_i2c_master|Add0~15\ $ (GND))) # (!\inst_i2c_master|count\(8) & (!\inst_i2c_master|Add0~15\ & VCC))
-- \inst_i2c_master|Add0~17\ = CARRY((\inst_i2c_master|count\(8) & !\inst_i2c_master|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|count\(8),
	datad => VCC,
	cin => \inst_i2c_master|Add0~15\,
	combout => \inst_i2c_master|Add0~16_combout\,
	cout => \inst_i2c_master|Add0~17\);

-- Location: LCCOMB_X49_Y45_N28
\inst_i2c_master|count~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~6_combout\ = (!\inst_i2c_master|Equal0~2_combout\ & \inst_i2c_master|Add0~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|Equal0~2_combout\,
	datad => \inst_i2c_master|Add0~16_combout\,
	combout => \inst_i2c_master|count~6_combout\);

-- Location: FF_X49_Y45_N29
\inst_i2c_master|count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|count~6_combout\,
	clrn => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(8));

-- Location: LCCOMB_X48_Y45_N20
\inst_i2c_master|Add0~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~18_combout\ = \inst_i2c_master|count\(9) $ (\inst_i2c_master|Add0~17\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|count\(9),
	cin => \inst_i2c_master|Add0~17\,
	combout => \inst_i2c_master|Add0~18_combout\);

-- Location: LCCOMB_X47_Y45_N4
\inst_i2c_master|count~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~0_combout\ = (\inst_i2c_master|Add0~18_combout\ & !\inst_i2c_master|Equal0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|Add0~18_combout\,
	datad => \inst_i2c_master|Equal0~2_combout\,
	combout => \inst_i2c_master|count~0_combout\);

-- Location: LCCOMB_X46_Y45_N22
\inst_i2c_master|process_0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~3_combout\ = (!\inst_i2c_master|Add0~10_combout\) # (!\inst_i2c_master|Add0~12_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~12_combout\,
	datad => \inst_i2c_master|Add0~10_combout\,
	combout => \inst_i2c_master|process_0~3_combout\);

-- Location: LCCOMB_X46_Y45_N24
\inst_i2c_master|process_0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~2_combout\ = (\inst_i2c_master|Equal0~2_combout\) # (((!\inst_i2c_master|Add0~6_combout\ & !\inst_i2c_master|Add0~4_combout\)) # (!\inst_i2c_master|Add0~8_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~6_combout\,
	datab => \inst_i2c_master|Equal0~2_combout\,
	datac => \inst_i2c_master|Add0~8_combout\,
	datad => \inst_i2c_master|Add0~4_combout\,
	combout => \inst_i2c_master|process_0~2_combout\);

-- Location: LCCOMB_X46_Y45_N8
\inst_i2c_master|process_0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~4_combout\ = (((\inst_i2c_master|process_0~3_combout\) # (\inst_i2c_master|process_0~2_combout\)) # (!\inst_i2c_master|Add0~14_combout\)) # (!\inst_i2c_master|Add0~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~16_combout\,
	datab => \inst_i2c_master|Add0~14_combout\,
	datac => \inst_i2c_master|process_0~3_combout\,
	datad => \inst_i2c_master|process_0~2_combout\,
	combout => \inst_i2c_master|process_0~4_combout\);

-- Location: LCCOMB_X47_Y45_N18
\inst_i2c_master|stretch~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|stretch~0_combout\ = (\inst_i2c_master|count~0_combout\ & ((\inst_i2c_master|Add0~16_combout\) # ((\inst_i2c_master|process_0~6_combout\)))) # (!\inst_i2c_master|count~0_combout\ & (((\inst_i2c_master|process_0~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~16_combout\,
	datab => \inst_i2c_master|process_0~6_combout\,
	datac => \inst_i2c_master|count~0_combout\,
	datad => \inst_i2c_master|process_0~4_combout\,
	combout => \inst_i2c_master|stretch~0_combout\);

-- Location: LCCOMB_X47_Y45_N22
\inst_i2c_master|stretch~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|stretch~1_combout\ = (\inst_i2c_master|stretch~0_combout\ & ((\inst_i2c_master|stretch~q\))) # (!\inst_i2c_master|stretch~0_combout\ & (!\scl~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \scl~input_o\,
	datac => \inst_i2c_master|stretch~q\,
	datad => \inst_i2c_master|stretch~0_combout\,
	combout => \inst_i2c_master|stretch~1_combout\);

-- Location: FF_X47_Y45_N23
\inst_i2c_master|stretch\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|stretch~1_combout\,
	clrn => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|stretch~q\);

-- Location: LCCOMB_X48_Y45_N2
\inst_i2c_master|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add0~0_combout\ = (\inst_i2c_master|count\(0) & (\inst_i2c_master|stretch~q\ $ (GND))) # (!\inst_i2c_master|count\(0) & (!\inst_i2c_master|stretch~q\ & VCC))
-- \inst_i2c_master|Add0~1\ = CARRY((\inst_i2c_master|count\(0) & !\inst_i2c_master|stretch~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|count\(0),
	datab => \inst_i2c_master|stretch~q\,
	datad => VCC,
	combout => \inst_i2c_master|Add0~0_combout\,
	cout => \inst_i2c_master|Add0~1\);

-- Location: LCCOMB_X48_Y45_N24
\inst_i2c_master|count~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~4_combout\ = (\inst_i2c_master|Add0~2_combout\ & !\inst_i2c_master|Equal0~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|Add0~2_combout\,
	datad => \inst_i2c_master|Equal0~2_combout\,
	combout => \inst_i2c_master|count~4_combout\);

-- Location: FF_X48_Y45_N25
\inst_i2c_master|count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|count~4_combout\,
	clrn => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(1));

-- Location: LCCOMB_X49_Y45_N0
\inst_i2c_master|count~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|count~5_combout\ = (!\inst_i2c_master|Equal0~2_combout\ & \inst_i2c_master|Add0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|Equal0~2_combout\,
	datad => \inst_i2c_master|Add0~0_combout\,
	combout => \inst_i2c_master|count~5_combout\);

-- Location: FF_X48_Y45_N27
\inst_i2c_master|count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|count~5_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|count\(0));

-- Location: LCCOMB_X47_Y45_N20
\inst_i2c_master|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Equal0~0_combout\ = (\inst_i2c_master|count\(7) & (\inst_i2c_master|count\(9) & (\inst_i2c_master|count\(8) & \inst_i2c_master|count\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|count\(7),
	datab => \inst_i2c_master|count\(9),
	datac => \inst_i2c_master|count\(8),
	datad => \inst_i2c_master|count\(6),
	combout => \inst_i2c_master|Equal0~0_combout\);

-- Location: LCCOMB_X47_Y45_N12
\inst_i2c_master|Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Equal0~2_combout\ = (\inst_i2c_master|Equal0~1_combout\ & (\inst_i2c_master|count\(1) & (\inst_i2c_master|count\(0) & \inst_i2c_master|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Equal0~1_combout\,
	datab => \inst_i2c_master|count\(1),
	datac => \inst_i2c_master|count\(0),
	datad => \inst_i2c_master|Equal0~0_combout\,
	combout => \inst_i2c_master|Equal0~2_combout\);

-- Location: LCCOMB_X47_Y45_N14
\inst_i2c_master|process_0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~12_combout\ = (\inst_i2c_master|Equal0~2_combout\) # ((!\inst_i2c_master|Add0~12_combout\) # (!\inst_i2c_master|Add0~6_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Equal0~2_combout\,
	datab => \inst_i2c_master|Add0~6_combout\,
	datad => \inst_i2c_master|Add0~12_combout\,
	combout => \inst_i2c_master|process_0~12_combout\);

-- Location: LCCOMB_X47_Y45_N28
\inst_i2c_master|process_0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~8_combout\ = (((!\inst_i2c_master|Add0~2_combout\ & !\inst_i2c_master|Add0~4_combout\)) # (!\inst_i2c_master|Add0~10_combout\)) # (!\inst_i2c_master|Add0~8_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~2_combout\,
	datab => \inst_i2c_master|Add0~8_combout\,
	datac => \inst_i2c_master|Add0~10_combout\,
	datad => \inst_i2c_master|Add0~4_combout\,
	combout => \inst_i2c_master|process_0~8_combout\);

-- Location: LCCOMB_X47_Y45_N26
\inst_i2c_master|process_0~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~9_combout\ = (!\inst_i2c_master|Add0~16_combout\ & (((\inst_i2c_master|process_0~12_combout\) # (\inst_i2c_master|process_0~8_combout\)) # (!\inst_i2c_master|Add0~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~14_combout\,
	datab => \inst_i2c_master|Add0~16_combout\,
	datac => \inst_i2c_master|process_0~12_combout\,
	datad => \inst_i2c_master|process_0~8_combout\,
	combout => \inst_i2c_master|process_0~9_combout\);

-- Location: LCCOMB_X46_Y45_N2
\inst_i2c_master|process_0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~10_combout\ = (\inst_i2c_master|Add0~12_combout\ & (\inst_i2c_master|Add0~8_combout\ & (\inst_i2c_master|Add0~10_combout\ & \inst_i2c_master|Add0~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~12_combout\,
	datab => \inst_i2c_master|Add0~8_combout\,
	datac => \inst_i2c_master|Add0~10_combout\,
	datad => \inst_i2c_master|Add0~14_combout\,
	combout => \inst_i2c_master|process_0~10_combout\);

-- Location: LCCOMB_X46_Y45_N12
\inst_i2c_master|process_0~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~11_combout\ = (\inst_i2c_master|process_0~10_combout\ & ((\inst_i2c_master|Add0~6_combout\ & ((\inst_i2c_master|Add0~16_combout\))) # (!\inst_i2c_master|Add0~6_combout\ & (\inst_i2c_master|Add0~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~4_combout\,
	datab => \inst_i2c_master|Add0~6_combout\,
	datac => \inst_i2c_master|Add0~16_combout\,
	datad => \inst_i2c_master|process_0~10_combout\,
	combout => \inst_i2c_master|process_0~11_combout\);

-- Location: LCCOMB_X47_Y45_N8
\inst_i2c_master|data_clk~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|data_clk~0_combout\ = (\inst_i2c_master|Add0~18_combout\) # ((!\inst_i2c_master|process_0~9_combout\ & \inst_i2c_master|process_0~11_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~18_combout\,
	datac => \inst_i2c_master|process_0~9_combout\,
	datad => \inst_i2c_master|process_0~11_combout\,
	combout => \inst_i2c_master|data_clk~0_combout\);

-- Location: LCCOMB_X47_Y45_N10
\inst_i2c_master|process_0~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_0~7_combout\ = (\inst_i2c_master|count~0_combout\ & ((\inst_i2c_master|Add0~16_combout\) # ((\inst_i2c_master|process_0~6_combout\)))) # (!\inst_i2c_master|count~0_combout\ & (((\inst_i2c_master|process_0~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Add0~16_combout\,
	datab => \inst_i2c_master|process_0~6_combout\,
	datac => \inst_i2c_master|count~0_combout\,
	datad => \inst_i2c_master|process_0~4_combout\,
	combout => \inst_i2c_master|process_0~7_combout\);

-- Location: LCCOMB_X47_Y45_N0
\inst_i2c_master|data_clk~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|data_clk~1_combout\ = (!\inst_i2c_master|Equal0~2_combout\ & ((\inst_i2c_master|data_clk~0_combout\ & ((!\inst_i2c_master|process_0~7_combout\))) # (!\inst_i2c_master|data_clk~0_combout\ & (!\inst_i2c_master|process_0~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|process_0~9_combout\,
	datab => \inst_i2c_master|Equal0~2_combout\,
	datac => \inst_i2c_master|data_clk~0_combout\,
	datad => \inst_i2c_master|process_0~7_combout\,
	combout => \inst_i2c_master|data_clk~1_combout\);

-- Location: FF_X47_Y45_N1
\inst_i2c_master|data_clk\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|data_clk~1_combout\,
	ena => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|data_clk~q\);

-- Location: FF_X46_Y45_N1
\inst_i2c_master|data_clk_prev\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|data_clk~q\,
	sload => VCC,
	ena => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|data_clk_prev~q\);

-- Location: LCCOMB_X46_Y45_N30
\inst_i2c_master|process_1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|process_1~0_combout\ = (\inst_i2c_master|data_clk~q\ & !\inst_i2c_master|data_clk_prev~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|data_clk~q\,
	datad => \inst_i2c_master|data_clk_prev~q\,
	combout => \inst_i2c_master|process_1~0_combout\);

-- Location: LCCOMB_X50_Y45_N4
\inst_i2c_master|Equal1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Equal1~0_combout\ = (\inst_i2c_master|bit_cnt\(1) & (\inst_i2c_master|bit_cnt\(0) & \inst_i2c_master|bit_cnt\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|bit_cnt\(1),
	datab => \inst_i2c_master|bit_cnt\(0),
	datad => \inst_i2c_master|bit_cnt\(2),
	combout => \inst_i2c_master|Equal1~0_combout\);

-- Location: LCCOMB_X49_Y45_N30
\inst_i2c_master|Selector21~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector21~0_combout\ = (\inst_i2c_master|state.rd~q\ & (((\i2c_ena~q\ & \inst_i2c_master|state.mstr_ack~q\)) # (!\inst_i2c_master|Equal1~0_combout\))) # (!\inst_i2c_master|state.rd~q\ & (\i2c_ena~q\ & 
-- (\inst_i2c_master|state.mstr_ack~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.rd~q\,
	datab => \i2c_ena~q\,
	datac => \inst_i2c_master|state.mstr_ack~q\,
	datad => \inst_i2c_master|Equal1~0_combout\,
	combout => \inst_i2c_master|Selector21~0_combout\);

-- Location: FF_X48_Y45_N19
\inst_i2c_master|state.rd\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Selector21~0_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.rd~q\);

-- Location: LCCOMB_X50_Y45_N28
\inst_i2c_master|state~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|state~13_combout\ = (\inst_i2c_master|bit_cnt\(1) & (\inst_i2c_master|bit_cnt\(0) & (\inst_i2c_master|bit_cnt\(2) & \inst_i2c_master|state.wr~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|bit_cnt\(1),
	datab => \inst_i2c_master|bit_cnt\(0),
	datac => \inst_i2c_master|bit_cnt\(2),
	datad => \inst_i2c_master|state.wr~q\,
	combout => \inst_i2c_master|state~13_combout\);

-- Location: FF_X49_Y45_N7
\inst_i2c_master|state.slv_ack2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|state~13_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.slv_ack2~q\);

-- Location: LCCOMB_X50_Y45_N14
\inst_i2c_master|Selector20~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector20~0_combout\ = (\inst_i2c_master|state.slv_ack2~q\ & \i2c_ena~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|state.slv_ack2~q\,
	datad => \i2c_ena~q\,
	combout => \inst_i2c_master|Selector20~0_combout\);

-- Location: LCCOMB_X50_Y45_N20
\inst_i2c_master|Selector20~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector20~1_combout\ = (\inst_i2c_master|state.slv_ack1~q\) # ((\inst_i2c_master|Selector20~0_combout\) # ((!\inst_i2c_master|Equal1~0_combout\ & \inst_i2c_master|state.wr~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.slv_ack1~q\,
	datab => \inst_i2c_master|Equal1~0_combout\,
	datac => \inst_i2c_master|Selector20~0_combout\,
	datad => \inst_i2c_master|state.wr~q\,
	combout => \inst_i2c_master|Selector20~1_combout\);

-- Location: FF_X49_Y45_N19
\inst_i2c_master|state.wr\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Selector20~1_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.wr~q\);

-- Location: LCCOMB_X49_Y45_N16
\inst_i2c_master|bit_cnt[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|bit_cnt[2]~0_combout\ = (\inst_i2c_master|process_1~0_combout\ & ((\inst_i2c_master|state.command~q\) # ((\inst_i2c_master|state.rd~q\) # (\inst_i2c_master|state.wr~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.command~q\,
	datab => \inst_i2c_master|process_1~0_combout\,
	datac => \inst_i2c_master|state.rd~q\,
	datad => \inst_i2c_master|state.wr~q\,
	combout => \inst_i2c_master|bit_cnt[2]~0_combout\);

-- Location: FF_X50_Y45_N19
\inst_i2c_master|bit_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|bit_cnt[0]~1_combout\,
	clrn => \reset_n~q\,
	ena => \inst_i2c_master|bit_cnt[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|bit_cnt\(0));

-- Location: LCCOMB_X50_Y45_N26
\inst_i2c_master|Selector25~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector25~0_combout\ = \inst_i2c_master|bit_cnt\(1) $ (\inst_i2c_master|bit_cnt\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|bit_cnt\(1),
	datad => \inst_i2c_master|bit_cnt\(0),
	combout => \inst_i2c_master|Selector25~0_combout\);

-- Location: FF_X50_Y45_N25
\inst_i2c_master|bit_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Selector25~0_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|bit_cnt[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|bit_cnt\(1));

-- Location: LCCOMB_X50_Y45_N8
\inst_i2c_master|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Add1~0_combout\ = \inst_i2c_master|bit_cnt\(2) $ (((\inst_i2c_master|bit_cnt\(0) & \inst_i2c_master|bit_cnt\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|bit_cnt\(0),
	datac => \inst_i2c_master|bit_cnt\(1),
	datad => \inst_i2c_master|bit_cnt\(2),
	combout => \inst_i2c_master|Add1~0_combout\);

-- Location: FF_X50_Y45_N29
\inst_i2c_master|bit_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Add1~0_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|bit_cnt[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|bit_cnt\(2));

-- Location: LCCOMB_X49_Y45_N10
\inst_i2c_master|state~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|state~14_combout\ = (\inst_i2c_master|state.rd~q\ & (\inst_i2c_master|bit_cnt\(2) & (\inst_i2c_master|bit_cnt\(0) & \inst_i2c_master|bit_cnt\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.rd~q\,
	datab => \inst_i2c_master|bit_cnt\(2),
	datac => \inst_i2c_master|bit_cnt\(0),
	datad => \inst_i2c_master|bit_cnt\(1),
	combout => \inst_i2c_master|state~14_combout\);

-- Location: FF_X48_Y45_N15
\inst_i2c_master|state.mstr_ack\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|state~14_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.mstr_ack~q\);

-- Location: LCCOMB_X49_Y45_N6
\inst_i2c_master|Selector0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector0~1_combout\ = (\i2c_ena~q\) # ((\inst_i2c_master|state.ready~q\ & (!\inst_i2c_master|state.mstr_ack~q\ & !\inst_i2c_master|state.slv_ack2~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.ready~q\,
	datab => \inst_i2c_master|state.mstr_ack~q\,
	datac => \inst_i2c_master|state.slv_ack2~q\,
	datad => \i2c_ena~q\,
	combout => \inst_i2c_master|Selector0~1_combout\);

-- Location: LCCOMB_X49_Y45_N26
\inst_i2c_master|state~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|state~15_combout\ = (\inst_i2c_master|state.command~q\ & (\inst_i2c_master|bit_cnt\(1) & (\inst_i2c_master|bit_cnt\(0) & \inst_i2c_master|bit_cnt\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.command~q\,
	datab => \inst_i2c_master|bit_cnt\(1),
	datac => \inst_i2c_master|bit_cnt\(0),
	datad => \inst_i2c_master|bit_cnt\(2),
	combout => \inst_i2c_master|state~15_combout\);

-- Location: FF_X48_Y45_N5
\inst_i2c_master|state.slv_ack1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|state~15_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.slv_ack1~q\);

-- Location: LCCOMB_X49_Y45_N22
\inst_i2c_master|Selector22~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector22~0_combout\ = (!\i2c_ena~q\ & ((\inst_i2c_master|state.mstr_ack~q\) # (\inst_i2c_master|state.slv_ack2~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \i2c_ena~q\,
	datac => \inst_i2c_master|state.mstr_ack~q\,
	datad => \inst_i2c_master|state.slv_ack2~q\,
	combout => \inst_i2c_master|Selector22~0_combout\);

-- Location: FF_X48_Y45_N9
\inst_i2c_master|state.stop\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Selector22~0_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.stop~q\);

-- Location: LCCOMB_X49_Y45_N8
\inst_i2c_master|Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector0~0_combout\ = ((!\inst_i2c_master|state.command~q\ & (!\inst_i2c_master|state.slv_ack1~q\ & !\inst_i2c_master|state.stop~q\))) # (!\inst_i2c_master|busy~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.command~q\,
	datab => \inst_i2c_master|state.slv_ack1~q\,
	datac => \inst_i2c_master|busy~q\,
	datad => \inst_i2c_master|state.stop~q\,
	combout => \inst_i2c_master|Selector0~0_combout\);

-- Location: LCCOMB_X49_Y45_N14
\inst_i2c_master|Selector0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector0~2_combout\ = (\inst_i2c_master|state~13_combout\) # (((\inst_i2c_master|state~14_combout\) # (!\inst_i2c_master|Selector0~0_combout\)) # (!\inst_i2c_master|Selector0~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state~13_combout\,
	datab => \inst_i2c_master|Selector0~1_combout\,
	datac => \inst_i2c_master|Selector0~0_combout\,
	datad => \inst_i2c_master|state~14_combout\,
	combout => \inst_i2c_master|Selector0~2_combout\);

-- Location: FF_X48_Y45_N17
\inst_i2c_master|busy\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Selector0~2_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|busy~q\);

-- Location: LCCOMB_X54_Y45_N0
\Selector2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = (\LessThan0~0_combout\ & (((\state.repeat~q\ & !\inst_i2c_master|busy~q\)))) # (!\LessThan0~0_combout\ & ((\state.write_data~q\) # ((\state.repeat~q\ & !\inst_i2c_master|busy~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010011110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LessThan0~0_combout\,
	datab => \state.write_data~q\,
	datac => \state.repeat~q\,
	datad => \inst_i2c_master|busy~q\,
	combout => \Selector2~0_combout\);

-- Location: FF_X54_Y45_N1
\state.repeat\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.repeat~q\);

-- Location: LCCOMB_X54_Y45_N30
\Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = (\inst_i2c_master|busy~q\ & (!\state.repeat~q\ & ((\state.start~q\) # (\Equal0~6_combout\)))) # (!\inst_i2c_master|busy~q\ & (((\state.start~q\) # (\Equal0~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011101110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|busy~q\,
	datab => \state.repeat~q\,
	datac => \state.start~q\,
	datad => \Equal0~6_combout\,
	combout => \Selector0~0_combout\);

-- Location: FF_X54_Y45_N31
\state.start\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.start~q\);

-- Location: LCCOMB_X54_Y45_N24
\Selector1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = (\LessThan0~0_combout\ & ((\state.write_data~q\) # ((!\state.start~q\ & \Equal0~6_combout\)))) # (!\LessThan0~0_combout\ & (!\state.start~q\ & ((\Equal0~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LessThan0~0_combout\,
	datab => \state.start~q\,
	datac => \state.write_data~q\,
	datad => \Equal0~6_combout\,
	combout => \Selector1~0_combout\);

-- Location: FF_X54_Y45_N25
\state.write_data\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \state.write_data~q\);

-- Location: LCCOMB_X49_Y45_N24
\Selector3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = (\state.start~q\ & (\state.write_data~q\ & (\i2c_ena~q\))) # (!\state.start~q\ & ((\Equal0~6_combout\) # ((\state.write_data~q\ & \i2c_ena~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.start~q\,
	datab => \state.write_data~q\,
	datac => \i2c_ena~q\,
	datad => \Equal0~6_combout\,
	combout => \Selector3~0_combout\);

-- Location: FF_X49_Y45_N25
i2c_ena : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \i2c_ena~q\);

-- Location: LCCOMB_X46_Y45_N26
\inst_i2c_master|Selector17~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector17~0_combout\ = (!\inst_i2c_master|state.stop~q\ & ((\inst_i2c_master|state.ready~q\) # (\i2c_ena~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.stop~q\,
	datac => \inst_i2c_master|state.ready~q\,
	datad => \i2c_ena~q\,
	combout => \inst_i2c_master|Selector17~0_combout\);

-- Location: FF_X48_Y45_N11
\inst_i2c_master|state.ready\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Selector17~0_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.ready~q\);

-- Location: LCCOMB_X46_Y45_N4
\inst_i2c_master|Selector18~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector18~0_combout\ = (!\inst_i2c_master|state.ready~q\ & \i2c_ena~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|state.ready~q\,
	datad => \i2c_ena~q\,
	combout => \inst_i2c_master|Selector18~0_combout\);

-- Location: FF_X48_Y45_N21
\inst_i2c_master|state.start\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|Selector18~0_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|state.start~q\);

-- Location: LCCOMB_X54_Y45_N22
\busy_prev~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \busy_prev~0_combout\ = !\inst_i2c_master|busy~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst_i2c_master|busy~q\,
	combout => \busy_prev~0_combout\);

-- Location: FF_X54_Y45_N23
busy_prev : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \busy_prev~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \busy_prev~q\);

-- Location: LCCOMB_X54_Y45_N20
\byteSel~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \byteSel~0_combout\ = (\busy_prev~q\ & \inst_i2c_master|busy~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \busy_prev~q\,
	datad => \inst_i2c_master|busy~q\,
	combout => \byteSel~0_combout\);

-- Location: LCCOMB_X54_Y45_N18
\Selector7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~0_combout\ = (\state.write_data~q\ & (byteSel(0) $ (((\LessThan0~0_combout\ & \byteSel~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LessThan0~0_combout\,
	datab => \state.write_data~q\,
	datac => byteSel(0),
	datad => \byteSel~0_combout\,
	combout => \Selector7~0_combout\);

-- Location: LCCOMB_X54_Y45_N12
\Selector7~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~1_combout\ = (\Selector7~0_combout\) # ((byteSel(0) & !\state.start~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(0),
	datac => \state.start~q\,
	datad => \Selector7~0_combout\,
	combout => \Selector7~1_combout\);

-- Location: FF_X53_Y45_N27
\byteSel[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Selector7~1_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => byteSel(0));

-- Location: LCCOMB_X54_Y45_N10
\Selector5~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~3_combout\ = (\LessThan0~0_combout\ & (\state.write_data~q\ & (\busy_prev~q\ & \inst_i2c_master|busy~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LessThan0~0_combout\,
	datab => \state.write_data~q\,
	datac => \busy_prev~q\,
	datad => \inst_i2c_master|busy~q\,
	combout => \Selector5~3_combout\);

-- Location: LCCOMB_X53_Y45_N4
\Selector6~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector6~1_combout\ = (byteSel(1) & ((\Selector6~0_combout\) # ((!byteSel(0) & \Selector5~3_combout\)))) # (!byteSel(1) & (byteSel(0) & (\Selector5~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(0),
	datab => \Selector5~3_combout\,
	datac => byteSel(1),
	datad => \Selector6~0_combout\,
	combout => \Selector6~1_combout\);

-- Location: FF_X53_Y45_N5
\byteSel[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector6~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => byteSel(1));

-- Location: LCCOMB_X53_Y45_N6
\Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Add1~0_combout\ = (byteSel(0) & byteSel(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(0),
	datab => byteSel(1),
	combout => \Add1~0_combout\);

-- Location: LCCOMB_X54_Y45_N2
\Selector4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector4~0_combout\ = (byteSel(2) & (\state.write_data~q\ & (\Add1~0_combout\ & \byteSel~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(2),
	datab => \state.write_data~q\,
	datac => \Add1~0_combout\,
	datad => \byteSel~0_combout\,
	combout => \Selector4~0_combout\);

-- Location: LCCOMB_X54_Y45_N16
\Selector4~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector4~1_combout\ = (\Selector4~0_combout\) # ((byteSel(3) & ((\state.write_data~q\) # (!\state.start~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.start~q\,
	datab => \state.write_data~q\,
	datac => byteSel(3),
	datad => \Selector4~0_combout\,
	combout => \Selector4~1_combout\);

-- Location: FF_X54_Y45_N17
\byteSel[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector4~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => byteSel(3));

-- Location: LCCOMB_X54_Y45_N26
\LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \LessThan0~0_combout\ = (((!byteSel(0) & !byteSel(1))) # (!byteSel(3))) # (!byteSel(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(0),
	datab => byteSel(2),
	datac => byteSel(1),
	datad => byteSel(3),
	combout => \LessThan0~0_combout\);

-- Location: LCCOMB_X54_Y45_N28
\Selector6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = ((\state.write_data~q\ & ((!\byteSel~0_combout\) # (!\LessThan0~0_combout\)))) # (!\state.start~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101110111011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \state.start~q\,
	datab => \state.write_data~q\,
	datac => \LessThan0~0_combout\,
	datad => \byteSel~0_combout\,
	combout => \Selector6~0_combout\);

-- Location: LCCOMB_X53_Y45_N10
\Selector5~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~2_combout\ = (byteSel(2) & ((\Selector6~0_combout\) # ((!\Add1~0_combout\ & \Selector5~3_combout\)))) # (!byteSel(2) & (\Add1~0_combout\ & (\Selector5~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add1~0_combout\,
	datab => \Selector5~3_combout\,
	datac => byteSel(2),
	datad => \Selector6~0_combout\,
	combout => \Selector5~2_combout\);

-- Location: FF_X53_Y45_N11
\byteSel[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Selector5~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => byteSel(2));

-- Location: LCCOMB_X52_Y45_N10
\Mux1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = (!byteSel(3) & (((byteSel(0)) # (!byteSel(2))) # (!byteSel(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(1),
	datab => byteSel(0),
	datac => byteSel(2),
	datad => byteSel(3),
	combout => \Mux1~0_combout\);

-- Location: LCCOMB_X49_Y45_N20
\inst_i2c_master|data_tx[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|data_tx[0]~2_combout\ = (\i2c_ena~q\ & ((\inst_i2c_master|state.slv_ack2~q\) # ((\inst_i2c_master|state.mstr_ack~q\) # (!\inst_i2c_master|state.ready~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.slv_ack2~q\,
	datab => \i2c_ena~q\,
	datac => \inst_i2c_master|state.mstr_ack~q\,
	datad => \inst_i2c_master|state.ready~q\,
	combout => \inst_i2c_master|data_tx[0]~2_combout\);

-- Location: LCCOMB_X50_Y45_N6
\inst_i2c_master|data_tx[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|data_tx[0]~3_combout\ = (!\inst_i2c_master|data_clk_prev~q\ & (\inst_i2c_master|data_tx[0]~2_combout\ & (\inst_i2c_master|data_clk~q\ & \reset_n~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|data_clk_prev~q\,
	datab => \inst_i2c_master|data_tx[0]~2_combout\,
	datac => \inst_i2c_master|data_clk~q\,
	datad => \reset_n~q\,
	combout => \inst_i2c_master|data_tx[0]~3_combout\);

-- Location: FF_X50_Y45_N15
\inst_i2c_master|data_tx[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Mux1~0_combout\,
	sload => VCC,
	ena => \inst_i2c_master|data_tx[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|data_tx\(6));

-- Location: LCCOMB_X52_Y45_N8
\Mux5~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux5~2_combout\ = (!byteSel(2) & !byteSel(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => byteSel(2),
	datad => byteSel(0),
	combout => \Mux5~2_combout\);

-- Location: IOIBUF_X52_Y0_N22
\iData[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(6),
	o => \iData[6]~input_o\);

-- Location: IOIBUF_X58_Y73_N1
\iData[14]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(14),
	o => \iData[14]~input_o\);

-- Location: LCCOMB_X53_Y45_N14
\Mux4~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~2_combout\ = (byteSel(2)) # ((byteSel(1) & byteSel(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => byteSel(1),
	datac => byteSel(0),
	datad => byteSel(2),
	combout => \Mux4~2_combout\);

-- Location: LCCOMB_X53_Y45_N12
\Mux4~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~1_combout\ = (byteSel(2)) # ((byteSel(0) & !byteSel(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(0),
	datac => byteSel(1),
	datad => byteSel(2),
	combout => \Mux4~1_combout\);

-- Location: LCCOMB_X53_Y45_N0
\Mux5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux5~0_combout\ = (\Mux4~2_combout\ & ((\iData[2]~input_o\) # ((!\Mux4~1_combout\)))) # (!\Mux4~2_combout\ & (((\iData[14]~input_o\ & \Mux4~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iData[2]~input_o\,
	datab => \iData[14]~input_o\,
	datac => \Mux4~2_combout\,
	datad => \Mux4~1_combout\,
	combout => \Mux5~0_combout\);

-- Location: LCCOMB_X53_Y45_N24
\Mux4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = (byteSel(1) & !byteSel(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => byteSel(1),
	datad => byteSel(2),
	combout => \Mux4~0_combout\);

-- Location: LCCOMB_X52_Y45_N14
\Mux5~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux5~1_combout\ = (\Mux5~0_combout\ & (((\iData[6]~input_o\) # (!\Mux4~0_combout\)))) # (!\Mux5~0_combout\ & (\iData[10]~input_o\ & ((\Mux4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iData[10]~input_o\,
	datab => \iData[6]~input_o\,
	datac => \Mux5~0_combout\,
	datad => \Mux4~0_combout\,
	combout => \Mux5~1_combout\);

-- Location: LCCOMB_X52_Y45_N30
\Mux5~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux5~3_combout\ = (byteSel(3) & (((\Mux5~1_combout\)))) # (!byteSel(3) & (((\Mux5~2_combout\)) # (!byteSel(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(1),
	datab => \Mux5~2_combout\,
	datac => \Mux5~1_combout\,
	datad => byteSel(3),
	combout => \Mux5~3_combout\);

-- Location: FF_X52_Y45_N31
\inst_i2c_master|data_tx[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \Mux5~3_combout\,
	ena => \inst_i2c_master|data_tx[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|data_tx\(2));

-- Location: LCCOMB_X53_Y45_N26
\Mux4~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~3_combout\ = (!byteSel(3) & ((byteSel(1) & (byteSel(0))) # (!byteSel(1) & (!byteSel(0) & byteSel(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(3),
	datab => byteSel(1),
	datac => byteSel(0),
	datad => byteSel(2),
	combout => \Mux4~3_combout\);

-- Location: IOIBUF_X115_Y45_N15
\iData[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(7),
	o => \iData[7]~input_o\);

-- Location: IOIBUF_X52_Y0_N15
\iData[15]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(15),
	o => \iData[15]~input_o\);

-- Location: LCCOMB_X53_Y45_N20
\Mux4~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~4_combout\ = (\Mux4~2_combout\ & ((\iData[3]~input_o\) # ((!\Mux4~1_combout\)))) # (!\Mux4~2_combout\ & (((\iData[15]~input_o\ & \Mux4~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iData[3]~input_o\,
	datab => \iData[15]~input_o\,
	datac => \Mux4~2_combout\,
	datad => \Mux4~1_combout\,
	combout => \Mux4~4_combout\);

-- Location: LCCOMB_X53_Y45_N18
\Mux4~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~5_combout\ = (\Mux4~0_combout\ & ((\Mux4~4_combout\ & ((\iData[7]~input_o\))) # (!\Mux4~4_combout\ & (\iData[11]~input_o\)))) # (!\Mux4~0_combout\ & (((\Mux4~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iData[11]~input_o\,
	datab => \Mux4~0_combout\,
	datac => \iData[7]~input_o\,
	datad => \Mux4~4_combout\,
	combout => \Mux4~5_combout\);

-- Location: LCCOMB_X53_Y45_N8
\Mux4~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~6_combout\ = (\Mux4~3_combout\) # ((byteSel(3) & \Mux4~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(3),
	datac => \Mux4~3_combout\,
	datad => \Mux4~5_combout\,
	combout => \Mux4~6_combout\);

-- Location: FF_X53_Y45_N7
\inst_i2c_master|data_tx[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Mux4~6_combout\,
	sload => VCC,
	ena => \inst_i2c_master|data_tx[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|data_tx\(3));

-- Location: LCCOMB_X50_Y45_N30
\inst_i2c_master|Mux2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux2~0_combout\ = (\inst_i2c_master|bit_cnt\(0) & (\inst_i2c_master|data_tx\(2))) # (!\inst_i2c_master|bit_cnt\(0) & ((\inst_i2c_master|data_tx\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|bit_cnt\(0),
	datac => \inst_i2c_master|data_tx\(2),
	datad => \inst_i2c_master|data_tx\(3),
	combout => \inst_i2c_master|Mux2~0_combout\);

-- Location: IOIBUF_X58_Y73_N8
\iData[9]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(9),
	o => \iData[9]~input_o\);

-- Location: IOIBUF_X52_Y0_N1
\iData[13]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(13),
	o => \iData[13]~input_o\);

-- Location: LCCOMB_X53_Y45_N22
\Mux6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux6~0_combout\ = (\Mux4~2_combout\ & ((\iData[1]~input_o\) # ((!\Mux4~1_combout\)))) # (!\Mux4~2_combout\ & (((\iData[13]~input_o\ & \Mux4~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iData[1]~input_o\,
	datab => \iData[13]~input_o\,
	datac => \Mux4~2_combout\,
	datad => \Mux4~1_combout\,
	combout => \Mux6~0_combout\);

-- Location: LCCOMB_X53_Y45_N28
\Mux6~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux6~1_combout\ = (\Mux6~0_combout\ & ((\iData[5]~input_o\) # ((!\Mux4~0_combout\)))) # (!\Mux6~0_combout\ & (((\iData[9]~input_o\ & \Mux4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iData[5]~input_o\,
	datab => \iData[9]~input_o\,
	datac => \Mux6~0_combout\,
	datad => \Mux4~0_combout\,
	combout => \Mux6~1_combout\);

-- Location: LCCOMB_X53_Y45_N2
\Mux6~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux6~2_combout\ = (byteSel(3) & (((\Mux6~1_combout\)))) # (!byteSel(3) & (((!byteSel(1))) # (!byteSel(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(2),
	datab => byteSel(1),
	datac => byteSel(3),
	datad => \Mux6~1_combout\,
	combout => \Mux6~2_combout\);

-- Location: FF_X52_Y45_N21
\inst_i2c_master|data_tx[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Mux6~2_combout\,
	sload => VCC,
	ena => \inst_i2c_master|data_tx[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|data_tx\(1));

-- Location: LCCOMB_X52_Y45_N20
\inst_i2c_master|Mux2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux2~1_combout\ = (\inst_i2c_master|bit_cnt\(0) & (\inst_i2c_master|data_tx\(0))) # (!\inst_i2c_master|bit_cnt\(0) & ((\inst_i2c_master|data_tx\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|data_tx\(0),
	datac => \inst_i2c_master|data_tx\(1),
	datad => \inst_i2c_master|bit_cnt\(0),
	combout => \inst_i2c_master|Mux2~1_combout\);

-- Location: LCCOMB_X52_Y45_N18
\inst_i2c_master|Mux2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux2~2_combout\ = (\inst_i2c_master|bit_cnt\(1) & (\inst_i2c_master|bit_cnt\(2) & ((\inst_i2c_master|Mux2~1_combout\)))) # (!\inst_i2c_master|bit_cnt\(1) & (((\inst_i2c_master|Mux2~0_combout\)) # (!\inst_i2c_master|bit_cnt\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100101010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|bit_cnt\(1),
	datab => \inst_i2c_master|bit_cnt\(2),
	datac => \inst_i2c_master|Mux2~0_combout\,
	datad => \inst_i2c_master|Mux2~1_combout\,
	combout => \inst_i2c_master|Mux2~2_combout\);

-- Location: LCCOMB_X52_Y45_N24
\inst_i2c_master|Mux2~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux2~4_combout\ = (\inst_i2c_master|bit_cnt\(2) & (((\inst_i2c_master|Mux2~2_combout\)))) # (!\inst_i2c_master|bit_cnt\(2) & ((\inst_i2c_master|Mux2~2_combout\ & (\inst_i2c_master|Mux2~3_combout\)) # (!\inst_i2c_master|Mux2~2_combout\ & 
-- ((\inst_i2c_master|data_tx\(6))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Mux2~3_combout\,
	datab => \inst_i2c_master|bit_cnt\(2),
	datac => \inst_i2c_master|data_tx\(6),
	datad => \inst_i2c_master|Mux2~2_combout\,
	combout => \inst_i2c_master|Mux2~4_combout\);

-- Location: LCCOMB_X50_Y45_N24
\inst_i2c_master|Selector23~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~3_combout\ = ((\inst_i2c_master|bit_cnt\(1) & (!\inst_i2c_master|bit_cnt\(0))) # (!\inst_i2c_master|bit_cnt\(1) & ((!\inst_i2c_master|bit_cnt\(2))))) # (!\inst_i2c_master|state.start~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|bit_cnt\(0),
	datab => \inst_i2c_master|bit_cnt\(2),
	datac => \inst_i2c_master|bit_cnt\(1),
	datad => \inst_i2c_master|state.start~q\,
	combout => \inst_i2c_master|Selector23~3_combout\);

-- Location: LCCOMB_X49_Y45_N2
\inst_i2c_master|Selector23~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~4_combout\ = ((\inst_i2c_master|bit_cnt\(2) & ((\inst_i2c_master|bit_cnt\(0)))) # (!\inst_i2c_master|bit_cnt\(2) & (!\inst_i2c_master|bit_cnt\(1)))) # (!\inst_i2c_master|state.command~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.command~q\,
	datab => \inst_i2c_master|bit_cnt\(1),
	datac => \inst_i2c_master|bit_cnt\(0),
	datad => \inst_i2c_master|bit_cnt\(2),
	combout => \inst_i2c_master|Selector23~4_combout\);

-- Location: LCCOMB_X49_Y45_N4
\inst_i2c_master|Selector23~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~5_combout\ = (\inst_i2c_master|Selector23~4_combout\ & (((!\inst_i2c_master|state.stop~q\ & \inst_i2c_master|state.ready~q\)) # (!\inst_i2c_master|sda_int~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.stop~q\,
	datab => \inst_i2c_master|Selector23~4_combout\,
	datac => \inst_i2c_master|sda_int~q\,
	datad => \inst_i2c_master|state.ready~q\,
	combout => \inst_i2c_master|Selector23~5_combout\);

-- Location: LCCOMB_X52_Y45_N4
\Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = (!byteSel(1) & (!byteSel(0) & (byteSel(2) & !byteSel(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(1),
	datab => byteSel(0),
	datac => byteSel(2),
	datad => byteSel(3),
	combout => \Mux0~0_combout\);

-- Location: FF_X50_Y45_N17
\inst_i2c_master|data_tx[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \Mux0~0_combout\,
	sload => VCC,
	ena => \inst_i2c_master|data_tx[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|data_tx\(7));

-- Location: LCCOMB_X50_Y45_N2
\inst_i2c_master|Mux3~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux3~3_combout\ = (\inst_i2c_master|Selector25~0_combout\ & (((\inst_i2c_master|Add1~0_combout\)))) # (!\inst_i2c_master|Selector25~0_combout\ & ((\inst_i2c_master|Add1~0_combout\ & ((\inst_i2c_master|data_tx\(3)))) # 
-- (!\inst_i2c_master|Add1~0_combout\ & (\inst_i2c_master|data_tx\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Selector25~0_combout\,
	datab => \inst_i2c_master|data_tx\(7),
	datac => \inst_i2c_master|Add1~0_combout\,
	datad => \inst_i2c_master|data_tx\(3),
	combout => \inst_i2c_master|Mux3~3_combout\);

-- Location: LCCOMB_X50_Y45_N22
\inst_i2c_master|Mux3~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux3~2_combout\ = (\inst_i2c_master|Add1~0_combout\ & (\inst_i2c_master|data_tx\(2))) # (!\inst_i2c_master|Add1~0_combout\ & ((\inst_i2c_master|data_tx\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|Add1~0_combout\,
	datac => \inst_i2c_master|data_tx\(2),
	datad => \inst_i2c_master|data_tx\(6),
	combout => \inst_i2c_master|Mux3~2_combout\);

-- Location: LCCOMB_X52_Y45_N22
\inst_i2c_master|Mux3~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux3~5_combout\ = (\inst_i2c_master|bit_cnt\(1) & ((\inst_i2c_master|data_tx\(0)) # ((\inst_i2c_master|bit_cnt\(0))))) # (!\inst_i2c_master|bit_cnt\(1) & (((\inst_i2c_master|data_tx\(1) & \inst_i2c_master|bit_cnt\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|data_tx\(0),
	datab => \inst_i2c_master|data_tx\(1),
	datac => \inst_i2c_master|bit_cnt\(1),
	datad => \inst_i2c_master|bit_cnt\(0),
	combout => \inst_i2c_master|Mux3~5_combout\);

-- Location: LCCOMB_X50_Y45_N12
\inst_i2c_master|Mux3~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux3~4_combout\ = (\inst_i2c_master|Selector25~0_combout\ & ((\inst_i2c_master|Mux3~3_combout\ & ((\inst_i2c_master|Mux3~5_combout\))) # (!\inst_i2c_master|Mux3~3_combout\ & (\inst_i2c_master|Mux3~2_combout\)))) # 
-- (!\inst_i2c_master|Selector25~0_combout\ & ((\inst_i2c_master|Mux3~5_combout\ & (\inst_i2c_master|Mux3~3_combout\)) # (!\inst_i2c_master|Mux3~5_combout\ & ((\inst_i2c_master|Mux3~2_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Selector25~0_combout\,
	datab => \inst_i2c_master|Mux3~3_combout\,
	datac => \inst_i2c_master|Mux3~2_combout\,
	datad => \inst_i2c_master|Mux3~5_combout\,
	combout => \inst_i2c_master|Mux3~4_combout\);

-- Location: LCCOMB_X50_Y45_N10
\inst_i2c_master|Selector23~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~6_combout\ = (\inst_i2c_master|Selector23~5_combout\ & ((\inst_i2c_master|Equal1~0_combout\) # ((\inst_i2c_master|Mux3~4_combout\) # (!\inst_i2c_master|state.wr~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Equal1~0_combout\,
	datab => \inst_i2c_master|state.wr~q\,
	datac => \inst_i2c_master|Selector23~5_combout\,
	datad => \inst_i2c_master|Mux3~4_combout\,
	combout => \inst_i2c_master|Selector23~6_combout\);

-- Location: LCCOMB_X50_Y45_N0
\inst_i2c_master|Selector23~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~7_combout\ = (\inst_i2c_master|Selector23~2_combout\ & (\inst_i2c_master|Selector23~3_combout\ & \inst_i2c_master|Selector23~6_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Selector23~2_combout\,
	datab => \inst_i2c_master|Selector23~3_combout\,
	datad => \inst_i2c_master|Selector23~6_combout\,
	combout => \inst_i2c_master|Selector23~7_combout\);

-- Location: IOIBUF_X0_Y45_N15
\iData[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(4),
	o => \iData[4]~input_o\);

-- Location: IOIBUF_X54_Y73_N8
\iData[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(0),
	o => \iData[0]~input_o\);

-- Location: LCCOMB_X53_Y45_N16
\Mux7~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux7~1_combout\ = (\Mux4~2_combout\ & (((\iData[0]~input_o\) # (!\Mux4~1_combout\)))) # (!\Mux4~2_combout\ & (\iData[12]~input_o\ & ((\Mux4~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iData[12]~input_o\,
	datab => \iData[0]~input_o\,
	datac => \Mux4~2_combout\,
	datad => \Mux4~1_combout\,
	combout => \Mux7~1_combout\);

-- Location: LCCOMB_X53_Y45_N30
\Mux7~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux7~2_combout\ = (\Mux4~0_combout\ & ((\Mux7~1_combout\ & ((\iData[4]~input_o\))) # (!\Mux7~1_combout\ & (\iData[8]~input_o\)))) # (!\Mux4~0_combout\ & (((\Mux7~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iData[8]~input_o\,
	datab => \Mux4~0_combout\,
	datac => \iData[4]~input_o\,
	datad => \Mux7~1_combout\,
	combout => \Mux7~2_combout\);

-- Location: LCCOMB_X52_Y45_N28
\Mux7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux7~0_combout\ = (byteSel(2) & (!byteSel(3) & ((byteSel(0)) # (!byteSel(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(1),
	datab => byteSel(0),
	datac => byteSel(2),
	datad => byteSel(3),
	combout => \Mux7~0_combout\);

-- Location: LCCOMB_X52_Y45_N26
\Mux7~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux7~3_combout\ = (\Mux7~0_combout\) # ((byteSel(3) & \Mux7~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => byteSel(3),
	datac => \Mux7~2_combout\,
	datad => \Mux7~0_combout\,
	combout => \Mux7~3_combout\);

-- Location: LCCOMB_X52_Y45_N16
\inst_i2c_master|Mux4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux4~0_combout\ = (\inst_i2c_master|bit_cnt\(1) & ((\inst_i2c_master|bit_cnt\(0) & (\Mux7~3_combout\)) # (!\inst_i2c_master|bit_cnt\(0) & ((\Mux6~2_combout\))))) # (!\inst_i2c_master|bit_cnt\(1) & (!\inst_i2c_master|bit_cnt\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|bit_cnt\(1),
	datab => \inst_i2c_master|bit_cnt\(0),
	datac => \Mux7~3_combout\,
	datad => \Mux6~2_combout\,
	combout => \inst_i2c_master|Mux4~0_combout\);

-- Location: LCCOMB_X52_Y45_N6
\inst_i2c_master|Mux4~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Mux4~1_combout\ = (\inst_i2c_master|bit_cnt\(1) & (((\inst_i2c_master|Mux4~0_combout\)))) # (!\inst_i2c_master|bit_cnt\(1) & ((\inst_i2c_master|Mux4~0_combout\ & (\Mux4~6_combout\)) # (!\inst_i2c_master|Mux4~0_combout\ & 
-- ((\Mux5~3_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|bit_cnt\(1),
	datab => \Mux4~6_combout\,
	datac => \Mux5~3_combout\,
	datad => \inst_i2c_master|Mux4~0_combout\,
	combout => \inst_i2c_master|Mux4~1_combout\);

-- Location: LCCOMB_X52_Y45_N2
\inst_i2c_master|Selector23~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~1_combout\ = ((\inst_i2c_master|bit_cnt\(2) & ((\inst_i2c_master|Mux4~1_combout\))) # (!\inst_i2c_master|bit_cnt\(2) & (\inst_i2c_master|Selector23~0_combout\))) # (!\inst_i2c_master|Selector20~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111100101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|Selector23~0_combout\,
	datab => \inst_i2c_master|bit_cnt\(2),
	datac => \inst_i2c_master|Selector20~0_combout\,
	datad => \inst_i2c_master|Mux4~1_combout\,
	combout => \inst_i2c_master|Selector23~1_combout\);

-- Location: LCCOMB_X52_Y45_N0
\inst_i2c_master|Selector23~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector23~8_combout\ = (((\inst_i2c_master|state.slv_ack1~q\ & !\inst_i2c_master|Mux2~4_combout\)) # (!\inst_i2c_master|Selector23~1_combout\)) # (!\inst_i2c_master|Selector23~7_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.slv_ack1~q\,
	datab => \inst_i2c_master|Mux2~4_combout\,
	datac => \inst_i2c_master|Selector23~7_combout\,
	datad => \inst_i2c_master|Selector23~1_combout\,
	combout => \inst_i2c_master|Selector23~8_combout\);

-- Location: FF_X52_Y45_N1
\inst_i2c_master|sda_int\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|Selector23~8_combout\,
	clrn => \reset_n~q\,
	ena => \inst_i2c_master|process_1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|sda_int~q\);

-- Location: LCCOMB_X46_Y45_N0
\inst_i2c_master|Selector29~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector29~0_combout\ = (\inst_i2c_master|state.stop~q\ & (((!\inst_i2c_master|data_clk_prev~q\)) # (!\inst_i2c_master|data_clk~q\))) # (!\inst_i2c_master|state.stop~q\ & (((!\inst_i2c_master|sda_int~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|data_clk~q\,
	datab => \inst_i2c_master|sda_int~q\,
	datac => \inst_i2c_master|data_clk_prev~q\,
	datad => \inst_i2c_master|state.stop~q\,
	combout => \inst_i2c_master|Selector29~0_combout\);

-- Location: LCCOMB_X46_Y45_N10
\inst_i2c_master|Selector29~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|Selector29~1_combout\ = (\inst_i2c_master|state.start~q\ & (\inst_i2c_master|data_clk~q\)) # (!\inst_i2c_master|state.start~q\ & ((\inst_i2c_master|Selector29~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.start~q\,
	datac => \inst_i2c_master|data_clk~q\,
	datad => \inst_i2c_master|Selector29~0_combout\,
	combout => \inst_i2c_master|Selector29~1_combout\);

-- Location: LCCOMB_X46_Y45_N6
\inst_i2c_master|scl_ena~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|scl_ena~0_combout\ = (!\inst_i2c_master|data_clk~q\ & \inst_i2c_master|data_clk_prev~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst_i2c_master|data_clk~q\,
	datad => \inst_i2c_master|data_clk_prev~q\,
	combout => \inst_i2c_master|scl_ena~0_combout\);

-- Location: LCCOMB_X46_Y45_N16
\inst_i2c_master|scl_ena~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|scl_ena~1_combout\ = (\inst_i2c_master|scl_ena~0_combout\ & ((\inst_i2c_master|state.start~q\) # ((!\inst_i2c_master|state.stop~q\ & \inst_i2c_master|scl_ena~q\)))) # (!\inst_i2c_master|scl_ena~0_combout\ & 
-- (((\inst_i2c_master|scl_ena~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|state.stop~q\,
	datab => \inst_i2c_master|scl_ena~q\,
	datac => \inst_i2c_master|state.start~q\,
	datad => \inst_i2c_master|scl_ena~0_combout\,
	combout => \inst_i2c_master|scl_ena~1_combout\);

-- Location: FF_X47_Y45_N15
\inst_i2c_master|scl_ena\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \inst_i2c_master|scl_ena~1_combout\,
	clrn => \reset_n~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|scl_ena~q\);

-- Location: LCCOMB_X46_Y45_N28
\inst_i2c_master|scl_clk~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|scl_clk~0_combout\ = (!\inst_i2c_master|Equal0~2_combout\ & ((\inst_i2c_master|Add0~18_combout\) # ((\inst_i2c_master|process_0~11_combout\ & !\inst_i2c_master|process_0~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst_i2c_master|process_0~11_combout\,
	datab => \inst_i2c_master|Add0~18_combout\,
	datac => \inst_i2c_master|Equal0~2_combout\,
	datad => \inst_i2c_master|process_0~9_combout\,
	combout => \inst_i2c_master|scl_clk~0_combout\);

-- Location: FF_X46_Y45_N29
\inst_i2c_master|scl_clk\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst_i2c_master|scl_clk~0_combout\,
	ena => \reset_n~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst_i2c_master|scl_clk~q\);

-- Location: LCCOMB_X46_Y45_N18
\inst_i2c_master|scl~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst_i2c_master|scl~1_combout\ = (\inst_i2c_master|scl_clk~q\) # (!\inst_i2c_master|scl_ena~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst_i2c_master|scl_ena~q\,
	datad => \inst_i2c_master|scl_clk~q\,
	combout => \inst_i2c_master|scl~1_combout\);

-- Location: IOIBUF_X45_Y73_N1
\sda~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => sda,
	o => \sda~input_o\);

sda <= \sda~output_o\;

scl <= \scl~output_o\;
END structure;


