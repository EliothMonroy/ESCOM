library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packagegeneric01.all;
entity topgeneric01 is
	port(
		clk0: inout std_logic;
		cdiv0: in std_logic_vector(3 downto 0);
		enableg0: in std_logic;
		codop0: in std_logic_vector(4 downto 0);
		inFlagg0: inout std_logic;
		outFlagg0: inout std_logic;
		overLED0: inout std_logic;
		portgA0: in std_logic_vector(7 downto 0);
		portgB0: in std_logic_vector(7 downto 0);
		outg0: out std_logic_vector(15 downto 0)
	);
	--Puertos
	attribute loc: string;
	--Dip switch 1 para configurar velocidad
	attribute loc of cdiv0: signal is "42,44,43,45";
	--Salida último led
	attribute loc of clk0: signal is "99";
	--último primer dip switch
	attribute loc of enableg0: signal is "50";
	--cuarto dip switch
	attribute loc of codop0: signal is "97,98,95,96,93";
	--Dip switch 2
	attribute loc of portgA0: signal is "52,55,54,56,57,59,58,60";
	--Dip switch 3
	attribute loc of portgB0: signal is "61,65,62,67,68,70,69,71";
	--Leds azules
	attribute loc of outg0: signal is "24,23,22,21,20,19,14,13,122,121,120,119,117,115,114,113";
	attribute loc of inFlagg0: signal is "100";
	attribute loc of overLED0: signal is "105";
	--Leds rojos (quinto)
	attribute loc of outFlagg0: signal is "104";
end entity ; -- topgeneric01
architecture arch of topgeneric01 is
signal soutg, sadd, smult: std_logic_vector(15 downto 0);
signal sinFlag, sSL, soverflow, soutoverflow: std_logic;
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
	G03: org00 port map(
		clko=>clk0,
		codopgo=>codop0,
		portAgo=>portgA0,
		portBgo=>portgB0,
		inFlago=>outFlagg0,
		outgo=>soutg,
		outFlago=>inFlagg0
	);
	G04: topfa8bits00 port map(
		SL=>sSL,
		Ai=>portgA0,
		Bi=>portgB0,
		So=>sadd,
		LED=>soverflow
	);
	G05: addg00 port map(
		clkgadd=>clk0,
		codopgadd=>codop0,
		inLEDadd=>soverflow,
		inadd=>sadd,
		inFlagadd=>outFlagg0,
		outgadd=>soutg,
		outoverflowadd=>soutoverflow,
		outSLadd=>sSL,
		outFlagadd=>inFlagg0
	);
	G06: substg00 port map(
		clkgsub=>clk0,
		codopgsub=>codop0,
		inLEDsub=>soverflow,
		insub=>sadd,
		inFlagsub=>outFlagg0,
		outgsub=>soutg,
		outSLsub=>sSL,
		outoverflowsub=>soutoverflow,
		outFlagsub=>inFlagg0
	);
	G07: uc00 port map(
		clkuc=>clk0,
		enableuc=>enableg0,
		overflowuc=>soutoverflow,
		inuc=>soutg,
		inFlaguc=>inFlagg0,
		outoverfuc=>overLED0,
		outuc=>outg0,
		outFlaguc=>outFlagg0
	);
	G08: notg00 port map(
		clknot=>clk0,
		codopgnot=>codop0,
		portAgnot=>portgA0,
		inFlagnot=>outFlagg0,
		outgnot=>soutg,
		outFlagnot=>inFlagg0
	);
	G09: nandg00 port map(
		clknand=>clk0,
		codopgnand=>codop0,
		portAgnand=>portgA0,
		portBgnand=>portgB0,
		inFlagnand=>outFlagg0,
		outgnand=>soutg,
		outFlagnand=>inFlagg0
	);
	G10: norg00 port map(
		clknor=>clk0,
		codopgnor=>codop0,
		portAgnor=>portgA0,
		portBgnor=>portgB0,
		inFlagnor=>outFlagg0,
		outgnor=>soutg,
		outFlagnor=>inFlagg0
	);
	G11: xnorg00 port map(
		clkxnor=>clk0,
		codopgxnor=>codop0,
		portAgxnor=>portgA0,
		portBgxnor=>portgB0,
		inFlagxnor=>outFlagg0,
		outgxnor=>soutg,
		outFlagxnor=>inFlagg0
	);
	G12: topmult8bit00 port map(
		Am4=>portgA0,
		Bm4=>portgB0,
		Rm4=>smult
	);
	G13: multg00 port map(
		clkmult=>clk0,
		codopgmult=>codop0,
		inmult=>smult,
		inFlagmult=>outFlagg0,
		outgmult=>soutg,
		outFlagmult=>inFlagg0
	);
end architecture ; -- arch