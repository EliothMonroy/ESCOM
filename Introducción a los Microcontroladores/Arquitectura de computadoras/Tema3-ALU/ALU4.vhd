----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:45:40 08/24/2017 
-- Design Name: 
-- Module Name:    ALU - PROGRAMA 
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

entity ALU3 is
	GENERIC( N : INTEGER := 4 );
    Port ( A : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B : in  STD_LOGIC_VECTOR (N-1 downto 0);
           BINVERT : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (N-1 downto 0);
           CN : out  STD_LOGIC);
end ALU3;

architecture PROGRAMA of ALU3 is   
begin

	PALU : PROCESS( A, B, BINVERT )
	VARIABLE EB, P, G : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	VARIABLE C :  STD_LOGIC_VECTOR(N DOWNTO 0);
	VARIABLE PK, T2, T3 : STD_LOGIC;
	BEGIN
		C(0) := BINVERT;
		FOR I IN 0 TO N-1 LOOP
			EB(I):= B(I) XOR BINVERT;
			P(I) := A(I) XOR EB(I);
			G(I) := A(I) AND EB(I);
			S(I) <= A(I) XOR EB(I) XOR C(I);
			
			T2 := '0';
			FOR J IN 0 TO I-1 LOOP
				PK := '1';
				FOR K IN J+1 TO I LOOP
					PK := PK AND P(K);
				END LOOP;
				T2 := T2 OR (G(J) AND PK);
			END LOOP;
			
			--T3 := ...
			
			C(I+1) := G(I) OR T2 OR T3; 
		END LOOP;
		CN <= C(N);
	END PROCESS PALU;
	
end PROGRAMA;

