----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:32:20 09/25/2013 
-- Design Name: 
-- Module Name:    PROGRAMA - MEMORIA 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PROGRAMA is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           D : out  STD_LOGIC_VECTOR (24 downto 0));
end PROGRAMA;

architecture MEMORIA of PROGRAMA is
	CONSTANT OPCODE_TIPOR 	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	CONSTANT OPCODE_LI 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";
	CONSTANT OPCODE_LWI 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00010";
	CONSTANT OPCODE_SWI 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00011";
	CONSTANT OPCODE_B 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10011";
-- CONTINUARA...	
	CONSTANT FUNCODE_ADD		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	CONSTANT FUNCODE_SUB		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
-- CONTINUARA...	
	CONSTANT R0					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	CONSTANT R1					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
-- CONTINUARA...	
	CONSTANT SU					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	
	
	TYPE ARR IS ARRAY (0 TO 2**16 - 1) OF STD_LOGIC_VECTOR(24 DOWNTO 0); 
	CONSTANT ROM : ARR := (
		OPCODE_LI&R0&X"0001",
		OPCODE_LI&R1&X"0007",
		OPCODE_TIPOR&R1&R1&R0&SU&FUNCODE_ADD,
		OPCODE_SWI&R1&X"0005",
		OPCODE_B&SU&X"0002",
		OTHERS=>(OTHERS=>'0')
	);
begin
	D <= ROM( CONV_INTEGER(A) );

end MEMORIA;

