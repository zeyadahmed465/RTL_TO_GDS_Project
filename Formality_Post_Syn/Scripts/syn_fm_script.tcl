
############################ Project PATH ################################
set PROJECT_PATH /home/IC/Projects/System
############################  Search PATH ################################

lappend search_path /home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys
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


########################### Define Top Module ############################
                                                   
set top_module SYSTEM

######################### Formality Setup File ###########################

set synopsys_auto_setup true

set_svf "/home/IC/Projects/System/syn/SYSTEM.svf"

####################### Read Reference tech libs ########################
 

set SSLIB "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/tsmc_fb_cl013g_sc/aci/sc-m/synopsys/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

###################  Read Reference Design Files ######################## 
read_verilog -container Ref "ALU.v"
read_verilog -container Ref "BIT_SYNC.v"
read_verilog -container Ref "FIFO_mem.v"
read_verilog -container Ref "r_empty.v"
read_verilog -container Ref "w_full.v"
read_verilog -container Ref "Asynch_FIFO.v"
read_verilog -container Ref "ClkDiv.v"
read_verilog -container Ref "CLK_GATE.v"
read_verilog -container Ref "DATA_SYNC.v"
read_verilog -container Ref "REG_FILE.v"
read_verilog -container Ref "Pulse_Gen.v"
read_verilog -container Ref "RST_SYNC.v"
read_verilog -container Ref "SYS_CTRL.v"
read_verilog -container Ref "data_sampling.v"
read_verilog -container Ref "deserializer.v"
read_verilog -container Ref "edge_bit_counter.v"
read_verilog -container Ref "parity_check.v"
read_verilog -container Ref "stp_check.v"
read_verilog -container Ref "strt_check.v"
read_verilog -container Ref "UART_RX.v"
read_verilog -container Ref "RX_controller.v"
read_verilog -container Ref "mux_4_1.v"
read_verilog -container Ref "Parity_Calc.v"
read_verilog -container Ref "Serializer.v"
read_verilog -container Ref "tx_controller.v"
read_verilog -container Ref "UART_TX.v"
read_verilog -container Ref "UART.v"
read_verilog -container Ref "SYSTEM.v"

######################## set the top Reference Design ######################## 

set_reference_design SYSTEM
set_top SYSTEM

####################### Read Implementation tech libs ######################## 

read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

#################### Read Implementation Design Files ######################## 

read_verilog -container Imp -netlist "/home/IC/Projects/System/syn/netlists/SYSTEM.v"

####################  set the top Implementation Design ######################

set_implementation_design SYSTEM
set_top SYSTEM


## matching Compare points
match

## verify
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

report_passing_points > "reports/passing_points.rpt"
report_failing_points > "reports/failing_points.rpt"
report_aborted_points > "reports/aborted_points.rpt"
report_unverified_points > "reports/unverified_points.rpt"


start_gui
