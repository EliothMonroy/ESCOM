library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagerotL00.all;
entity toprotL00 is
	port(
		clk0: inout std_logic;
		cdiv0: in std_logic_vector(3 downto 0);
		en0: in std_logic;
		ins0:in std_logic_vector(7 downto 0);
		outs0:out std_logic_vector(7 downto 0));
		--Puertos
		attribute loc: string;
		--Dip switch 1 (Control del oscilador)
		attribute loc of cdiv0: signal is "42,44,43,45";
		--Salidas para los transistores:
		attribute loc of ins0: signal is "52,55,54,56,57,59,58,60";
		--Leds
		attribute loc of outs0: signal is "24,23,22,21,20,19,14,13";
		--Dip switch 3 
		attribute loc of en0: signal is "61";
end toprotL00;
architecture toprotL0 of toprotL00 is
begin
	--Señal de relog
	W00: toposcdiv00 port map(
		outdiv0 => clk0,
		indiv0=>cdiv0
	);
	--Aquí va el shiftL
	W01: rotL00 port map(
			clks=>clk0,
			enable=>en0,
			ins=>ins0,
			outs=>outs0
	);
end toprotL0;