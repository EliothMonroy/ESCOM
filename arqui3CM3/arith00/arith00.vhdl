library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity arith00 is
	port(
		SL: in std_logic;--Nos dice si queremos sumar o restar, 0 -> Suma, 1 -> Resta
		Ai: in std_logic_vector(3 downto 0);
		Bi: in std_logic_vector(3 downto 0);
		So: inout std_logic_vector(3 downto 0);
		LED: out std_logic);
		--Puertos
		attribute loc: string;
		--Dip switch 1
		attribute loc of Ai: signal is "42,44,43,45";
		--Dip switch 2
		attribute loc of Bi: signal is "52,55,54,56";
		--Pines leds rojo
		attribute loc of So: signal is "20,19,14,13";
		--Pin de sobrepasamiento
		attribute loc of LED: signal is "24";-- El siguiente ser�a 21
		--Tercer dip switch
		attribute loc of SL: signal is "61";
end arith00;
architecture arith0 of arith00 is
begin
	parith0:process(Ai,Bi)
	begin
		So<=Ai+Bi;
	end process;
end arith0;
