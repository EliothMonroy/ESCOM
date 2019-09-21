library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FC2 is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           ADD : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (7 downto 0));
end FC2;

architecture PROGRAMA of FC2 is
begin
	
S <= (A + B) WHEN ADD = '1' ELSE (A - B);

end PROGRAMA;

