library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packageword00.all;

entity topword00 is
	port(
		clk0: inout std_logic;
		cdiv0: in std_logic_vector(3 downto 0);
		en0: in std_logic;
		outtransist0: inout std_logic_vector(3 downto 0);
		outcoder0: out std_logic_vector(6 downto 0));
		--Puertos
		attribute loc: string;
		--Dip switch 1 (Control del oscilador)
		attribute loc of cdiv0: signal is "42,44,43,45";
		--Salidas para los transistores:
		attribute loc of outtransist0: signal is "34,35,32,33";
		--Salidas para los segmentos del display (catodo, se prende con unos)
		attribute loc of outcoder0: signal is "142,141,140,139,138,133,132";
		--Dip switch 3 
		attribute loc of en0: signal is "61";
		attribute loc of clk0: signal is "24";
end topword00;
architecture topword0 of topword00 is
begin
	W00: toposcdiv00 port map(outdiv0 => clk0,
								indiv0=>cdiv0);
	W01: contring00 port map(clkr=>clk0, enable=>en0, outr=>outtransist0);
	W02: coder00 port map(incont=>outtransist0, outcoder=>outcoder0);
end topword0;