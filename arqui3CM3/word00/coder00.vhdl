library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity coder00 is
	port(
		incont: in std_logic_vector(3 downto 0);
		outcoder: out std_logic_vector(6 downto 0));
end coder00;
architecture coder0 of coder00 is
begin
	pcoder: process(incont)
	begin
		case incont is
			when "1110" => 
				outcoder<="1110111"; -- A
			when "1101" => 
				outcoder<="0001110"; -- L
			when "1011" => 
				outcoder<="1111110"; -- O
			when "0111" => 
				outcoder<="0110111"; -- H
			when others => null;
		end case;
	end process pcoder;
end coder0;