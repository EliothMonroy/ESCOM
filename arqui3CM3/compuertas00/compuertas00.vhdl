library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity compuertas00 is
	port(
		selector:in std_logic_vector(2 downto 0);
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0));
		--Puertos
		attribute loc: string;
		--Dip switch 1
		attribute loc of A: signal is "42,44,43,45,47,49,48,50";
		--Dip switch 2
		attribute loc of B: signal is "52,55,54,56,57,59,58,60";
		--Pines leds rojo
		attribute loc of Y: signal is "24,23,22,21,20,19,14,13";
		--Dip switch 3 (primeros tres bits izquierda)
		attribute loc of selector: signal is "61,65,62";
		--Pines de leds derecha (azules)
		--"122,121,120,119,117,115,114,113"
		--Led rojo hasta la derecha de los azules
		--"112"
end compuertas00;
architecture compuertas0 of compuertas00 is
begin
	pcom:process(selector,A,B)
	begin
		case selector is
			--And
			when "000" =>
				Y<=A and B;
			--Or
			when "001" =>
				Y<=A or B;
			--Xor
			when "010" =>
				Y<=A xor B;
			--Not
			when "011" =>
				Y<=not(A);
			--Nand
			when "100" =>
				Y<=A nand B;
			--Nor
			when "101" =>
				Y<=A nor B;
			--Xnor
			when "110" =>
				Y<=A xnor B;
			when others => null;
		end case;
	end process;
end compuertas0;
