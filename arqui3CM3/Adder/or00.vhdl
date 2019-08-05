library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.components.all;
entity or is
	port(
		Ao: in std_logic;
		Bo: in std_logic;
		Yo: out std_logic;);
end or;
architecture or0 of or is
begin
	Yo<=Ao and Bo;
end;