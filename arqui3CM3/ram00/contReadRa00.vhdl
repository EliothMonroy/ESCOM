library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity contReadRa00 is 
	port(
		clkrd: in std_logic;
		enablerd: in std_logic;
		rwrd: in std_logic;
		incontWrd: in std_logic_vector(4 downto 0);
		outcontRrd: inout std_logic_vector(4 downto 0)
	);
end contReadRa00;
architecture contReadRa0 of contReadRa00 is
begin
	pcontr : process(clkrd)
	begin
		if (clkrd'event and clkrd='1') then
			case(enablerd) is
				when '0' =>
					outcontRrd<=(others=>'0');--Inicializamos en cero el generador
				when '1' =>
					case(rwrd) is
						when '0' =>
							outcontRrd<=(others=>'0');--Inicializamos en cero el generador
						when '1' =>--Caso de lectura según la tablita
							if (outcontRrd<incontWrd) then
								outcontRrd<=outcontRrd+'1';
							else
								outcontRrd<=outcontRrd;
							end if ;
						when others =>null;
					end case ;
				when others =>null;
			end case ;
		end if ;
	end process ; -- pcontr
end contReadRa0;