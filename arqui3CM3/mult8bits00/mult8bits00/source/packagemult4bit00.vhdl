library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;

package packagemult4bit00 is

  component and00
    port(
       Aa: in std_logic;
	   Ba: in std_logic;
       Ya : out std_logic);
  end component;
  
  component fa00
    port(
       C00, A00, B00: in std_logic;
	   S00, C01: out std_logic);
  end component;

end packagemult4bit00;