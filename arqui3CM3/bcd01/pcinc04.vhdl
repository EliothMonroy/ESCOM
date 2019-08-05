library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pcinc04 is

port( 
	clkpc: in std_logic ;
	resetpc: in std_logic ;
        --outFlagreset: out std_logic;
	incode: in std_logic_vector ( 3 downto 0 );
	outpc: inout std_logic_vector ( 3 downto 0 );
	inFlagAC8bit: in std_logic ;
	inFlagAC12bit: in std_logic ;
	flagiter: in std_logic ;
	outFlagpc: out std_logic  );

end;

architecture pcinc0 of pcinc04 is
begin
  pcprocess: process(resetpc, inFlagAC8bit)
    begin
      if (clkpc'event and clkpc = '1') then
         if (resetpc = '0') then
             outpc <= "0000";
             outFlagpc <= '0';
             --outFlagreset <= '1';
         --EL SIGUIENTE ES EL MÓDULO DE INICIALIZACIÓN
         elsif (inFlagAC8bit = '1' and incode = "0000") then
             outpc <= outpc + 1;
             outFlagpc <= '1';
         elsif (inFlagAC8bit = '0' and incode = "0000") then
             outpc <= outpc + 0;
             outFlagpc <= '0';
         --EL SIGUIENTE ES EL MÓDULO DE portAB
         elsif (inFlagAC8bit = '1' and incode = "0001") then
             outpc <= outpc + 1;
             outFlagpc <= '1';
         elsif (inFlagAC8bit = '0' and incode = "0001") then
             outpc <= outpc + 0;
             outFlagpc <= '0';
         --EL SIGUIENTE MÓDULO ES EL DE SUSTITUCIÓN
         elsif (inFlagAC12bit = '1' and incode = "0010") then
             outpc <= outpc + 1;
             outFlagpc <= '1';
         elsif (inFlagAC12bit = '0' and incode = "0010") then
             outpc <= outpc + 0;
             outFlagpc <= '0';

         elsif (flagiter = '1') then
             outpc <= outpc + 0;
             outFlagpc <= '0';


         --EL SIGUIENTE ES EL MÓDULO QUE COMPARA Y SUMA
         elsif (inFlagAC12bit = '1' and incode = "0011") then
             outpc <= outpc + 1;
             outFlagpc <= '1';
         elsif (inFlagAC12bit = '0' and incode = "0011") then
             outpc <= outpc + 0;
             outFlagpc <= '0';
         --EL SIGUIENTE ES EL EL MÓDULO QUE DESPLAZA EN 8 BITS
         elsif (inFlagAC8bit = '1' and incode = "0100") then
             outpc <= outpc + 1;
             outFlagpc <= '1';
         elsif (inFlagAC8bit = '0' and incode = "0100") then
             outpc <= outpc + 0;
             outFlagpc <= '0';
         --EL SIGUIENTE ES EL EL MÓDULO QUE DESPLAZA EN 12 BITS
         elsif (inFlagAC12bit = '1' and incode = "0101") then
             outpc <= outpc + 1;
             outFlagpc <= '1';
         elsif (inFlagAC12bit = '0' and incode = "0101") then
             outpc <= outpc + 0;
             outFlagpc <= '0';

         else
             outpc <= "0010";
             outFlagpc <= '1';
         end if;
      end if;
    end process pcprocess;
end pcinc0;
