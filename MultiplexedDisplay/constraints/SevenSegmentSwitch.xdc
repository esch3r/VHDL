#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { reset[0] }];

set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk100mhz}]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk100mhz}];

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { sw0}]; # Slow clock rate if '0' fast clock rate if '1'
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { sw1}]; # Numeric Pattern if '1' Rotating Pattern if '0'

# Seven Segment Display

set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports {anode[0]}]; 
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports {anode[1]}];
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports {anode[2]}];
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports {anode[3]}];
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports {anode[4]}]; 
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports {anode[5]}];
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports {anode[6]}]; 
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports {anode[7]}];

set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports {cathode[0]}]; #IO_L24N_T3_A00_D16_14 Sch=ca
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports {cathode[1]}]; #IO_25_14 Sch=cb
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports {cathode[2]}];
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports {cathode[3]}];
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports {cathode[4]}];
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports {cathode[5]}];
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports {cathode[6]}];
