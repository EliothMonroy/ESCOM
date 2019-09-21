library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FC3 is
	GENERIC( N : INTEGER := 8 );
    Port ( A : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B : in  STD_LOGIC_VECTOR (N-1 downto 0);
           S : out  STD_LOGIC_VECTOR (N-1 downto 0);
           C0, BINVERT : in  STD_LOGIC;
           CN : out  STD_LOGIC);
end FC3;

architecture PROGRAMA of FC3 is
SIGNAL EB : STD_LOGIC_VECTOR(N-1 downto 0) := "0000";
SIGNAL C : STD_LOGIC_VECTOR(N downto 0) := "00000";
begin
	C(0) <= C0;	
	CICLO: FOR I IN 0 TO N-1 GENERATE
		EB(I) <= B(I) XOR BINVERT;
		S(I)  <= C(I) XOR A(I) XOR EB(I);
		C(I+1)<= (EB(I) AND C(I)) OR (A(I) AND C(I)) OR (A(I) AND EB(I)); 
	END GENERATE;
	CN <= C(N);
end PROGRAMA;

