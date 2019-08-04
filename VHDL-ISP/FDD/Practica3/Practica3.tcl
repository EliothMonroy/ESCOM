
########## Tcl recorder starts at 10/09/16 18:19:44 ##########

set version "2.0"
set proj_dir "C:/Users/ELITH/Documents/GitHub/VHDL-ISP/Practica3"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" decodificador.vhd -o decodificador.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 18:19:44 ###########


########## Tcl recorder starts at 10/09/16 19:50:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" decodificador.vhd -o decodificador.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 19:50:43 ###########


########## Tcl recorder starts at 10/09/16 19:50:45 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open Decodificador.cmd w} rspFile] {
	puts stderr "Cannot create response file Decodificador.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: practica3.sty
PROJECT: Decodificador
WORKING_PATH: \"$proj_dir\"
MODULE: Decodificador
VHDL_FILE_LIST: decodificador.vhd
OUTPUT_FILE_NAME: Decodificador
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e Decodificador -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Decodificador.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf Decodificador.edi -out Decodificador.bl0 -err automake.err -log Decodificador.log -prj practica3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" Decodificador.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"Decodificador.bl1\" -o \"practica3.bl2\" -omod \"practica3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj practica3 -lci practica3.lct -log practica3.imp -err automake.err -tti practica3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -blifopt practica3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" practica3.bl2 -sweep -mergefb -err automake.err -o practica3.bl3 @practica3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -diofft practica3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" practica3.bl3 -family AMDMACH -idev van -o practica3.bl4 -oxrf practica3.xrf -err automake.err @practica3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -prefit practica3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp practica3.bl4 -out practica3.bl5 -err automake.err -log practica3.log -mod Decodificador @practica3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i practica3.bl5 -o practica3.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src practica3.bl5 -type BLIF -presrc practica3.bl3 -crf practica3.crf -sif practica3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci practica3.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 19:50:45 ###########


########## Tcl recorder starts at 10/09/16 19:51:50 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open Decodificador.cmd w} rspFile] {
	puts stderr "Cannot create response file Decodificador.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: practica3.sty
PROJECT: Decodificador
WORKING_PATH: \"$proj_dir\"
MODULE: Decodificador
VHDL_FILE_LIST: decodificador.vhd
OUTPUT_FILE_NAME: Decodificador
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e Decodificador -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Decodificador.cmd

########## Tcl recorder end at 10/09/16 19:51:50 ###########


########## Tcl recorder starts at 10/09/16 19:52:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" decodificador.vhd -o decodificador.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 19:52:30 ###########


########## Tcl recorder starts at 10/09/16 19:52:32 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open Decodificador.cmd w} rspFile] {
	puts stderr "Cannot create response file Decodificador.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: practica3.sty
PROJECT: Decodificador
WORKING_PATH: \"$proj_dir\"
MODULE: Decodificador
VHDL_FILE_LIST: decodificador.vhd
OUTPUT_FILE_NAME: Decodificador
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e Decodificador -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Decodificador.cmd

########## Tcl recorder end at 10/09/16 19:52:32 ###########


########## Tcl recorder starts at 10/09/16 19:55:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" decodificador.vhd -o decodificador.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 19:55:13 ###########


########## Tcl recorder starts at 10/09/16 19:55:14 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open Decodificador.cmd w} rspFile] {
	puts stderr "Cannot create response file Decodificador.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: practica3.sty
PROJECT: Decodificador
WORKING_PATH: \"$proj_dir\"
MODULE: Decodificador
VHDL_FILE_LIST: decodificador.vhd
OUTPUT_FILE_NAME: Decodificador
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e Decodificador -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Decodificador.cmd

########## Tcl recorder end at 10/09/16 19:55:14 ###########


########## Tcl recorder starts at 10/09/16 19:56:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" decodificador.vhd -o decodificador.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 19:56:07 ###########


########## Tcl recorder starts at 10/09/16 19:56:08 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open Decodificador.cmd w} rspFile] {
	puts stderr "Cannot create response file Decodificador.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: practica3.sty
PROJECT: Decodificador
WORKING_PATH: \"$proj_dir\"
MODULE: Decodificador
VHDL_FILE_LIST: decodificador.vhd
OUTPUT_FILE_NAME: Decodificador
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e Decodificador -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Decodificador.cmd

