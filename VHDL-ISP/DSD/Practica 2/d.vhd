-- Flip Flop tipo D (es disparado con un flanco positivo)
library ieee;
use ieee.std_logic_1164.all;
entity fdd is port(
	D, clk: in std_logic; -- D es la entrada y clk señal de relog
	Q: 		out std_logic); -- Q es la salida
	--Puertos
	attribute loc: string;
	attribute loc of D: signal is "p4";
	attribute loc of clk: signal is "p5";
	attribute loc of Q: signal is "p6";
end fdd;
architecture arq_ffd of ffd is
begin
	process (clk) begin
	--cada vez que cambie la señal de relog se ejecutará esto
		if(clk'event and clk='1') then
		-- Si la señal de relog tiene un cambio al flanco positivo entonces
			Q<=D -- Le asignamos el valor a la salida
		end if;
	end process;
end arq_ffd;
