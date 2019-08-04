
########## Tcl recorder starts at 04/06/17 21:01:39 ##########

set version "2.0"
set proj_dir "C:/Users/ELITH/Documents/GitHub/VHDL-ISP/DSD/Examen1"
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
if [runCmd "\"$cpld_bin/vhd2jhd\" dado.vhd -o dado.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/17 21:01:39 ###########


########## Tcl recorder starts at 04/06/17 21:01:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" dado.vhd -o dado.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/17 21:01:45 ###########


########## Tcl recorder starts at 04/06/17 21:18:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" dado.vhd -o dado.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/17 21:18:20 ###########


########## Tcl recorder starts at 04/06/17 21:18:21 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open dado.cmd w} rspFile] {
	puts stderr "Cannot create response file dado.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: dadodigital.sty
PROJECT: dado
WORKING_PATH: \"$proj_dir\"
MODULE: dado
VHDL_FILE_LIST: dado.vhd
OUTPUT_FILE_NAME: dado
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e dado -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dado.cmd

########## Tcl recorder end at 04/06/17 21:18:21 ###########


########## Tcl recorder starts at 04/06/17 21:19:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" dado.vhd -o dado.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/17 21:19:04 ###########


########## Tcl recorder starts at 04/06/17 21:19:07 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open dado.cmd w} rspFile] {
	puts stderr "Cannot create response file dado.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: dadodigital.sty
PROJECT: dado
WORKING_PATH: \"$proj_dir\"
MODULE: dado
VHDL_FILE_LIST: dado.vhd
OUTPUT_FILE_NAME: dado
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e dado -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dado.cmd

########## Tcl recorder end at 04/06/17 21:19:07 ###########


########## Tcl recorder starts at 04/06/17 21:21:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" dado.vhd -o dado.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/17 21:21:47 ###########


########## Tcl recorder starts at 04/06/17 21:21:48 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open dado.cmd w} rspFile] {
	puts stderr "Cannot create response file dado.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: dadodigital.sty
PROJECT: dado
WORKING_PATH: \"$proj_dir\"
MODULE: dado
VHDL_FILE_LIST: dado.vhd
OUTPUT_FILE_NAME: dado
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e dado -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dado.cmd

########## Tcl recorder end at 04/06/17 21:21:48 ###########


########## Tcl recorder starts at 04/06/17 21:23:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" dado.vhd -o dado.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/06/17 21:23:05 ###########


########## Tcl recorder starts at 04/06/17 21:23:06 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open dado.cmd w} rspFile] {
	puts stderr "Cannot create response file dado.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: dadodigital.sty
PROJECT: dado
WORKING_PATH: \"$proj_dir\"
MODULE: dado
VHDL_FILE_LIST: dado.vhd
OUTPUT_FILE_NAME: dado
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e dado -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dado.cmd

########## Tcl recorder end at 04/06/17 21:23:06 ###########


########## Tcl recorder starts at 06/12/17 21:08:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" dado.vhd -o dado.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/12/17 21:08:54 ###########


########## Tcl recorder starts at 06/12/17 21:08:56 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open dado.cmd w} rspFile] {
	puts stderr "Cannot create response file dado.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: dadodigital.sty
PROJECT: dado
WORKING_PATH: \"$proj_dir\"
MODULE: dado
VHDL_FILE_LIST: dado.vhd
OUTPUT_FILE_NAME: dado
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e dado -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dado.cmd

########## Tcl recorder end at 06/12/17 21:08:56 ###########


########## Tcl recorder starts at 06/12/17 21:09:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" dado.vhd -o dado.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/12/17 21:09:38 ###########


########## Tcl recorder starts at 06/12/17 21:09:39 ##########

# Commands to make the Process: 
# JEDEC File
if [catch {open dado.cmd w} rspFile] {
	puts stderr "Cannot create response file dado.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: dadodigital.sty
PROJECT: dado
WORKING_PATH: \"$proj_dir\"
MODULE: dado
VHDL_FILE_LIST: dado.vhd
OUTPUT_FILE_NAME: dado
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e dado -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dado.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf dado.edi -out dado.bl0 -err automake.err -log dado.log -prj dadodigital -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" dado.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"dado.bl1\" -o \"dadodigital.bl2\" -omod \"dadodigital\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj dadodigital -lci dadodigital.lct -log dadodigital.imp -err automake.err -tti dadodigital.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci dadodigital.lct -blifopt dadodigital.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" dadodigital.bl2 -sweep -mergefb -err automake.err -o dadodigital.bl3 @dadodigital.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci dadodigital.lct -dev lc4k -diofft dadodigital.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" dadodigital.bl3 -family AMDMACH -idev van -o dadodigital.bl4 -oxrf dadodigital.xrf -err automake.err @dadodigital.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci dadodigital.lct -dev lc4k -prefit dadodigital.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp dadodigital.bl4 -out dadodigital.bl5 -err automake.err -log dadodigital.log -mod dado @dadodigital.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open dadodigital.rs1 w} rspFile] {
	puts stderr "Cannot create response file dadodigital.rs1: $rspFile"
} else {
	puts $rspFile "-i dadodigital.bl5 -lci dadodigital.lct -d m4e_256_96 -lco dadodigital.lco -html_rpt -fti dadodigital.fti -fmt PLA -tto dadodigital.tt4 -nojed -eqn dadodigital.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open dadodigital.rs2 w} rspFile] {
	puts stderr "Cannot create response file dadodigital.rs2: $rspFile"
} else {
	puts $rspFile "-i dadodigital.bl5 -lci dadodigital.lct -d m4e_256_96 -lco dadodigital.lco -html_rpt -fti dadodigital.fti -fmt PLA -tto dadodigital.tt4 -eqn dadodigital.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@dadodigital.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dadodigital.rs1
file delete dadodigital.rs2
if [runCmd "\"$cpld_bin/tda\" -i dadodigital.bl5 -o dadodigital.tda -lci dadodigital.lct -dev m4e_256_96 -family lc4k -mod dado -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj dadodigital -if dadodigital.jed -j2s -log dadodigital.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 06/12/17 21:09:39 ###########

