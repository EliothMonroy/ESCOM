library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity div00 is
	port(
		clkdiv: in std_logic;
		indiv: in std_logic_vector(3 downto 0);
		outdiv: inout std_logic);
end div00;
architecture div0 of div00 is
-- Necesitamos un contador para dividir la frecuencia
signal sdiv: std_logic_vector(21 downto 0);
begin
	pdiv: process(clkdiv)
	begin
		--Condición global
		if(clkdiv'event and clkdiv='1') then
			case indiv is
				when "0000"=>
					if(sdiv < "1000000000000000000000") then
						sdiv<=sdiv+'1';
					else
						sdiv<="0000000000000000000000";
						outdiv<=not(outdiv);
					end if;
				when "0001"=>
					if(sdiv < "0100000000000000000000") then
						sdiv<=sdiv+'1';
					else
						sdiv<="0000000000000000000000";
						outdiv<=not(outdiv);
					end if;
				when "0011"=>
					if(sdiv < "0010000000000000000000") then
						sdiv<=sdiv+'1';
					else
						sdiv<="0000000000000000000000";
						outdiv<=not(outdiv);
					end if;
				when "0111"=>
					if(sdiv < "0001000000000000000000") then
						sdiv<=sdiv+'1';
					else
						sdiv<="0000000000000000000000";
						outdiv<=not(outdiv);
					end if;
				when "1111"=>
					if(sdiv < "0000100000000000000000") then
						sdiv<=sdiv+'1';
					else
						sdiv<="0000000000000000000000";
						outdiv<=not(outdiv);
					end if;
				when "1110"=>
					if(sdiv < "0000010000000000000000") then
						sdiv<=sdiv+'1';
					else
						sdiv<="0000000000000000000000";
						outdiv<=not(outdiv);
					end if;
				when "1100"=>
					if(sdiv < "0000001000000000000000") then
						sdiv<=sdiv+'1';
					else
						sdiv<="0000000000000000000000";
						outdiv<=not(outdiv);
					end if;
				when "1000"=>
					if(sdiv < "0000000100000000000000") then
						sdiv<=sdiv+'1';
					else
						sdiv<="0000000000000000000000";
						outdiv<=not(outdiv);
					end if;
				when others=>null;
			end case;
		end if;
	end process pdiv;
end div0;