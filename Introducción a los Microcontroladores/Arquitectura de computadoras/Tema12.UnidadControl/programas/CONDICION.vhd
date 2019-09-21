----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:47:45 11/23/2017 
-- Design Name: 
-- Module Name:    CONDICION - PROGRAMA 
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

entity CONDICION is
    Port ( RBANDERAS : in  STD_LOGIC_VECTOR (3 downto 0);
           EQ : out  STD_LOGIC;
           NEQ : out  STD_LOGIC;
           LT : out  STD_LOGIC;
           LE : out  STD_LOGIC;
           GTI : out  STD_LOGIC;
           GET : out  STD_LOGIC);
end CONDICION;

architecture PROGRAMA of CONDICION is
--RBANDERAS(3):OV, RBANDERAS(2):N
--RBANDERAS(1):C, RBANDERAS(0):Z 
begin
	EQ  <= RBANDERAS(0);
	NEQ <= NOT RBANDERAS(0);
	LT  <= (RBANDERAS(2) XOR RBANDERAS(3)) AND 
			NOT RBANDERAS(0);	-- L <= (N XOR OV) AND NOT Z
	--CONTINUARA...
end PROGRAMA;

