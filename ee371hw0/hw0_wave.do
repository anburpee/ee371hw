onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fullAdder_testbench/a
add wave -noupdate /fullAdder_testbench/b
add wave -noupdate /fullAdder_testbench/cin
add wave -noupdate /fullAdder_testbench/sum
add wave -noupdate /fullAdder_testbench/cout
add wave -noupdate /fullAdder_testbench/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {561 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {84 ps}
