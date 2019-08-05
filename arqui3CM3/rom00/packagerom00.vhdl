library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
package packagerom00 is
	component toposcdiv00
		port(
			indiv0:in std_logic_vector (3 downto 0);
			outdiv0:inout std_logic
		);
	end component;
	component contReadRo00
		port(
			clkro: in std_logic;
			enablero: in std_logic;
			--limitero:in std_logic_vector
			outcontro: inout std_logic_vector (3 downto 0)
		);
	end component;
	component rom00
		port(
			indirrom:in std_logic_vector(3 downto 0);
			clkrom:in std_logic;
			enablerom:in std_logic;
			outwordrom: inout std_logic_vector(6 downto 0)
		);
	end component;
end package ; -- packagerom00 