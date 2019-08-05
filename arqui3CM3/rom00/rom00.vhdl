library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity rom00 is
	port(
		indirrom:in std_logic_vector(3 downto 0);
		clkrom:in std_logic;
		enablerom:in std_logic;
		outwordrom: inout std_logic_vector(6 downto 0)
	);
end entity ; -- rom00
architecture rom0 of rom00 is
type arrayrom is array(0 to 31) of std_logic_vector(6 downto 0);
constant wordrom:arrayrom:=(
	"1111111",--8
	"1110000",--7
	"1011111",--6
	"1011011",--5
	"0110011",--4
	"1111001",--3
	"1101101",--2
	"0110000",--1
	"1111110",--0
	"1110111",--A
	"0011111",--b
	"1001110",--C
	others=>"1110011"--9
);--Inicializamos con los valores
begin
	prom : process(clkrom)
	begin
		if (clkrom'event and clkrom='1') then
			case(enablerom) is
				when '0' =>
				outwordrom<="0000000";--Apagamos el display
				when '1'=>
					outwordrom<=wordrom(conv_integer(indirrom));
				when others =>null;
			end case ;
		end if ;
	end process ; -- prom
end architecture ; -- rom0