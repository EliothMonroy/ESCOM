library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity xnor00 is
	port(
		Anx: in std_logic;
		Bnx: in std_logic;
		Ynx: out std_logic);
		
end xnor00;
architecture xnor0 of xnor00 is
begin
	Ynx<=Anx xnor Bnx;
end xnor0;
