library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
package packageha00 is
	component and00
		port(
		Aa: in std_logic;
		Ba: in std_logic;
		Ya: out std_logic);
	end component;
	component xor00
		port(
		Ax: in std_logic;
		Bx: in std_logic;
		Yx: out std_logic);
	end component;
end packageha00;