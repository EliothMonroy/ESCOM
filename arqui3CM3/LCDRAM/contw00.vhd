library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contw00 is
  port(clkcw    : in    std_logic;
       inFlagcw : in    std_logic;-- VIENE DEL MÓDULO "config00"
       inFlagx  : in    std_logic;-- viene del módulo "write00"
       outcontcw: inout std_logic_vector(5 downto 0);-- VA HACIA EL MÓDULO "write00" Y HACIA EL EXTERIOR
       RWcw     : out   std_logic;
       RScw     : out   std_logic;
       ENcw     : out   std_logic;
       outFlagcw: out   std_logic);
end contw00;

architecture contw0 of contw00 is
begin 
  pcw: process(clkcw, inFlagcw)
  begin
    if (clkcw'event and clkcw = '1') then
       case inFlagcw is
           when '0' =>
	       outcontcw <= "000000";
	       outFlagcw <= '1';
	   when '1' =>
	       if (outcontcw < "100000") then
	          if (inFlagx = '1') then
		     outcontcw <= outcontcw + '1';
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
	        end if;
	    when others => null;
	 end case;
     end if;
  end process pcw;
end contw0;

