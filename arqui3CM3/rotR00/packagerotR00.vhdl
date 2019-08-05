library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
package packagerotR00 is
	component toposcdiv00
		port(
		indiv0:in std_logic_vector (3 downto 0);
		outdiv0:inout std_logic);
	end component;
	component rotR00
		port(
			clks: in std_logic;
			enable: in std_logic;
			--limite: in std_logic_vector(2 downto 0);--Esto es para el desplazamiento de barril.
			ins: in std_logic_vector(7 downto 0);
			outs: out std_logic_vector(7 downto 0));
	end component;
end package packagerotR00;