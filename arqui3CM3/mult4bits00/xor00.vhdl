library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.components.all;

entity xor00 is
  port(
       Ax: in std_logic;
	   Bx: in std_logic;
       Yx: out std_logic);
end xor00;

architecture xor0 of xor00 is
begin
  Yx <= Ax xor Bx;
end xor0;