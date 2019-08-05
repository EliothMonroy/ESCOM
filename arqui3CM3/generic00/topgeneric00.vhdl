library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packagegeneric00.all;
entity topgeneric00 is
	port(
		clk0: inout std_logic;
		cdiv0: in std_logic_vector(3 downto 0);
		enableg0: in std_logic;
		codop0: in std_logic_vector(4 downto 0);
		inFlagg0: inout std_logic;
		outFlagg0: inout std_logic;
		portgA0: in std_logic_vector(7 downto 0);
		portgB0: in std_logic_vector(7 downto 0);
		outg0: out std_logic_vector(7 downto 0)
	);
	--Puertos
	attribute loc: string;
	--Dip switch 1 para configurar velocidad
	attribute loc of cdiv0: signal is "42,44,43,45";
	--Salida último led
	attribute loc of clk0: signal is "13";
	--último primer dip switch
	attribute loc of enableg0: signal is "50";
	--cuarto dip switch
	attribute loc of codop0: signal is "97,98,95,96,93";
	--Dip switch 2
	attribute loc of portgA0: signal is "52,55,54,56,57,59,58,60";
	--Dip switch 3
	attribute loc of portgB0: signal is "61,65,62,67,68,70,69,71";
	--Leds azules
	attribute loc of outg0: signal is "122,121,120,119,117,115,114,113";
	--Leds rojos (Primero)
	attribute loc of inFlagg0: signal is "24";
	--Leds rojos (quinto)
	attribute loc of outFlagg0: signal is "20";
end entity ; -- topgeneric00
architecture arch of topgeneric00 is
signal soutg: std_logic_vector(7 downto 0);
signal sinFlag: std_logic;
begin
	G00: toposcdiv00 port map(
		indiv0=>cdiv0,
		outdiv0=>clk0
	);
	G01: andg00 port map(
		clka=>clk0,
		codopga=>codop0,
		portAga=>portgA0,
		portBga=>portgB0,
		inFlaga=>outFlagg0,
		outga=>soutg,
		outFlaga=>inFlagg0
	);
	G02: xorg00 port map(
		clkx=>clk0,
		codopx=>codop0,
		portAgx=>portgA0,
		portBgx=>portgB0,
		inFlagx=>outFlagg0,
		outgx=>soutg,
		outFlagx=>inFlagg0
	);
	G03: uc00 port map(
		clkuc=>clk0,
		enableuc=>enableg0,
		inuc=>soutg,
		inFlaguc=>inFlagg0,
		outuc=>outg0,
		outFlaguc=>outFlagg0
	);
end architecture ; -- arch