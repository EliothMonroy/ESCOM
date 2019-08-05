library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packageha00.all;
entity topha00 is
	port(
		A0, B0: in std_logic;
		S0, C0: out std_logic);
end topha00;
architecture topha0 of topha00 is
begin
	HA01: and00 port map(
						Aa => A0,
                        Ba => B0,
                        Ya => C0);					  
	HA02: xor00 port map(
						Ax => A0,
                        Bx => B0,
                        Yx => S0);
end topha0;
