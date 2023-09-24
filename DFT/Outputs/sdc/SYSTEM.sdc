###################################################################

# Created by write_sdc on Sat Sep 23 17:42:53 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports UART_RX_IN]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports test_mode]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports SE]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {SI[3]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {SI[2]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {SI[1]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {SI[0]}]
set_load -pin_load 0.1 [get_ports {SO[3]}]
set_load -pin_load 0.1 [get_ports {SO[2]}]
set_load -pin_load 0.1 [get_ports {SO[1]}]
set_load -pin_load 0.1 [get_ports {SO[0]}]
set_load -pin_load 0.5 [get_ports UART_TX_OUT]
create_clock [get_ports REF_CLK]  -name REFCLK  -period 10  -waveform {0 5}
set_clock_uncertainty -setup 0.2  [get_clocks REFCLK]
set_clock_uncertainty -hold 0.1  [get_clocks REFCLK]
set_clock_transition -min -fall 0.05 [get_clocks REFCLK]
set_clock_transition -max -fall 0.05 [get_clocks REFCLK]
set_clock_transition -min -rise 0.05 [get_clocks REFCLK]
set_clock_transition -max -rise 0.05 [get_clocks REFCLK]
create_clock [get_ports UART_CLK]  -name UARTCLK  -period 271.3  -waveform {0 135.65}
set_clock_uncertainty -setup 0.2  [get_clocks UARTCLK]
set_clock_uncertainty -hold 0.1  [get_clocks UARTCLK]
set_clock_transition -min -fall 0.05 [get_clocks UARTCLK]
set_clock_transition -max -fall 0.05 [get_clocks UARTCLK]
set_clock_transition -min -rise 0.05 [get_clocks UARTCLK]
set_clock_transition -max -rise 0.05 [get_clocks UARTCLK]
create_generated_clock [get_pins U0_CLK_GATE/GATED_CLK]  -name ALU_CLK  -source [get_ports REF_CLK]  -master_clock REFCLK  -divide_by 1  -add
set_clock_uncertainty -setup 0.2  [get_clocks ALU_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks ALU_CLK]
set_clock_transition -min -fall 0.05 [get_clocks ALU_CLK]
set_clock_transition -max -fall 0.05 [get_clocks ALU_CLK]
set_clock_transition -min -rise 0.05 [get_clocks ALU_CLK]
set_clock_transition -max -rise 0.05 [get_clocks ALU_CLK]
create_generated_clock [get_pins U0_ClkDiv/o_div_clk]  -name TX_CLK  -source [get_ports UART_CLK]  -master_clock UARTCLK  -divide_by 32  -add
set_clock_uncertainty -setup 0.2  [get_clocks TX_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks TX_CLK]
set_clock_transition -min -fall 0.05 [get_clocks TX_CLK]
set_clock_transition -max -fall 0.05 [get_clocks TX_CLK]
set_clock_transition -min -rise 0.05 [get_clocks TX_CLK]
set_clock_transition -max -rise 0.05 [get_clocks TX_CLK]
create_generated_clock [get_pins U1_ClkDiv/o_div_clk]  -name RX_CLK  -source [get_ports UART_CLK]  -master_clock UARTCLK  -divide_by 4  -add
set_clock_uncertainty -setup 0.2  [get_clocks RX_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks RX_CLK]
set_clock_transition -min -fall 0.05 [get_clocks RX_CLK]
set_clock_transition -max -fall 0.05 [get_clocks RX_CLK]
set_clock_transition -min -rise 0.05 [get_clocks RX_CLK]
set_clock_transition -max -rise 0.05 [get_clocks RX_CLK]
create_clock [get_ports scan_clk]  -name SCAN_CLK  -period 100  -waveform {0 50}
set_input_delay -clock RX_CLK  217.04  [get_ports UART_RX_IN]
set_input_delay -clock SCAN_CLK  20  [get_ports {SI[3]}]
set_input_delay -clock SCAN_CLK  20  [get_ports {SI[2]}]
set_input_delay -clock SCAN_CLK  20  [get_ports {SI[1]}]
set_input_delay -clock SCAN_CLK  20  [get_ports {SI[0]}]
set_input_delay -clock SCAN_CLK  20  [get_ports SE]
set_input_delay -clock SCAN_CLK  20  [get_ports test_mode]
set_output_delay -clock TX_CLK  1736.32  [get_ports UART_TX_OUT]
set_output_delay -clock SCAN_CLK  20  [get_ports {SO[3]}]
set_output_delay -clock SCAN_CLK  20  [get_ports {SO[2]}]
set_output_delay -clock SCAN_CLK  20  [get_ports {SO[1]}]
set_output_delay -clock SCAN_CLK  20  [get_ports {SO[0]}]
set_clock_groups -asynchronous -name REFCLK_1 -group [list [get_clocks REFCLK] [get_clocks ALU_CLK]] -group [list [get_clocks UARTCLK] [get_clocks TX_CLK] [get_clocks RX_CLK]] -group [get_clocks SCAN_CLK]
