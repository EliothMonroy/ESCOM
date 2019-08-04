library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity prueba is

port( -- Declaramos los puertos
	A: in std_logic ;
	B: in std_logic ;
	SOR: out std_logic;
	SAND: out std_logic;
	SNOT: out std_logic;
	SNOR: out std_logic;
	SNAND: out std_logic;
	SXOR: out std_logic );
	--Asignamos los pines correspondientes
	attribute loc: string;
	attribute loc of A:signal is "pin124";
	attribute loc of B:signal is "pin125";
	attribute loc of SOR:signal is "pin4";
	attribute loc of SAND:signal is "pin5";
	attribute loc of SNOT:signal is "pin6";
	attribute loc of SNOR:signal is "pin7";
	attribute loc of SNAND:signal is "pin8";
	attribute loc of SXOR:signal is "pin9";

end;

architecture behavioral of prueba is
begin
	--Compuerta OR
	SOR<= '0' when (A='0' and B='0') else '1';
	-- Compuerta AND
	SAND<= '1' when (A='1' AND B='1') else '0';
	-- Compuerta NOT
	SNOT<= '1' when (A='0') else '0';
	--Compuerta NOR
	SNOR<= '1' when (A='0' and B='0') else '0';
	-- Compuerta NAND
	SNAND<= '0' when (A='1' and B='1') else '1';
	-- Compuerta XOR
	SXOR<= '1' when ((A='1' and B='0') or (A='0' and B='1')) else '0';
end behavioral;

