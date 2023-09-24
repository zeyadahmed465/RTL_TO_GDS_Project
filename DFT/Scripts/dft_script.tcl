########################### Define Top Module ############################
                                                   
set top_module SYSTEM

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work

############################# Formality Setup File ##########################
                                                   
set_svf $top_module.svf

set PROJECT_PATH /home/IC/Projects/System/
set LIB_PATH     /home/IC/tsmc_fb_cl013g_sc/aci/sc-m


################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries           #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path $LIB_PATH/synopsys
lappend search_path $PROJECT_PATH/RTL/ALU
lappend search_path $PROJECT_PATH/RTL/Asynch_FIFO
lappend search_path $PROJECT_PATH/RTL/Clock_Divider
lappend search_path $PROJECT_PATH/RTL/CLK_GATE
lappend search_path $PROJECT_PATH/RTL/DATA_SYNC
lappend search_path $PROJECT_PATH/RTL/REG_FILE
lappend search_path $PROJECT_PATH/RTL/Pulse_Gen
lappend search_path $PROJECT_PATH/RTL/RST_SYNC
lappend search_path $PROJECT_PATH/RTL/SYS_CTRL
lappend search_path $PROJECT_PATH/RTL/UART/UART_RX
lappend search_path $PROJECT_PATH/RTL/UART/UART_TX
lappend search_path $PROJECT_PATH/RTL/UART/UART_TOP
lappend search_path $PROJECT_PATH/RTL/Top



set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  

######################## Reading RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

set file_format verilog
#ALU
analyze -format $file_format ALU.v
#FIFO
analyze -format $file_format BIT_SYNC.v
analyze -format $file_format FIFO_mem.v
analyze -format $file_format r_empty.v
analyze -format $file_format w_full.v
analyze -format $file_format Asynch_FIFO.v
#CLK_DIVIDER
analyze -format $file_format ClkDiv.v
#CLK_GATING
analyze -format $file_format CLK_GATE.v
#DATA_SYNC
analyze -format $file_format DATA_SYNC.v
#REGISTER_FILE
analyze -format $file_format REG_FILE.v
#PULSE_GENERATOR
analyze -format $file_format Pulse_Gen.v
#RST_SYNC
analyze -format $file_format RST_SYNC.v
#SYS_CONTROLLER
analyze -format $file_format SYS_CTRL.v
#UART_RX
analyze -format $file_format data_sampling.v
analyze -format $file_format deserializer.v
analyze -format $file_format edge_bit_counter.v
analyze -format $file_format parity_check.v
analyze -format $file_format stp_check.v
analyze -format $file_format strt_check.v
analyze -format $file_format UART_RX.v
analyze -format $file_format RX_controller.v
#UART_TX
analyze -format $file_format mux_4_1.v
analyze -format $file_format Parity_Calc.v
analyze -format $file_format Serializer.v
analyze -format $file_format UART_TX.v
analyze -format $file_format tx_controller.v
#scan mux
analyze -format $file_format mux2X1.v
#UART_TOP
analyze -format $file_format UART.v
#SYS_TOP
analyze -format $file_format SYSTEM_dft.v


elaborate -lib WORK SYSTEM


###################### Defining toplevel ###################################

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source ./cons.tcl

#################### Archirecture Scan Chains #########################
puts "###############################################"
puts "############ Configure scan chains ############"
puts "###############################################"

set_scan_configuration -clock_mixing no_mix  \
                       -style multiplexed_flip_flop \
                       -replace true -max_length 100  

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

#test_ready compile
compile -scan

################################################################### 
# Setting Test Timing Variables
################################################################### 

# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0

########################## Define DFT Signals ##########################

set_dft_signal -port [get_ports scan_clk]   -type ScanClock   -view existing_dft  -timing {50 100}
set_dft_signal -port [get_ports scan_reset] -type Reset       -view existing_dft  -active_state 0
set_dft_signal -port [get_ports test_mode]  -type Constant    -view existing_dft  -active_state 1 
set_dft_signal -port [get_ports test_mode]  -type TestMode    -view spec          -active_state 1 
set_dft_signal -port [get_ports SE]         -type ScanEnable  -view spec          -active_state 1   -usage scan
set_dft_signal -port [get_ports SI]         -type ScanDataIn  -view spec 
set_dft_signal -port [get_ports SO]         -type ScanDataOut -view spec  

############################# Create Test Protocol #######################
                                           
create_test_protocol

###################### Pre-DFT Design Rule Checking #######################

dft_drc -verbose

############################# Preview DFT ##############################

preview_dft -show scan_summary

############################# Insert DFT ##############################

insert_dft
compile -scan -incremental

###################### Design Rule Checking #######################

dft_drc -verbose -coverage_estimate

##################### Close Formality Setup file ###########################

set_svf -off

#############################################################################
# Write out files
#############################################################################

write_file -format verilog -hierarchy -output netlists/$top_module.ddc
write_file -format verilog -hierarchy -output netlists/$top_module.v
write_sdf  sdf/$top_module.sdf
write_sdc  -nosplit sdc/$top_module.sdc

####################### reporting ##########################################

report_area -hierarchy > reports/area.rpt
report_power -hierarchy > reports/power.rpt
report_timing -delay_type min -max_paths 20 > reports/hold.rpt
report_timing -delay_type max -max_paths 20 > reports/setup.rpt
report_clock -attributes > reports/clocks.rpt
report_constraint -all_violators -nosplit > reports/constraints.rpt

################# starting graphical user interface #######################


################# starting graphical user interface #######################

gui_start

#exit
