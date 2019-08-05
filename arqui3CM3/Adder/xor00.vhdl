library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity xor00 is
	port(
		Axo: in std_logic;
		Bxo: in std_logic;
		Yxo: out std_logic;);
end xor00;
architecture xor0 of xor00 is
begin
	Yxo<=Axo xor Bxo;
end;