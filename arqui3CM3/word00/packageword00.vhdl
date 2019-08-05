library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
package packageword00 is
	component toposcdiv00
		port(
		indiv0:in std_logic_vector (3 downto 0);
		outdiv0:inout std_logic);
	end component;
	component contring00
		port(
			clkr:in std_logic;
			enable: in std_logic;
			outr: out std_logic_vector(3 downto 0));
	end component;
	component coder00
		port(
		incont: in std_logic_vector(3 downto 0);
		outcoder: out std_logic_vector(6 downto 0));
	end component;
end package packageword00;