########## Tcl recorder end at 10/09/16 19:56:08 ###########


########## Tcl recorder starts at 10/09/16 19:56:41 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf Decodificador.edi -out Decodificador.bl0 -err automake.err -log Decodificador.log -prj practica3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" Decodificador.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"Decodificador.bl1\" -o \"practica3.bl2\" -omod \"practica3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj practica3 -lci practica3.lct -log practica3.imp -err automake.err -tti practica3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -blifopt practica3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" practica3.bl2 -sweep -mergefb -err automake.err -o practica3.bl3 @practica3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -diofft practica3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" practica3.bl3 -family AMDMACH -idev van -o practica3.bl4 -oxrf practica3.xrf -err automake.err @practica3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -prefit practica3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp practica3.bl4 -out practica3.bl5 -err automake.err -log practica3.log -mod Decodificador @practica3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i practica3.bl5 -o practica3.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src practica3.bl5 -type BLIF -presrc practica3.bl3 -crf practica3.crf -sif practica3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci practica3.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 19:56:42 ###########


########## Tcl recorder starts at 10/09/16 21:27:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" decodificador.vhd -o decodificador.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 21:27:36 ###########


########## Tcl recorder starts at 10/09/16 21:27:38 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open Decodificador.cmd w} rspFile] {
	puts stderr "Cannot create response file Decodificador.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: practica3.sty
PROJECT: Decodificador
WORKING_PATH: \"$proj_dir\"
MODULE: Decodificador
VHDL_FILE_LIST: decodificador.vhd
OUTPUT_FILE_NAME: Decodificador
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e Decodificador -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Decodificador.cmd

########## Tcl recorder end at 10/09/16 21:27:38 ###########


