library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity contReadRo00 is
	port(
		clkro: in std_logic;
		enablero: in std_logic;
		--limitero:in std_logic_vector
		outcontro: inout std_logic_vector (3 downto 0)
	);
end entity ; -- contReadRo00
architecture contReadRo0 of contReadRo00 is
begin
	pcontrom : process(clkro, enablero)
	begin
		if (clkro'event and clkro='1') then
			case(enablero) is
				when '0' =>
					outcontro<="0000";
				when '1' =>
					if (outcontro<"1011") then
						outcontro<=outcontro+'1';
					else
						outcontro<=outcontro;
					end if ;
				when others =>null;
			end case ;
		end if ;
	end process ; -- pcontrom
end architecture ; -- contReadRo0