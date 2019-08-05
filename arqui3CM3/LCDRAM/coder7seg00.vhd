library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity coder7seg00 is
  port(wrbuff     : in  std_logic;
       inWordkey  : in  std_logic_vector(6 downto 0);
       inWordmem  : in  std_logic_vector(6 downto 0);
       outWordBuff: out std_logic_vector(6 downto 0));
end coder7seg00;

architecture coder7seg0 of coder7seg00 is
begin
  pbuff: process(wrbuff)
  begin
    case wrbuff is
	  when '0' =>
	     outWordBuff <= inWordkey;
          	  when '1' =>
	     outWordBuff <= inWordmem;
	  when others => null;
	end case;
  end process pbuff;
end coder7seg0;

