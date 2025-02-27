connect -url tcp:127.0.0.1:3121
source C:/Users/nathani/Documents/GitHub/EE316_2025/Project3/project_3_main/project_3_main.sdk/FullBuild_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "JTAG-ONB4 25163300758BA"} -index 0
loadhw -hw C:/Users/nathani/Documents/GitHub/EE316_2025/Project3/project_3_main/project_3_main.sdk/FullBuild_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "JTAG-ONB4 25163300758BA"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "JTAG-ONB4 25163300758BA"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "JTAG-ONB4 25163300758BA"} -index 0
dow C:/Users/nathani/Documents/GitHub/EE316_2025/Project3/project_3_main/project_3_main.sdk/HelloWorld/Debug/HelloWorld.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "JTAG-ONB4 25163300758BA"} -index 0
con
