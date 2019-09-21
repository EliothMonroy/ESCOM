library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity FC4 is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           ADD : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (7 downto 0));
ATTRIBUTE IOB : STRING;
ATTRIBUTE IOB OF S : SIGNAL IS "TRUE";
end FC4;

-- EL ATRIBUTO IOB, PERMITE USAR LOS FF'S DE LOS IOB'S EN LUGAR DE 
-- LOS FF'S DE LOS SLICES, EN ESTE EJEMPLO LOS FF'S DE LA SEÑAL S
-- SE TOMAN DE IOB
architecture PROGRAMA of FC4 is
begin
	PAU : PROCESS( CLK )
	BEGIN
		IF( RISING_EDGE( CLK ) )THEN
			IF( ADD = '1' )THEN
				S <= A + B;
			ELSE
				S <= A - B;
			END IF;
		END IF;
	END PROCESS PAU;
end PROGRAMA;





