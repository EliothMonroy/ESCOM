library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity mux00 is
	port(
		entrada01:in std_logic_vector(2 downto 0);
		entrada02:in std_logic_vector(2 downto 0);
		entrada03:in std_logic_vector(2 downto 0);
		selector:in std_logic_vector(1 downto 0);
		salida:out std_logic_vector(2 downto 0));
		--Puertos
		attribute loc: string;
		attribute loc of entrada01: signal is "42,44,43";
		attribute loc of entrada02: signal is "45,47,49";
		attribute loc of entrada03: signal is "52,55,54";
		attribute loc of selector: signal is "48,50";
		attribute loc of salida: signal is "19,14,13";
end mux00;
architecture mux0 of mux00 is
begin
	pmux:process(selector,entrada01,entrada02,entrada03)
	begin
		case selector is
			--And
			when "00" =>
				salida<=entrada01;
			when "01" =>
				salida<=entrada02;
			when "10" =>
				salida<=entrada03;
			when others => null;
		end case;
	end process;
end mux0;
