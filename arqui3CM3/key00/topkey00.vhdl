library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagekey00.all;
entity topkey00 is
	port(
		clk0: inout std_logic;
		cdiv0: in std_logic_vector(3 downto 0);
		en0: in std_logic;
		inkey0: in std_logic_vector(3 downto 0);
		outr0: inout std_logic_vector(3 downto 0);
		outtransist0: out std_logic_vector(3 downto 0);
		outcoder0: out std_logic_vector(6 downto 0)
	);
	--Puertos
	attribute loc: string;
	--Dip switch 1 para configurar velocidad
	attribute loc of cdiv0: signal is "42,44,43,45";
	--Salidas para los transistores:
	attribute loc of outtransist0: signal is "34,35,32,33";
	--Salidas para los segmentos del display (catodo, se prende con unos)
	attribute loc of outcoder0: signal is "142,141,140,139,138,133,132";
	--Salidas tecla presionada
	attribute loc of inkey0:signal is "81,82,77,78";
	--Entradas para el teclado
	attribute loc of outr0:signal is "74,73,76,75";
	--Salida último led
	attribute loc of clk0: signal is "13";
	--Primero tercer dip switch
	attribute loc of en0: signal is "61";
	
end topkey00;
architecture topkey0 of topkey00 is
begin
	K00: toposcdiv00 port map(
		outdiv0=>clk0,
		indiv0=>cdiv0		
	);
	K01: contring00 port map(
		clkr=>clk0,
		enable=>en0,
		outr=>outr0
	);
	K02: coder00 port map(
		clkc=>clk0,
		inkey=>inkey0,
		incont=>outr0,
		outcoder=>outcoder0
	);
	--El último display hacia la derecha 
	outtransist0<="1110";
end topkey0;