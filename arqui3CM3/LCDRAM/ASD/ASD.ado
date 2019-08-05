setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/ASD/ASD.adf"]} { 
	design create ASD "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM"
  set newDesign 1
}
design open "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/ASD"
cd "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/packagekey00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/packagelcdram00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/bufferlcd00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/config00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contconfig00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contread00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/ram00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/coder00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contring00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/topkey00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/div00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/osc00.vhdl"
addfile "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/toplcdram00.vhdl"
vlib "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/ASD/work"
set worklib work
adel -all
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/packagekey00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/packagelcdram00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/bufferlcd00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/config00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contconfig00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contread00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/ram00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/coder00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contring00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/topkey00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/div00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/osc00.vhdl"
vcom -dbg -work work "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/toplcdram00.vhdl"
entity toplcdram00
vsim  +access +r toplcdram00   -PL pmi_work -L ovi_machxo2
add wave *
run 1000ns
