----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:58:36 10/26/2017 
-- Design Name: 
-- Module Name:    CONTROL - UNIDAD 
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

entity CONTROL is
    Port ( CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           INI : in  STD_LOGIC;
           Z : in  STD_LOGIC;
           A0 : in  STD_LOGIC;
           LA : out  STD_LOGIC;
           SH : out  STD_LOGIC;
           LB : out  STD_LOGIC;
           IB : out  STD_LOGIC;
           SD : out  STD_LOGIC);
end CONTROL;

architecture UNIDAD of CONTROL is
TYPE ESTADOS IS ( A, B, C );
SIGNAL EDO_ACT, EDO_SGTE : ESTADOS;
begin
	AUTOMATA : PROCESS( EDO_ACT, INI, Z, A0 )
	BEGIN
		LA <= '0';
		SH <= '0';
		LB <= '0';
		IB <= '0';
		SD <= '0';
		CASE EDO_ACT IS
			WHEN A => LB <= '1';
				IF( INI = '0' )THEN
					LA <= '1';
					EDO_SGTE <= A;
				ELSE
					EDO_SGTE <= B;
				END IF;
			WHEN B => SH <= '1';
				IF( Z = '1' )THEN
					EDO_SGTE <= C;
				ELSE
					IF( A0 = '1' )THEN
						IB <= '1';
						EDO_SGTE <= B;
					ELSE
						EDO_SGTE <= B;
					END IF;
				END IF;
			WHEN C => SD <= '1';
			-- CONTINUARA ...
		END CASE;
	END PROCESS AUTOMATA;

	TRANSICION : PROCESS( CLK, CLR )
	BEGIN
		IF( CLR = '1' )THEN
			EDO_ACT <= A;
		ELSIF( RISING_EDGE(CLK) )THEN
			EDO_ACT <= EDO_SGTE;
		END IF;
	END PROCESS TRANSICION;
end UNIDAD;

