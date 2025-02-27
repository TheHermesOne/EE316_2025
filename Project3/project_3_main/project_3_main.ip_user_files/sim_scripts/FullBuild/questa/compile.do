vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/util_vector_logic_v2_0_1
vlib questa_lib/msim/xlconstant_v1_1_6
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_5
vlib questa_lib/msim/processing_system7_vip_v1_0_7

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap util_vector_logic_v2_0_1 questa_lib/msim/util_vector_logic_v2_0_1
vmap xlconstant_v1_1_6 questa_lib/msim/xlconstant_v1_1_6
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_5 questa_lib/msim/axi_vip_v1_1_5
vmap processing_system7_vip_v1_0_7 questa_lib/msim/processing_system7_vip_v1_0_7

vlog -work xilinx_vip -64 -sv -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xilinx_vip "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/FullBuild/ip/FullBuild_i2c_user_logic_ADC_0_0/sim/FullBuild_i2c_user_logic_ADC_0_0.vhd" \
"../../../bd/FullBuild/ip/FullBuild_i2c_user_logic_LCD_0_0/sim/FullBuild_i2c_user_logic_LCD_0_0.vhd" \
"../../../bd/FullBuild/ip/FullBuild_PWM_gen_0_0/sim/FullBuild_PWM_gen_0_0.vhd" \
"../../../bd/FullBuild/ip/FullBuild_Reset_Delay_0_0/sim/FullBuild_Reset_Delay_0_0.vhd" \
"../../../bd/FullBuild/ip/FullBuild_statemachine_0_0/sim/FullBuild_statemachine_0_0.vhd" \
"../../../bd/FullBuild/ip/FullBuild_btn_debounce_toggle_0_0/sim/FullBuild_btn_debounce_toggle_0_0.vhd" \
"../../../bd/FullBuild/ip/FullBuild_btn_debounce_toggle_0_1/sim/FullBuild_btn_debounce_toggle_0_1.vhd" \

vlog -work util_vector_logic_v2_0_1 -64 "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ip/FullBuild_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ip/FullBuild_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/FullBuild/ip/FullBuild_util_vector_logic_0_0/sim/FullBuild_util_vector_logic_0_0.v" \

vlog -work xlconstant_v1_1_6 -64 "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ip/FullBuild_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/66e7/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ip/FullBuild_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/FullBuild/ip/FullBuild_xlconstant_0_0/sim/FullBuild_xlconstant_0_0.v" \

vlog -work axi_infrastructure_v1_1_0 -64 "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ip/FullBuild_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_5 -64 -sv -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xilinx_vip "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ip/FullBuild_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_7 -64 -sv -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xilinx_vip "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ip/FullBuild_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl" "+incdir+../../../../project_3_main.srcs/sources_1/bd/FullBuild/ip/FullBuild_processing_system7_0_0" "+incdir+C:/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/FullBuild/ip/FullBuild_processing_system7_0_0/sim/FullBuild_processing_system7_0_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/FullBuild/ip/FullBuild_LCD_Controller_0_0/sim/FullBuild_LCD_Controller_0_0.vhd" \
"../../../bd/FullBuild/ip/FullBuild_LCD_Data_Cutter_0_0/sim/FullBuild_LCD_Data_Cutter_0_0.vhd" \
"../../../bd/FullBuild/sim/FullBuild.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

