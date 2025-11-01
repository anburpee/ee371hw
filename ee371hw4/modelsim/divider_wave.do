onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /divider_tb/Clock
add wave -noupdate /divider_tb/Resetn
add wave -noupdate /divider_tb/DataA
add wave -noupdate /divider_tb/DataB
add wave -noupdate /divider_tb/s
add wave -noupdate /divider_tb/LA
add wave -noupdate /divider_tb/EB
add wave -noupdate /divider_tb/Done
add wave -noupdate /divider_tb/Q
add wave -noupdate /divider_tb/R
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {104 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {180 ps}
