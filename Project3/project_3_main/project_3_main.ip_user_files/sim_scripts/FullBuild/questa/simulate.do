onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib FullBuild_opt

do {wave.do}

view wave
view structure
view signals

do {FullBuild.udo}

run -all

quit -force
