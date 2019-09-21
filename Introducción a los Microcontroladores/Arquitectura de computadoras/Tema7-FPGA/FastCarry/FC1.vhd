library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FC1 is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           ADD : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (7 downto 0));
end FC1;

architecture PROGRAMA of FC1 is
SIGNAL SUMA : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL RESTA : STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
	
SUMA <= A + B;
RESTA <= A - B;
S <= 	SUMA WHEN ADD = '1' ELSE RESTA;

end PROGRAMA;

