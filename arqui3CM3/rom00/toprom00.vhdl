library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagerom00.all;
entity toprom00 is
	port(
		cdiv0: in std_logic_vector(3 downto 0);
		enable0: in std_logic;
		clk0: inout std_logic;
		outcontro:inout std_logic_vector(3 downto 0);
		outtransist0:out std_logic_vector(3 downto 0);
		outWord0:inout std_logic_vector(6 downto 0)
	);
	--Puertos
	attribute loc: string;
	--Dip switch 1 para configurar velocidad
	attribute loc of cdiv0: signal is "42,44,43,45";
	--Salidas para los transistores:
	attribute loc of outtransist0: signal is "34,35,32,33";
	--Salidas para los segmentos del display (catodo, se prende con unos)
	attribute loc of outWord0: signal is "142,141,140,139,138,133,132";
	--Conteo lectura
	attribute loc of outcontro: signal is "24,23,22,21";
	--Salida último led
	attribute loc of clk0: signal is "13";
	--Primero tercer dip switch
	attribute loc of enable0: signal is "61";
end entity ; -- toprom00
architecture toprom0 of toprom00 is
signal soutcontro: std_logic_vector(3 downto 0);
begin
	RO00: toposcdiv00 port map(
		indiv0=>cdiv0,
		outdiv0=>clk0
	);
	RO01: contReadRo00 port map(
		clkro=>clk0,
		enablero=>enable0,
		outcontro=>outcontro
	);
	RO02: rom00 port map(
		indirrom=>outcontro,
		clkrom=>clk0,
		enablerom=>enable0,
		outwordrom=>outWord0
	);
	outtransist0<="1110";--Son displays de catodo
end architecture ; -- toprom0