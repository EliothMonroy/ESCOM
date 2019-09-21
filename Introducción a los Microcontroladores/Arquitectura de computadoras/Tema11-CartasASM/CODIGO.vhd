----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:47:20 10/26/2017 
-- Design Name: 
-- Module Name:    CODIGO - CONVERTIDOR 
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

entity CODIGO is
    Port ( E : in  STD_LOGIC_VECTOR (3 downto 0);
           SAL : out  STD_LOGIC_VECTOR (6 downto 0));
end CODIGO;

architecture CONVERTIDOR of CODIGO is
CONSTANT DIG0 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000001";
CONSTANT DIG1 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1001111";
CONSTANT DIG2 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010010";
--CONTINUARA...
begin
	SAL <= DIG0 WHEN( E = X"0" ) ELSE
			 DIG1 WHEN( E = X"1" ) ELSE
			 DIG2;
			 --CONTINUARA...
end CONVERTIDOR;

