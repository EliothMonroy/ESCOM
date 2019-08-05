library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity xnor00 is
	port(
		Axn: in std_logic;
		Bxn: in std_logic;
		Yxn: out std_logic);
end xnor00;
architecture xnor0 of xnor00 is
begin
	Yxn<=Axn xnor Bxn;
end;