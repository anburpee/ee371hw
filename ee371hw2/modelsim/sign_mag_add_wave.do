onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal -childformat {{{/sign_mag_add_tb/a[3]} -radix decimal} {{/sign_mag_add_tb/a[2]} -radix decimal} {{/sign_mag_add_tb/a[1]} -radix decimal} {{/sign_mag_add_tb/a[0]} -radix decimal}} -subitemconfig {{/sign_mag_add_tb/a[3]} {-radix decimal} {/sign_mag_add_tb/a[2]} {-radix decimal} {/sign_mag_add_tb/a[1]} {-radix decimal} {/sign_mag_add_tb/a[0]} {-radix decimal}} /sign_mag_add_tb/a
add wave -noupdate -radix decimal -childformat {{{/sign_mag_add_tb/b[3]} -radix decimal} {{/sign_mag_add_tb/b[2]} -radix decimal} {{/sign_mag_add_tb/b[1]} -radix decimal} {{/sign_mag_add_tb/b[0]} -radix decimal}} -subitemconfig {{/sign_mag_add_tb/b[3]} {-radix decimal} {/sign_mag_add_tb/b[2]} {-radix decimal} {/sign_mag_add_tb/b[1]} {-radix decimal} {/sign_mag_add_tb/b[0]} {-radix decimal}} /sign_mag_add_tb/b
add wave -noupdate /sign_mag_add_tb/dut/sign_a
add wave -noupdate /sign_mag_add_tb/dut/mag_a
add wave -noupdate /sign_mag_add_tb/dut/sign_b
add wave -noupdate /sign_mag_add_tb/dut/mag_b
add wave -noupdate -radix decimal /sign_mag_add_tb/sum
add wave -noupdate -radix decimal /sign_mag_add_tb/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {504 ps} 0}
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
WaveRestoreZoom {421 ps} {563 ps}
