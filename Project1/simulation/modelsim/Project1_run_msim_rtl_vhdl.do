transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/nathani/Documents/GitHub/EE316_2025/Project1/DE2_115.vhd}
vcom -93 -work work {C:/Users/nathani/Documents/GitHub/EE316_2025/Project1/top_level.vhd}
vcom -93 -work work {C:/Users/nathani/Documents/GitHub/EE316_2025/Project1/reset_delay.vhd}
vcom -93 -work work {C:/Users/nathani/Documents/GitHub/EE316_2025/Project1/clk_enabler.vhd}

