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

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           BINVERT : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (3 downto 0);
           C4 : out  STD_LOGIC);
end ALU;

architecture PROGRAMA of ALU is
SIGNAL EB : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL C :  STD_LOGIC_VECTOR(4 DOWNTO 0);
begin
	C(0) <= BINVERT;

	EB(0)<= B(0) XOR BINVERT;
	S(0) <= A(0) XOR EB(0) XOR C(0);
	C(1) <= (A(0) AND EB(0)) OR (A(0) AND C(0)) OR (EB(0) AND C(0)); 

	EB(1)<= B(1) XOR BINVERT;
	S(1) <= A(1) XOR EB(1) XOR C(1);
	C(2) <= (A(1) AND EB(1)) OR (A(1) AND C(1)) OR (EB(1) AND C(1)); 

	EB(2)<= B(2) XOR BINVERT;
	S(2) <= A(2) XOR EB(2) XOR C(2);
	C(3) <= (A(2) AND EB(2)) OR (A(2) AND C(2)) OR (EB(2) AND C(2)); 

	EB(3)<= B(3) XOR BINVERT;
	S(3) <= A(3) XOR EB(3) XOR C(3);
	C(4) <= (A(3) AND EB(3)) OR (A(3) AND C(3)) OR (EB(3) AND C(3)); 

	C4 <= C(4);

end PROGRAMA;

