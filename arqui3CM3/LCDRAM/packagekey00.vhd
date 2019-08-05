library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

package packagekey00 is

  component contring00
    port(clkr  : in  std_logic;
	 resetr: in  std_logic;
         outr  : out std_logic_vector(3 downto 0));
  end component;
  
  component coder00
    port(clkc    : in    std_logic;
	 inFlago : in    std_logic;
	 resetc  : in    std_logic;
         incontc : in    std_logic_vector(3 downto 0);
	 outcontc: inout std_logic_vector(3 downto 0);
	 inkeyc  : in    std_logic_vector(3 downto 0);
	 offtranc: out   std_logic_vector(3 downto 0);
         out7segc: out   std_logic_vector(6 downto 0);
	 outFlago: out   std_logic);
  end component;

end packagekey00;

