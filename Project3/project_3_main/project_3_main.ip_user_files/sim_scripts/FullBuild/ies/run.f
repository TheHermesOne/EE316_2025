-makelib ies_lib/xilinx_vip -sv \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "C:/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/FullBuild/ip/FullBuild_i2c_user_logic_ADC_0_0/sim/FullBuild_i2c_user_logic_ADC_0_0.vhd" \
  "../../../bd/FullBuild/ip/FullBuild_i2c_user_logic_LCD_0_0/sim/FullBuild_i2c_user_logic_LCD_0_0.vhd" \
  "../../../bd/FullBuild/ip/FullBuild_PWM_gen_0_0/sim/FullBuild_PWM_gen_0_0.vhd" \
  "../../../bd/FullBuild/ip/FullBuild_Reset_Delay_0_0/sim/FullBuild_Reset_Delay_0_0.vhd" \
  "../../../bd/FullBuild/ip/FullBuild_statemachine_0_0/sim/FullBuild_statemachine_0_0.vhd" \
  "../../../bd/FullBuild/ip/FullBuild_btn_debounce_toggle_0_0/sim/FullBuild_btn_debounce_toggle_0_0.vhd" \
  "../../../bd/FullBuild/ip/FullBuild_btn_debounce_toggle_0_1/sim/FullBuild_btn_debounce_toggle_0_1.vhd" \
-endlib
-makelib ies_lib/util_vector_logic_v2_0_1 \
  "../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/FullBuild/ip/FullBuild_util_vector_logic_0_0/sim/FullBuild_util_vector_logic_0_0.v" \
-endlib
-makelib ies_lib/xlconstant_v1_1_6 \
  "../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/66e7/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/FullBuild/ip/FullBuild_xlconstant_0_0/sim/FullBuild_xlconstant_0_0.v" \
-endlib
-makelib ies_lib/axi_infrastructure_v1_1_0 \
  "../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_vip_v1_1_5 -sv \
  "../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib ies_lib/processing_system7_vip_v1_0_7 -sv \
  "../../../../project_3_main.srcs/sources_1/bd/FullBuild/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/FullBuild/ip/FullBuild_processing_system7_0_0/sim/FullBuild_processing_system7_0_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/FullBuild/ip/FullBuild_LCD_Controller_0_0/sim/FullBuild_LCD_Controller_0_0.vhd" \
  "../../../bd/FullBuild/ip/FullBuild_LCD_Data_Cutter_0_0/sim/FullBuild_LCD_Data_Cutter_0_0.vhd" \
  "../../../bd/FullBuild/sim/FullBuild.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

