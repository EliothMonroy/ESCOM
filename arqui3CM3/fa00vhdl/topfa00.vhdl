library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packagefa00.all;
entity topfa00 is
	port(
		A00, B00, C00: in std_logic;
		S00, C01: out std_logic);
end topfa00;
architecture topfa0 of topfa00 is
signal sint1:std_logic;
signal cint1:std_logic;
signal cint2:std_logic;
begin
	FA01: topha00 port map(
		A0 => A00,
		B0 => B00,
		S0 => sint1,
		C0 => cint1
	);
	FA02: topha00 port map(
		A0 => C00,
		B0 => sint1,
		S0 => S00,
		C0 => cint2
	);
	FA03: or00 port map(
		Ao => cint2,
		Bo => cint1,
		Yo => C01		
	);
end topfa0;
