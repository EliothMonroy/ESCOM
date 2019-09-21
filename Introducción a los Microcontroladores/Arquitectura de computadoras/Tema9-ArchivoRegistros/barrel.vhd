----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:15:38 10/12/2017 
-- Design Name: 
-- Module Name:    barrel - programa 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity barrel is
    Port ( DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           SHIFT : in  STD_LOGIC_VECTOR (2 downto 0));
end barrel;

architecture programa of barrel is
begin
	
	PSHIFT : PROCESS( SHIFT, DATA_IN )
	VARIABLE SHIFT_DATA : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	VARIABLE INDICE : INTEGER RANGE -8 TO 7;
	BEGIN
		SHIFT_DATA := DATA_IN;
		FOR I IN 0 TO 2 LOOP
			FOR J IN 7 DOWNTO 0 LOOP
				IF( SHIFT(I) = '1' )THEN
					INDICE := J - 2**I;
					IF( INDICE < 0 )THEN
						SHIFT_DATA(J) := '0';
					ELSE
						SHIFT_DATA(J) := SHIFT_DATA(INDICE);
					END IF;
				END IF;
			END LOOP;
		END LOOP;
		DATA_OUT <= SHIFT_DATA;
	END PROCESS PSHIFT;

end programa;

