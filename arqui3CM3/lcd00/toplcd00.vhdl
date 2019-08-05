library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagelcd00.all;
entity toplcd00 is
	port (
		clk0: inout std_logic;
		cdiv0: in std_logic_vector(3 downto 0);
		reset0: in std_logic;
		outflagc0: inout std_logic;
		outflagcc0: inout std_logic;
		outflagcd0: inout std_logic;
		outflagdd0: inout std_logic;
		outcontcc0: inout std_logic_vector(4 downto 0);
		outcd0: inout std_logic_vector(4 downto 0);
		outwordlcd0: out std_logic_vector(7 downto 0);
		outwordled0: out std_logic_vector(7 downto 0);
		RW0: out std_logic;
		RS0: out std_logic;
		EN0: out std_logic
	);
	--Puertos
	attribute loc: string;
	--Dip switch 1 para configurar velocidad
	attribute loc of cdiv0: signal is "42,44,43,45";
	--Salida último led
	attribute loc of clk0: signal is "13";
	--Primero tercer dip switch
	attribute loc of reset0: signal is "61";
	--Leds azules
	attribute loc of outwordled0: signal is "122,121,120,119,117,115,114,113";
	--Entradas lcd
	--attribute loc of outwordlcd0: signal is "10,9,6,5,4,3,2,1";
	attribute loc of outwordlcd0: signal is "1,2,3,4,5,6,9,10";
	--Cablecito blanco solito
	attribute loc of RW0: signal is "84";
	--Cablecito blanco solito
	attribute loc of RS0: signal is "12";
	--Cablecito blanco solito
	attribute loc of EN0: signal is "11";
	--Leds rojos
	attribute loc of outcontcc0: signal is "24,23,22,21,20";
end entity ; -- toplcd00
architecture arch of toplcd00 is
signal scomandoc: std_logic_vector(7 downto 0);
signal soutworddd: std_logic_vector(7 downto 0);
signal sRWc, sRSc, sENc: std_logic;
signal sRWcd, sRScd, sENcd: std_logic;
signal sword: std_logic_vector(7 downto 0);-- Para ver en leds la palabra enviada a la lcd
begin
	outwordlcd0<=sword;
	outwordled0<=sword;
	L00: toposcdiv00 port map(
		indiv0=>cdiv0,
		outdiv0=>clk0
	);
	L01: lcdcontconfig00 port map(
		clkcc=>clk0,
		resetcc=>reset0,
		inFlagcc=>outflagc0,
		outcontcc=>outcontcc0,
		outFlagcc=>outflagcc0
	);
	L02: lcdconfig00 port map(
		clkc=>clk0,
		resetc=>reset0,
		inFlagc=>outflagcc0,
		incontc=>outcontcc0,
		comandoc=>scomandoc,
		outFlagc=>outflagc0,
		RWc=>sRSc,
		RSc=>sRSc,
		ENc=>sENc
	);
	L03: lcdcontdata00 port map(
		clkcd=>clk0,
		resetcd=>reset0,
		inFlagcd=>outflagc0,
		outcd=>outcd0,
		RWcd=>sRWcd,
		RScd=>sRScd,
		ENcd=>sENcd,
		outFlagcd=>outflagcd0
	);
	L04: lcddata00 port map(
		clkdd=>clk0,
		resetdd=>reset0,
		inFlagdd=>outflagcd0,
		inFlagcf=>outflagc0,
		indirdd=>outcd0,
		outworddd=>soutworddd,
		outFlagdd=>outflagdd0
	);
	L05: lcdmux00 port map(
		clklm=>clk0,
		resetlm=>reset0,
		inflagclm=>outflagc0,
		inflagdlm=>outflagdd0,
		inwordclm=>scomandoc,
		inworddlm=>soutworddd,
		RWc=>sRWc,
		RSc=>sRSc,
		ENc=>sENc,
		RWd=>sRWcd,
		RSd=>sRScd,
		ENdd=>sENcd,
		outwordlm=>sword,
		RWlm=>RW0,
		RSlm=>RS0,
		ENlm=>EN0
	);
end architecture ; -- arch