########## Tcl recorder starts at 10/09/16 21:28:04 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/edif2blf\" -edf Decodificador.edi -out Decodificador.bl0 -err automake.err -log Decodificador.log -prj practica3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" Decodificador.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"Decodificador.bl1\" -o \"practica3.bl2\" -omod \"practica3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj practica3 -lci practica3.lct -log practica3.imp -err automake.err -tti practica3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -blifopt practica3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" practica3.bl2 -sweep -mergefb -err automake.err -o practica3.bl3 @practica3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -diofft practica3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" practica3.bl3 -family AMDMACH -idev van -o practica3.bl4 -oxrf practica3.xrf -err automake.err @practica3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -prefit practica3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp practica3.bl4 -out practica3.bl5 -err automake.err -log practica3.log -mod Decodificador @practica3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open practica3.rs1 w} rspFile] {
	puts stderr "Cannot create response file practica3.rs1: $rspFile"
} else {
	puts $rspFile "-i practica3.bl5 -lci practica3.lct -d m4e_256_96 -lco practica3.lco -html_rpt -fti practica3.fti -fmt PLA -tto practica3.tt4 -nojed -eqn practica3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open practica3.rs2 w} rspFile] {
	puts stderr "Cannot create response file practica3.rs2: $rspFile"
} else {
	puts $rspFile "-i practica3.bl5 -lci practica3.lct -d m4e_256_96 -lco practica3.lco -html_rpt -fti practica3.fti -fmt PLA -tto practica3.tt4 -eqn practica3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@practica3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete practica3.rs1
file delete practica3.rs2
if [runCmd "\"$cpld_bin/tda\" -i practica3.bl5 -o practica3.tda -lci practica3.lct -dev m4e_256_96 -family lc4k -mod Decodificador -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj practica3 -if practica3.jed -j2s -log practica3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 21:28:04 ###########


########## Tcl recorder starts at 10/09/16 21:28:50 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i practica3.bl5 -o practica3.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src practica3.bl5 -type BLIF -presrc practica3.bl3 -crf practica3.crf -sif practica3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci practica3.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 21:28:50 ###########


########## Tcl recorder starts at 10/09/16 21:29:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" decodificador.vhd -o decodificador.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 21:29:57 ###########


########## Tcl recorder starts at 10/09/16 21:29:58 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open Decodificador.cmd w} rspFile] {
	puts stderr "Cannot create response file Decodificador.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: practica3.sty
PROJECT: Decodificador
WORKING_PATH: \"$proj_dir\"
MODULE: Decodificador
VHDL_FILE_LIST: decodificador.vhd
OUTPUT_FILE_NAME: Decodificador
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e Decodificador -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Decodificador.cmd

########## Tcl recorder end at 10/09/16 21:29:58 ###########


########## Tcl recorder starts at 10/09/16 21:30:18 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf Decodificador.edi -out Decodificador.bl0 -err automake.err -log Decodificador.log -prj practica3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" Decodificador.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"Decodificador.bl1\" -o \"practica3.bl2\" -omod \"practica3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj practica3 -lci practica3.lct -log practica3.imp -err automake.err -tti practica3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -blifopt practica3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" practica3.bl2 -sweep -mergefb -err automake.err -o practica3.bl3 @practica3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -diofft practica3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" practica3.bl3 -family AMDMACH -idev van -o practica3.bl4 -oxrf practica3.xrf -err automake.err @practica3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -prefit practica3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp practica3.bl4 -out practica3.bl5 -err automake.err -log practica3.log -mod Decodificador @practica3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i practica3.bl5 -o practica3.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src practica3.bl5 -type BLIF -presrc practica3.bl3 -crf practica3.crf -sif practica3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci practica3.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 21:30:18 ###########


########## Tcl recorder starts at 10/09/16 21:31:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" decodificador.vhd -o decodificador.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 21:31:17 ###########


########## Tcl recorder starts at 10/09/16 21:31:18 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open Decodificador.cmd w} rspFile] {
	puts stderr "Cannot create response file Decodificador.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: practica3.sty
PROJECT: Decodificador
WORKING_PATH: \"$proj_dir\"
MODULE: Decodificador
VHDL_FILE_LIST: decodificador.vhd
OUTPUT_FILE_NAME: Decodificador
SUFFIX_NAME: edi
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DEFAULT_ENUM_ENCODING: default
ARRANGE_VHDL_FILES: true
synthesis_onoff_pragma: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -e Decodificador -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete Decodificador.cmd

########## Tcl recorder end at 10/09/16 21:31:18 ###########


########## Tcl recorder starts at 10/09/16 21:31:45 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/edif2blf\" -edf Decodificador.edi -out Decodificador.bl0 -err automake.err -log Decodificador.log -prj practica3 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" Decodificador.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"Decodificador.bl1\" -o \"practica3.bl2\" -omod \"practica3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj practica3 -lci practica3.lct -log practica3.imp -err automake.err -tti practica3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -blifopt practica3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" practica3.bl2 -sweep -mergefb -err automake.err -o practica3.bl3 @practica3.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -diofft practica3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" practica3.bl3 -family AMDMACH -idev van -o practica3.bl4 -oxrf practica3.xrf -err automake.err @practica3.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci practica3.lct -dev lc4k -prefit practica3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp practica3.bl4 -out practica3.bl5 -err automake.err -log practica3.log -mod Decodificador @practica3.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i practica3.bl5 -o practica3.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src practica3.bl5 -type BLIF -presrc practica3.bl3 -crf practica3.crf -sif practica3.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4e_256_96.dev\" -lci practica3.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 21:31:45 ###########


########## Tcl recorder starts at 10/09/16 21:31:59 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open practica3.rs1 w} rspFile] {
	puts stderr "Cannot create response file practica3.rs1: $rspFile"
} else {
	puts $rspFile "-i practica3.bl5 -lci practica3.lct -d m4e_256_96 -lco practica3.lco -html_rpt -fti practica3.fti -fmt PLA -tto practica3.tt4 -nojed -eqn practica3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open practica3.rs2 w} rspFile] {
	puts stderr "Cannot create response file practica3.rs2: $rspFile"
} else {
	puts $rspFile "-i practica3.bl5 -lci practica3.lct -d m4e_256_96 -lco practica3.lco -html_rpt -fti practica3.fti -fmt PLA -tto practica3.tt4 -eqn practica3.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@practica3.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete practica3.rs1
file delete practica3.rs2
if [runCmd "\"$cpld_bin/tda\" -i practica3.bl5 -o practica3.tda -lci practica3.lct -dev m4e_256_96 -family lc4k -mod Decodificador -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj practica3 -if practica3.jed -j2s -log practica3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 10/09/16 21:31:59 ###########

