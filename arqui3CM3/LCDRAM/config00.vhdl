library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity config00 is
  port(resetc  : in  std_logic;
       inFlagc : in  std_logic;-- VIENE DEL MÓDULO "contconfig00"
       incontc : in  std_logic_vector(5 downto 0);
       outWordc: out std_logic_vector(7 downto 0);
       RWc     : out std_logic;
       RSc     : out std_logic;
       ENc     : out std_logic;
       outFlagc: out std_logic);-- VA HACIA LOS MÓDULOS "contconfig00" Y  HACIA "contw00" Y "write00"
end config00;

architecture config0 of config00 is
begin
  pconfig: process(resetc, inFlagc, incontc)
  begin
     case resetc is
         when '0' =>
              outWordc <= "00000000";
	      RWc <= '0';
	      RSc <= '0';
	      ENc <= '0';
              outFlagc <= '0';
	 when '1' =>
	      case inFlagc is
	           when '1' =>
		       case incontc is
			   when "000000" =>
                  outWordc <= "00111100";-- 0 0 1 D/L  N F X X:  FUNCTION SET
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '1';

			   when "000010" =>
			          outWordc <= "00111100";-- 0 0 1 D/L  N F X X:  FUNCTION SET
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '1';
			   when "000011" =>
			          outWordc <= "00111100";-- 0 0 1 D/L  N F X X:  FUNCTION SET
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '0';

			   when "000100" =>
			          outWordc <= "00000001";-- CLEAR DISPLAY
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '1';
			   when "000101" =>
			          outWordc <= "00000001";-- CLEAR DISPLAY
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '0';
			   when "000110" =>
			          outWordc <= "00000011";-- RETURN TO HOME
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '1';
			   when "000111" =>
			          outWordc <= "00000011";-- RETURN TO HOME
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '0';
			   when "001000" =>
			          outWordc <= "00000110";--0 0 0 0 0 1 I/D S: ENTRY MODE SET
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '1';
			   when "001001" =>
			          outWordc <= "00000110";--0 0 0 0 0 1 I/D S: ENTRY MODE SET
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '0';

			   when "001010" =>
			          outWordc <= "00001111";--0 0 0 0 1 D C B: DISPLAY ON/OFF CONTROL
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '1';
			   when "001011" =>
			          outWordc <= "00001111";--0 0 0 0 1 D C B: DISPLAY ON/OFF CONTROL
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '0';


			   when "001100" =>
			          outWordc <= "00011100";--0 0 0 1 S/C  R/L X X: CURSOR OR DISPLAY SHIFT
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '1';
			   when "001101" =>
			          outWordc <= "00011100";--0 0 0 1 S/C  R/L X X: CURSOR OR DISPLAY SHIFT
				  outFlagc <= '1';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '0';


			   when "001110" =>
			          outWordc <= "10010100";-- 1 X X X X X X X: SET DDRAM ADDRESS
				  outFlagc <= '0';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '1';
			   when "001111" =>
			          outWordc <= "10010100";-- 1 X X X X X X X: SET DDRAM ADDRESS
				  outFlagc <= '1';
				  RWc <= '0';
				  RSc <= '0';
				  ENc <= '0';

			   when others => null;
			end case;--FIN DEL CASE DE LA ENTRADA "incontc"
		    when '0' =>
		        outFlagc <= '0';
		    when others => null;
	        end case;--FIN DEL CASE DE LA ENTRADA "inFlagc"
	    when others => null;
	 end case;--FIN DEL CASE DE LA ENTRADA "reset"
  end process pconfig;
end config0;

