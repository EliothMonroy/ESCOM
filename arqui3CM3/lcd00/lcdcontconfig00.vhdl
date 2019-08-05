library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity lcdcontconfig00 is
	port(
		clkcc: in std_logic;
		resetcc: in std_logic;
		inFlagcc:in std_logic;--Se cuenta siempre que la bandera este en 0
		outcontcc: inout std_logic_vector(4 downto 0);--Para contar hasta 32 bits
		outFlagcc: out std_logic
	);
end entity ; -- lcdcontconfig00
architecture arch of lcdcontconfig00 is
begin
	pcontconfig : process(clkcc)
	begin
		if (clkcc'event and clkcc='1') then
			case(resetcc) is
				when '0' =>
					outcontcc<=(others=>'0');
					outFlagcc<='0';--Desabilitado la entrada de comandos
				when '1' =>
					case(inFlagcc) is
						when '0' =>
							outcontcc<=outcontcc+'1';--Incrementamos el contador
							outFlagcc<='1';
						when '1' =>
							outcontcc<=outcontcc;
							outFlagcc<='0';--Se detinene el contador y deshabilitamos comandos
						when others =>null;
					end case ;
				when others =>null;
			end case ;
		end if;
	end process ; -- pcontconfig
end architecture ; -- arch