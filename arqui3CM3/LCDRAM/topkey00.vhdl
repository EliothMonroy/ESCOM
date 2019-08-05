library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use packagekey00.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity topkey00 is
  port(clkk    : in    std_logic;
       resetk  : in    std_logic;
       inkeyk  : in    std_logic_vector(3 downto 0);
       inFlagk : in    std_logic;
       outcontk: inout std_logic_vector(3 downto 0);
       out7segk: out   std_logic_vector(7 downto 0);
       outrk   : inout std_logic_vector(3 downto 0);
       outFlagk: out   std_logic);
end topkey00;

architecture topkey0 of topkey00 is
begin

  K01: contring00 port map(clkr => clkk,
                           resetr => resetk,
						   outr => outrk);
  
  K02: coder00 port map(clkc     => clkk,
                        resetc   => resetk,
			inkeyc   => inkeyk,
			inflago  => inFlagk,
			incontc  => outrk,
			outcontc => outcontk,
			out7segc => out7segk,
                        outFlago => outFlagk);
end topkey0;

