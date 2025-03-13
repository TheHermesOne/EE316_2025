vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/util_vector_logic_v2_0_1

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap util_vector_logic_v2_0_1 questa_lib/msim/util_vector_logic_v2_0_1

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_ps2_keyboard_to_ascii_0_1/sim/design_1_ps2_keyboard_to_ascii_0_1.vhd" \
"../../../bd/design_1/ip/design_1_Reset_Delay_0_0/sim/design_1_Reset_Delay_0_0.vhd" \

vlog -work util_vector_logic_v2_0_1 -64 \
"../../../../uart2.srcs/sources_1/bd/design_1/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 \
"../../../bd/design_1/ip/design_1_util_vector_logic_0_0/sim/design_1_util_vector_logic_0_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_baud_rate_0_0/sim/design_1_baud_rate_0_0.vhd" \
"../../../bd/design_1/ip/design_1_btn_debounce_toggle_0_0/sim/design_1_btn_debounce_toggle_0_0.vhd" \
"../../../bd/design_1/ip/design_1_user_logic_uart2_0_0/sim/design_1_user_logic_uart2_0_0.vhd" \
"../../../bd/design_1/sim/design_1.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

