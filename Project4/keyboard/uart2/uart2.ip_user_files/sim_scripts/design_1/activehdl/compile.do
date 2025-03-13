vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/util_vector_logic_v2_0_1

vmap xil_defaultlib activehdl/xil_defaultlib
vmap util_vector_logic_v2_0_1 activehdl/util_vector_logic_v2_0_1

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_ps2_keyboard_to_ascii_0_1/sim/design_1_ps2_keyboard_to_ascii_0_1.vhd" \
"../../../bd/design_1/ip/design_1_Reset_Delay_0_0/sim/design_1_Reset_Delay_0_0.vhd" \

vlog -work util_vector_logic_v2_0_1  -v2k5 \
"../../../../uart2.srcs/sources_1/bd/design_1/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/design_1/ip/design_1_util_vector_logic_0_0/sim/design_1_util_vector_logic_0_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_baud_rate_0_0/sim/design_1_baud_rate_0_0.vhd" \
"../../../bd/design_1/ip/design_1_btn_debounce_toggle_0_0/sim/design_1_btn_debounce_toggle_0_0.vhd" \
"../../../bd/design_1/ip/design_1_user_logic_uart2_0_0/sim/design_1_user_logic_uart2_0_0.vhd" \
"../../../bd/design_1/sim/design_1.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

