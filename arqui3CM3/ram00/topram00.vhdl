library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packageram00.all;
entity topram00 is
	port(
		clk0: inout std_logic;
		enable0: in std_logic;
		cdiv0:in std_logic_vector(3 downto 0);
		rw0:in std_logic;
		inkey0:in std_logic_vector(3 downto 0);
		outcrLed0: inout std_logic_vector(3 downto 0); --Salida led anillo
		outcrK0: inout std_logic_vector(3 downto 0); -- Salida teclado
		outcontW0: inout std_logic_vector(4 downto 0);
		outcontR0: inout std_logic_vector(4 downto 0);
		outWord0: out std_logic_vector(6 downto 0);
		outtransist0: out std_logic_vector(3 downto 0);
		outFlag0: inout std_logic
	);
	--Puertos
	attribute loc: string;
	--Dip switch 1 para configurar velocidad
	attribute loc of cdiv0: signal is "42,44,43,45";
	--Salidas para los transistores:
	attribute loc of outtransist0: signal is "34,35,32,33";
	--Salidas para los segmentos del display (catodo, se prende con unos)
	attribute loc of outWord0: signal is "142,141,140,139,138,133,132";
	--Salidas tecla presionada
	attribute loc of inkey0:signal is "81,82,77,78";
	--Entradas para el teclado
	attribute loc of outcrK0:signal is "74,73,76,75";
	--Salida último led
	attribute loc of clk0: signal is "13";
	--Primero tercer dip switch
	attribute loc of enable0: signal is "61";
	--Read Write
	attribute loc of rw0: signal is "65";
	--Conteo escritura
	attribute loc of outcontW0: signal is "24,23,22,21,20";
	--Conteo lectura
	attribute loc of outcontR0: signal is "122,121,120,119,117";
	--Contador anillo
	attribute loc of outcrLed0: signal is "115,114,113,112";
	--Salida bandera
	attribute loc of outFlag0: signal is "14";
end entity ; -- topram00
architecture topram0 of topram00 is
signal soutcr: std_logic_vector(3 downto 0);
signal soutcodercd:std_logic_vector(6 downto 0);
signal soutwordra:std_logic_vector(6 downto 0);
begin
	RA00: toposcdiv00 port map(
		outdiv0=>clk0,
		indiv0=>cdiv0
	);
	RA01: contring00 port map(
		clkr=>clk0,
		enable=>enable0,
		rw=>rw0,
		outr=>soutcr
	);
	RA02: coder00 port map(
		clkcd=>clk0,
		enablecd=>enable0,
		rwcd=>rw0,
		inkeycd=>inkey0,
		incontcd=>soutcr,
		outcontwcd=>outcontW0,
		outcodercd=>soutcodercd,
		outFlagcd =>outFlag0
	);
	RA03: ram00 port map(
		clkra=>clk0,
		enablera=>enable0,
		rwra=>rw0,
		indirWra=>outcontW0,
		indirRra=>outcontR0,
		inwordra=>soutcodercd,
		outwordra=>soutwordra,
		inFlagra=>outFlag0
	);
	RA04: mux00 port map(
		rwrm=>rw0,
		enablem=>enable0,
		inwordkeym=>soutcodercd,
		inwordramm=>soutwordra,
		outwordm=>outWord0
	);
	RA05: contReadRa00 port map(
		clkrd=>clk0,
		enablerd=>enable0,
		rwrd=>rw0,
		incontWrd=>outcontW0,
		outcontRrd=>outcontR0
	);
	outcrLed0<=soutcr;
	outcrK0<=soutcr;
	outtransist0<="1110";--Son displays de catodo
end architecture ; -- topram0