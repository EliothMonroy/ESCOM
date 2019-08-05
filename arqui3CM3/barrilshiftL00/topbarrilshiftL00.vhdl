library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagebarrilshiftL00.all;
entity topbarrilshiftL00 is
	port(
		clk0: inout std_logic;
		cdiv0: in std_logic_vector(3 downto 0);
		en0: in std_logic;
		lim0:in std_logic_vector(3 downto 0);
		ins0:in std_logic_vector(7 downto 0);
		outs0:out std_logic_vector(7 downto 0));
		--Puertos
		attribute loc: string;
		--Dip switch 1 (Control del oscilador)
		attribute loc of cdiv0: signal is "42,44,43,45";
		--Dip switch 1 (Limite), son los últimos tres bits
		attribute loc of lim0: signal is "47,49,48,50";
		--Entradas dip switch 2:
		attribute loc of ins0: signal is "52,55,54,56,57,59,58,60";
		--Leds
		attribute loc of outs0: signal is "24,23,22,21,20,19,14,13";
		--Dip switch 3 
		attribute loc of en0: signal is "61";
		
end topbarrilshiftL00;
architecture topbarrilshiftL0 of topbarrilshiftL00 is
begin
	--Señal de relog
	W00: toposcdiv00 port map(
		outdiv0 => clk0,
		indiv0=>cdiv0
	);
	--Aquí va el shiftL
	W01: barrilshiftL00 port map(
			clks=>clk0,
			enable=>en0,
			limite=>lim0,
			ins=>ins0,
			outs=>outs0
	);
end topbarrilshiftL0;