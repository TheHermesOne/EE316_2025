onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /statemachine_tb/Clk
add wave -noupdate /statemachine_tb/reset
add wave -noupdate /statemachine_tb/countVal
add wave -noupdate /statemachine_tb/Keys
add wave -noupdate /statemachine_tb/stateOut
add wave -noupdate /statemachine_tb/statemachine_inst/stateVAR
add wave -noupdate /statemachine_tb/statemachine_inst/btn1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
