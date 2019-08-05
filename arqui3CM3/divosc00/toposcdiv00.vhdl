library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagediv00.all;
entity toposcdiv00 is
	port(
		indiv0:in std_logic_vector (3 downto 0);
		outdiv0:inout std_logic);
		--Puertos
		attribute loc: string;
		--Dip switch 1 para configurar velocidad
		attribute loc of indiv0: signal is "42,44,43,45";
		--Salida �ltimo led
		attribute loc of outdiv0: signal is "13";
end toposcdiv00;
architecture toposcdiv0 of toposcdiv00 is
signal sclk:std_logic;
begin
	D00:osc00 port map(osc_int=>sclk);
	DO1:div00 port map(
						clkdiv=>sclk,
						indiv=>indiv0,
						outdiv=>outdiv0);
end toposcdiv0;