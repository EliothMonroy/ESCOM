#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file

#device options
set_option -technology MACHXO2
set_option -part LCMXO2_7000HE
set_option -package TG144C
set_option -speed_grade -5

#compilation/mapping options
set_option -symbolic_fsm_compiler true
set_option -resource_sharing true

#use verilog 2001 standard option
set_option -vlog_std v2001

#map options
set_option -frequency auto
set_option -maxfan 1000
set_option -auto_constrain_io 0
set_option -disable_io_insertion false
set_option -retiming false; set_option -pipe true
set_option -force_gsr false
set_option -compiler_compatible 0
set_option -dup false
set_option -frequency 1
set_option -default_enum_encoding default

#simulation options


#timing analysis options



#automatic place and route (vendor) options
set_option -write_apr_constraint 1

#synplifyPro options
set_option -fix_gated_and_generated_clocks 1
set_option -update_models_cp 0
set_option -resolve_multiple_driver 0


#-- add_file options
add_file -vhdl {C:/lscc/diamond/3.7_x64/cae_library/synthesis/vhdl/machxo2.vhd}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/osc00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/div00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/packageosc00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/toposc00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/ram00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/contring00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/coder00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/packagekey00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/topkey00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/contread00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/contconfig00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/config00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/bufferlcd00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/packagelcdram00.vhdl}
add_file -vhdl -lib "work" {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/toplcdram00.vhdl}

#-- top module name
set_option -top_module toplcdram00

#-- set result format/file last
project -result_file {C:/Users/beatl/Desktop/Arqui/Proyectos/LCDRAM/lcdram00/lcdram00_lcdram00.edi}

#-- error message log file
project -log_file {lcdram00_lcdram00.srf}

#-- set any command lines input by customer


#-- run Synplify with 'arrange HDL file'
project -run hdl_info_gen -fileorder
project -run
