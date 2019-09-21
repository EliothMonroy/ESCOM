----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:08:24 11/23/2017 
-- Design Name: 
-- Module Name:    FSMCONTROL - PROGRAMA 
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

entity FSMCONTROL is
    Port ( SM : out  STD_LOGIC;
           SDOPC : out  STD_LOGIC;
           TIPOR : in  STD_LOGIC;
           BEQI : in  STD_LOGIC;
           BNEQI : in  STD_LOGIC;
           BLTI : in  STD_LOGIC;
           BLETI : in  STD_LOGIC;
           BGTI : in  STD_LOGIC;
           BGETI : in  STD_LOGIC;
           EQ : in  STD_LOGIC;
           NEQ : in  STD_LOGIC;
           LT : in  STD_LOGIC;
           LE : in  STD_LOGIC;
           GTI : in  STD_LOGIC;
           GET : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           NA : in  STD_LOGIC);
end FSMCONTROL;

architecture PROGRAMA of FSMCONTROL is
TYPE ESTADOS IS (A);
SIGNAL EDO_ACT, EDO_SGTE : ESTADOS;
begin
	AUTOMATA : PROCESS( EDO_ACT, TIPOR, BEQI, ...  )
	BEGIN
		SM    <= '0';
		SDOPC <= '0';
		CASE EDO_ACT IS
			WHEN A =>
				IF( TIPOR = '1' )THEN
					EDO_SGTE <= A;
				ELSE
					IF( BEQI = '1' )THEN
						IF( NA = '1' )THEN
							SM <= '1';
							EDO_SGTE <= A;
						ELSE
							IF( EQ = '1' )THEN
								SM <= '1';
								SDOPC <= '1';
								EDO_SGTE <= A;
							ELSE
								SM <= '1';
								EDO_SGTE <= A;
								--CONTINUARA...
							END IF;
						END IF;
					ELSE
						
					END IF;
				END IF;
		END CASE;
	END PROCESS AUTOMATA;


	TRANSICION : PROCESS( )
	BEGIN
	
	END PROCESS TRANSICION;
end PROGRAMA;

