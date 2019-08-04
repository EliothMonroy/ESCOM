library ieee;
use ieee.std_logic_1164.all;
entity decodificador is port(
	A: in std_logic_vector(3 downto 0);
	d: out std_logic_vector(6 downto 0));
	attribute loc: string;
	attribute loc of A:signal is "p4,p5,p6,p7";
	attribute loc of d:signal is "p111,p112,p113,p114,p120,p121,p122";
end decodificador;
architecture arch of decodificador is
begin
	process(A) begin
		case A is--Anodo (Prende con ceros)
			when "0000" =>d<= "0000001";
			when "0001" =>d<= "1001111";
			when "0010" =>d<= "0010010";
			when "0011" =>d<= "0000110";
			when "0100" =>d<= "1001100";
			when "0101" =>d<= "0100100";
			when "0110" =>d<= "0100000";
			when "0111" =>d<= "0001110";
			when "1000" =>d<= "0000000";
			when "1001" =>d<= "0000100";
			when others =>d<= "1111111";
		end case;
	end process ; -- process
end architecture ; -- arch