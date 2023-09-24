
####################################################################################
# Constraints
# ----------------------------------------------------------------------------
#
# 0. Design Compiler variables
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 0 : DC Variables ####
           #########################################################
#################################################################################### 

# Prevent assign statements in the generated netlist (must be applied before compile command)
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################
set UART_CLK_PRESCALE 32
set CLK_NAME_1 REFCLK
set CLK_REF_PER 10
set CLK_NAME_2 UARTCLK
set CLK_UART_PER 271.3
set CLK_SETUP_SKEW 0.2
set CLK_HOLD_SKEW 0.1
set CLK_RISE 0.05
set CLK_FALL 0.05

#3. SCAN_CLK (10 MHZ)
set CLK3_NAME SCAN_CLK
set CLK3_PER 100



create_clock -period $CLK_REF_PER -name $CLK_NAME_1 -waveform "0 [expr $CLK_REF_PER/2]" [get_ports REF_CLK]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks $CLK_NAME_1]
set_clock_uncertainty -hold  $CLK_HOLD_SKEW  [get_clocks $CLK_NAME_1]
set_clock_transition -rise $CLK_RISE  [get_clocks $CLK_NAME_1]
set_clock_transition -fall $CLK_FALL  [get_clocks $CLK_NAME_1]


create_clock -name $CLK_NAME_2 -period $CLK_UART_PER -waveform "0 [expr $CLK_UART_PER/2]" [get_ports UART_CLK]  
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks $CLK_NAME_2]
set_clock_uncertainty -hold  $CLK_HOLD_SKEW  [get_clocks $CLK_NAME_2]
set_clock_transition -rise $CLK_RISE  [get_clocks $CLK_NAME_2]
set_clock_transition -fall $CLK_FALL  [get_clocks $CLK_NAME_2]


create_generated_clock -master_clock $CLK_NAME_1 -source [get_ports REF_CLK] \
                       -name "ALU_CLK" [get_port U0_CLK_GATE/GATED_CLK] \
					   -divide_by 1

set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks ALU_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks ALU_CLK]
set_clock_transition -rise $CLK_RISE  [get_clocks ALU_CLK]
set_clock_transition -fall $CLK_FALL  [get_clocks ALU_CLK]


create_generated_clock -master_clock $CLK_NAME_2 -source [get_ports UART_CLK] \
                       -name "TX_CLK" [get_port U0_ClkDiv/o_div_clk] \
		       -divide_by $UART_CLK_PRESCALE
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks TX_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks TX_CLK]
set_clock_transition -rise $CLK_RISE  [get_clocks TX_CLK]
set_clock_transition -fall $CLK_FALL  [get_clocks TX_CLK]


create_generated_clock -master_clock $CLK_NAME_2 -source [get_ports UART_CLK] \
                       -name "RX_CLK" [get_port U1_ClkDiv/o_div_clk] \
		       -divide_by 4

#3. Scan clocks
create_clock -name $CLK3_NAME -period $CLK3_PER -waveform "0 [expr $CLK3_PER/2]" [get_ports scan_clk]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks scan_clk]
set_clock_uncertainty -hold $CLK_HOLD_SKEW   [get_clocks scan_clk]

set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks RX_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks RX_CLK]
set_clock_transition -rise $CLK_RISE  [get_clocks RX_CLK]
set_clock_transition -fall $CLK_FALL  [get_clocks RX_CLK]

####################################################################################
           #########################################################
             #### Section 2 : Clocks Relationship ####
           #########################################################
####################################################################################


set_clock_groups -asynchronous -group [get_clocks "$CLK_NAME_1 ALU_CLK"]  \
                               -group [get_clocks "$CLK_NAME_2 TX_CLK RX_CLK"] \
                               -group [get_clocks "$CLK3_NAME"] 

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################
set UART_clk_input_delay [expr 0.2 * 4 * $CLK_UART_PER]
set_input_delay $UART_clk_input_delay -clock RX_CLK [get_port UART_RX_IN]
#scan
set_input_delay 20 -clock $CLK3_NAME [get_port SI]
set_input_delay 20 -clock $CLK3_NAME [get_port SE]
set_input_delay 20 -clock $CLK3_NAME [get_port test_mode]

set UART_transmitter_clk_output_delay [expr 0.2 * $UART_CLK_PRESCALE * $CLK_UART_PER]
set_output_delay $UART_transmitter_clk_output_delay -clock TX_CLK [get_port UART_TX_OUT]
#scan
set_output_delay 20 -clock $CLK3_NAME [get_port SO]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port UART_RX_IN]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SI]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port SE]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port test_mode]
####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################
set_load 0.5 [get_port UART_TX_OUT]
set_load 0.1 [get_port SO]
####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

#set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################


####################################################################################
           #########################################################
                  #### Section 8 : DON't touch paths  ####
           #########################################################
####################################################################################

set_dont_touch_network {REF_CLK U0_CLK_GATE/GATED_CLK UART_CLK U1_ClkDiv/o_div_clk UART_CLK U0_ClkDiv/o_div_clk}

####################################################################################




