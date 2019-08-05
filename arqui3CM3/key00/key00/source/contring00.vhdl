library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity contring00 is
	port(
			clkr:in std_logic;
			enable: in std_logic;
			outr: out std_logic_vector(3 downto 0));
end contring00;
architecture contring0 of contring00 is
signal soutr: std_logic_vector(3 downto 0);
begin
	pring: process(clkr)
	begin
		if(clkr'event and clkr='1') then
			case enable is
				when '0' =>
					soutr<="1000";
					outr<="0000";
				when '1' =>
					soutr(3)<=soutr(0);
					soutr(2 downto 0)<=soutr(3 downto 1);
					outr<=soutr;
				when others =>null;
			end case;
		end if;
	end process pring;
end contring0;