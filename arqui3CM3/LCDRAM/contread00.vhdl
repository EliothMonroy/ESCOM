library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity contread00 is
  port(clkcont    : in    std_logic;
       wrCont     : in    std_logic;
       inFlagcw : in    std_logic;-- VIENE DEL MÓDULO "config00"
       inFlagx  : in    std_logic;-- viene del módulo "write00"
       RWcw     : out   std_logic;
       RScw     : out   std_logic;
       ENcw     : out   std_logic;
       outFlagcw: out   std_logic;
       inContKey  : in    std_logic_vector(3 downto 0);
       outContRead: inout std_logic_vector(3 downto 0));
end contread00;

architecture contread0 of contread00 is
begin
  pcont: process(clkcont, wrCont,inFlagcw)
  begin
     if (clkcont'event and clkcont = '1') then
       case wrCont is
         when '0' =>
           outContRead <= "0000";
           outFlagcw   <= '1';
         when '1' =>
		case inFlagcw is
                  when '1' =>
			   if (outContRead <= inContKey) then
			          if (inFlagx = '1') then
				     outContRead <= outContRead + '1';
				     outFlagcw <= '1';
				     RWcw <= '0';
				     RScw <= '1';
				     ENcw <= '0';
				  elsif (inFlagx = '0') then
				     outFlagcw <= '0';
				     RWcw <= '0';
				     RScw <= '1';
				     ENcw <= '1';
				  end if;
		
			   else
			     outContRead <= outContRead;
			   end if;
	             when others => null;
		end case;
	 when others => null;
       end case;
     end if;
  end process pcont;
end contread0;

