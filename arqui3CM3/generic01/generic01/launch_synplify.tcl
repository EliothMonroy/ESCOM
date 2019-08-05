#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/launch_synplify.tcl
#-- Written on Wed Nov 29 11:12:28 2017

project -close
set filename "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/generic01_syn.prj"
if ([file exists "$filename"]) {
	project -load "$filename"
	project_file -remove *
} else {
	project -new "$filename"
}
set create_new 0

#device options
set_option -technology MACHXO2
set_option -part LCMXO2_7000HE
set_option -package TG144C
set_option -speed_grade -4

if {$create_new == 1} {
#-- add synthesis options
	set_option -symbolic_fsm_compiler true
	set_option -resource_sharing true
	set_option -vlog_std v2001
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
	
	
	
	set_option -write_apr_constraint 1
	set_option -fix_gated_and_generated_clocks 1
	set_option -update_models_cp 0
	set_option -resolve_multiple_driver 0
	
	
}
#-- add_file options
add_file -vhdl "C:/lscc/diamond/3.9_x64/cae_library/synthesis/vhdl/machxo2.vhd"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/andg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/xorg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/div00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/osc00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/packagediv00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/packagefa00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/packageha00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/fa00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/ha00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/toposcdiv00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/and00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/or00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/packagesumaresta00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/topfa00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/topha00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/xnor00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/xor00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/packagemult4bit00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/topfa8bits00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/topmult4bit00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/source/topmult8bits00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/org00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/addg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/substg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/uc00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/notg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/nandg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/norg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/xnorg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/multg00.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/packagegeneric01.vhdl"
add_file -vhdl -lib "work" "C:/Users/eliot/Documents/Github/arqui3CM3/generic01/topgeneric01.vhdl"
#-- top module name
set_option -top_module {}
project -result_file {C:/Users/eliot/Documents/Github/arqui3CM3/generic01/generic01/generic01.edi}
project -save "$filename"
