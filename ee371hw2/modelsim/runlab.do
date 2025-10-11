# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "../src/sign_mag_add_tb.sv"
vlog "../src/sign_mag_add.sv"
vlog "../src/sync_rom.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work sign_mag_add_tb

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do sign_mag_add_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End


