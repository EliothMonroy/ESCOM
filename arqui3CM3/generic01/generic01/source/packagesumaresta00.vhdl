library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
package packagesumaresta00 is
	component and00
		port(
			Aa: in std_logic;
			Ba: in std_logic;
			Ya: out std_logic
		);
	end component;
	component topfa00
		port(
			A00, B00, C00: in std_logic;
			S00, C01: out std_logic);
	end component;
	component xor00
		port(
			Ax: in std_logic;
			Bx: in std_logic;
			Yx: out std_logic);
	end component;
	component xnor00
		port(
			Anx: in std_logic;
			Bnx: in std_logic;
			Ynx: out std_logic
		);
	end component;	
end packagesumaresta00;