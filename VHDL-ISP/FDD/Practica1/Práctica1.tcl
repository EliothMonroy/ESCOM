
########## Tcl recorder starts at 09/25/16 16:40:48 ##########

set version "2.0"
set proj_dir "C:/Users/ELITH/Documents/GitHub/VHDL-ISP"
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
if [runCmd "\"$cpld_bin/vhd2jhd\" prueba.vhd -o prueba.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/25/16 16:40:48 ###########


########## Tcl recorder starts at 09/25/16 16:45:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" prueba.vhd -o prueba.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/25/16 16:45:34 ###########


########## Tcl recorder starts at 09/25/16 16:47:40 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open prueba.cmd w} rspFile] {
	puts stderr "Cannot create response file prueba.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: pr�ctica1.sty
PROJECT: prueba
WORKING_PATH: \"$proj_dir\"
MODULE: prueba
VHDL_FILE_LIST: prueba.vhd
OUTPUT_FILE_NAME: prueba
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e prueba -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete prueba.cmd

########## Tcl recorder end at 09/25/16 16:47:40 ###########


########## Tcl recorder starts at 09/25/16 16:48:11 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/edif2blf\" -edf prueba.edi -out prueba.bl0 -err automake.err -log prueba.log -prj pr�ctica1 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" prueba.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"prueba.bl1\" -o \"pr�ctica1.bl2\" -omod \"pr�ctica1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj pr�ctica1 -lci pr�ctica1.lct -log pr�ctica1.imp -err automake.err -tti pr�ctica1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci pr�ctica1.lct -blifopt pr�ctica1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" pr�ctica1.bl2 -sweep -mergefb -err automake.err -o pr�ctica1.bl3 @pr�ctica1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci pr�ctica1.lct -dev lc4k -diofft pr�ctica1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" pr�ctica1.bl3 -family AMDMACH -idev van -o pr�ctica1.bl4 -oxrf pr�ctica1.xrf -err automake.err @pr�ctica1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci pr�ctica1.lct -dev lc4k -prefit pr�ctica1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp pr�ctica1.bl4 -out pr�ctica1.bl5 -err automake.err -log pr�ctica1.log -mod prueba @pr�ctica1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open pr�ctica1.rs1 w} rspFile] {
	puts stderr "Cannot create response file pr�ctica1.rs1: $rspFile"
} else {
	puts $rspFile "-i pr�ctica1.bl5 -lci pr�ctica1.lct -d m4e_256_96 -lco pr�ctica1.lco -html_rpt -fti pr�ctica1.fti -fmt PLA -tto pr�ctica1.tt4 -nojed -eqn pr�ctica1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open pr�ctica1.rs2 w} rspFile] {
	puts stderr "Cannot create response file pr�ctica1.rs2: $rspFile"
} else {
	puts $rspFile "-i pr�ctica1.bl5 -lci pr�ctica1.lct -d m4e_256_96 -lco pr�ctica1.lco -html_rpt -fti pr�ctica1.fti -fmt PLA -tto pr�ctica1.tt4 -eqn pr�ctica1.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@pr�ctica1.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete pr�ctica1.rs1
file delete pr�ctica1.rs2
if [runCmd "\"$cpld_bin/tda\" -i pr�ctica1.bl5 -o pr�ctica1.tda -lci pr�ctica1.lct -dev m4e_256_96 -family lc4k -mod prueba -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj pr�ctica1 -if pr�ctica1.jed -j2s -log pr�ctica1.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/25/16 16:48:11 ###########


########## Tcl recorder starts at 09/25/16 21:24:32 ##########

set version "2.0"
set proj_dir "C:/Users/ELITH/Documents/GitHub/VHDL-ISP/Practica1"
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
# Synplify Synthesize VHDL File
if [catch {open prueba.cmd w} rspFile] {
	puts stderr "Cannot create response file prueba.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: pr�ctica1.sty
PROJECT: prueba
WORKING_PATH: \"$proj_dir\"
MODULE: prueba
VHDL_FILE_LIST: prueba.vhd
OUTPUT_FILE_NAME: prueba
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e prueba -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete prueba.cmd

########## Tcl recorder end at 09/25/16 21:24:32 ###########


########## Tcl recorder starts at 09/25/16 21:27:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" prueba.vhd -o prueba.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/25/16 21:27:06 ###########


########## Tcl recorder starts at 09/25/16 21:27:07 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open prueba.cmd w} rspFile] {
	puts stderr "Cannot create response file prueba.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: pr�ctica1.sty
PROJECT: prueba
WORKING_PATH: \"$proj_dir\"
MODULE: prueba
VHDL_FILE_LIST: prueba.vhd
OUTPUT_FILE_NAME: prueba
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e prueba -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete prueba.cmd

########## Tcl recorder end at 09/25/16 21:27:07 ###########


########## Tcl recorder starts at 09/25/16 21:28:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" prueba.vhd -o prueba.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/25/16 21:28:06 ###########


########## Tcl recorder starts at 09/25/16 21:31:36 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open prueba.cmd w} rspFile] {
	puts stderr "Cannot create response file prueba.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: pr�ctica1.sty
PROJECT: prueba
WORKING_PATH: \"$proj_dir\"
MODULE: prueba
VHDL_FILE_LIST: prueba.vhd
OUTPUT_FILE_NAME: prueba
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e prueba -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete prueba.cmd

########## Tcl recorder end at 09/25/16 21:31:36 ###########


########## Tcl recorder starts at 09/25/16 21:45:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" prueba.vhd -o prueba.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/25/16 21:45:07 ###########


########## Tcl recorder starts at 09/25/16 21:45:08 ##########

# Commands to make the Process: 
# Synplify Synthesize VHDL File
if [catch {open prueba.cmd w} rspFile] {
	puts stderr "Cannot create response file prueba.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: pr�ctica1.sty
PROJECT: prueba
WORKING_PATH: \"$proj_dir\"
MODULE: prueba
VHDL_FILE_LIST: prueba.vhd
OUTPUT_FILE_NAME: prueba
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
if [runCmd "\"$cpld_bin/Synpwrap\" -e prueba -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete prueba.cmd

########## Tcl recorder end at 09/25/16 21:45:08 ###########

