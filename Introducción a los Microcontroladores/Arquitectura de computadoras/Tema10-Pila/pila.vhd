----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:26:22 10/23/2017 
-- Design Name: 
-- Module Name:    pila - programa 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pila is
    Port ( D : in  STD_LOGIC_VECTOR (15 downto 0);
           Q : out  STD_LOGIC_VECTOR (15 downto 0);
           CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           UP : in  STD_LOGIC;
           DW : in  STD_LOGIC;
           WPC : in  STD_LOGIC);
end pila;

architecture programa of pila is
TYPE CONTADORES IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
begin

	PPILA : PROCESS( CLK, CLR )
	VARIABLE SP : INTEGER RANGE 0 TO 7;
	VARIABLE PCS : CONTADORES;
	BEGIN
		IF( CLR = '1' )THEN
			SP := 0;
			PCS := (OTHERS => (OTHERS => '0'));
		ELSIF( RISING_EDGE(CLK) )THEN
			IF( WPC = '1' AND UP = '0' AND DW = '0' )THEN		-- BRINCOS 
				PCS(SP) := D;
			ELSIF( WPC = '1' AND UP = '1' AND DW = '0' )THEN	-- CALL
				SP := SP + 1;
				PCS(SP) := D;
			ELSIF( WPC = '0' AND UP = '0' AND DW = '1' )THEN 	-- RET
				SP := SP - 1;
				PCS(SP) := PCS(SP) + 1;
			ELSIF( WPC = '0' AND UP = '0' AND DW = '0' )THEN 	-- INCREMENTO
				PCS(SP) := PCS(SP) + 1;
			END IF;			
		END IF;
		Q <= PCS(SP);
	END PROCESS PPILA;

end programa;

