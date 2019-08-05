library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;
use packageosc00.all;

entity toposc00 is
  port(
	   cdiv0: in std_logic_vector(3 downto 0);
       outdiv0: inout std_logic);
end toposc00;

architecture toposc0 of toposc00 is
signal soscout0: std_logic;
begin

  OS00: osc00 port map(osc_int => soscout0);
  
  OS01: div00 port map(clkdiv => soscout0,
                       indiv => cdiv0,
                       outdiv => outdiv0);
  
  
end toposc0;