transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/nevindi/Documents/GitHub/EE316_2025/Project2/Isaac/statemachine/statemachine.vhd}

