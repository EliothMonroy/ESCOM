library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contconfig00 is
  port(clkcc    : in    std_logic;
       resetcc  : in    std_logic;
       inFlagcc : in    std_logic;
       outcc    : inout std_logic_vector(5 downto 0);--VA HACIA EL EXTERIOR Y HACIA EL MÓDULO "config00"
       outFlagcc: out   std_logic);
end contconfig00;

architecture contconfig0 of contconfig00 is
begin
  pcc: process(clkcc, resetcc, inFlagcc)
  begin
     if (clkcc'event and clkcc = '1') then
	case resetcc is
	     when '0' =>
	          outcc <= "000000";
	          outFlagcc <= '0';
             when '1' =>
	          if (inFlagcc = '0') then--VIENE DEL MÓDULO "config00". SE PONE EN '1' CUANDO TERMINA LA RUTINA DE INICIALIZACIÓN
		     outcc <= outcc + '1';
		     outFlagcc <= '1';--VA HACIA EL MÓDULO "config00" PARA HABILITAR EL ENVÍO DE COMANDOS
		  else
		     outcc <= outcc;
		     outFlagcc <= '1';
		  end if;
	      when others => null;
	 end case;
     end if;
  end process pcc;
end contconfig0;

