----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:43:59 08/09/2012 
-- Design Name: 
-- Module Name:    CONV_COD - PROGRAMA 
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

entity CONV_COD is
    Port ( E : in  STD_LOGIC_VECTOR (2 downto 0);
           S : out  STD_LOGIC_VECTOR (2 downto 0));
end CONV_COD;

architecture PROGRAMA of CONV_COD is
begin
	 S <= "000" when E="000" else
	      "001" when E="001" else
			"011" when E="010" else
			"010" when E="011" else
			"110" when E="100" else
			"111" when E="101" else
			"101" when E="110" else
			"100";
end PROGRAMA;

