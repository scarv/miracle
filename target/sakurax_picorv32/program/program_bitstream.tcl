
# Setup
open_hw

# Connect to the hardware device server
connect_hw_server -url localhost:3121
refresh_hw_server
current_hw_target [get_hw_targets ]
open_hw_target

# Select the zeroth device
current_hw_device [lindex [get_hw_devices] 0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices] 0]

# Set the bitfile
set bfpath [lindex $argv 0]
puts $bfpath
set_property PROGRAM.FILE $bfpath [lindex [get_hw_devices] 0]

# Program the device
program_hw_devices [lindex [get_hw_devices] 0]
refresh_hw_device [lindex [get_hw_devices] 0]

exit

