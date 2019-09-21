----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:58:12 11/23/2017 
-- Design Name: 
-- Module Name:    ESTADO - REGISTRO 
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

entity ESTADO is
    Port ( BANDERAS : in  STD_LOGIC_VECTOR (3 downto 0);
           RBANDERAS : out  STD_LOGIC_VECTOR (3 downto 0);
           LF : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC);
end ESTADO;

architecture REGISTRO of ESTADO is

begin
	PREG : PROCESS(CLK, CLR)
	BEGIN
		IF( CLR = '1' )THEN
			RBANDERAS <= (OTHERS => '0');
		ELSIF( FALLING_EDGE(CLK) )THEN
			IF( LF = '1' )THEN
				RBANDERAS <= BANDERAS;
			END IF;
		END IF;
	END PROCESS PREG;

end REGISTRO;

