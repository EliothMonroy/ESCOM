lappend auto_path "C:/lscc/diamond/3.6_x64/data/script"
package require simulation_generation
set ::bali::simulation::Para(PROJECT) {ASD}
set ::bali::simulation::Para(PROJECTPATH) {C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM}
set ::bali::simulation::Para(FILELIST) {"C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/packagekey00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/packagelcdram00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/bufferlcd00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/config00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contconfig00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contread00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/ram00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/coder00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/contring00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/topkey00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/div00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/osc00.vhdl" "C:/Users/MiguelAngel/Documents/ESCOM/5to Semestre/Arquitectura/Proyectos/LCDRAM/toplcdram00.vhdl" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" }
set ::bali::simulation::Para(COMPLIST) {"VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo2}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {toplcdram00}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {VHDL}
set ::bali::simulation::Para(SDFPATH)  {}
set ::bali::simulation::Para(ADDTOPLEVELSIGNALSTOWAVEFORM)  {1}
set ::bali::simulation::Para(RUNSIMULATION)  {1}
set ::bali::simulation::Para(HDLPARAMETERS) {}
set ::bali::simulation::Para(POJO2LIBREFRESH)    {}
set ::bali::simulation::Para(POJO2MODELSIMLIB)   {}
::bali::simulation::ActiveHDL_Run
