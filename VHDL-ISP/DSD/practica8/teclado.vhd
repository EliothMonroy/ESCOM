library ieee;
use ieee.std_logic_1164.all;
entity teclado is
port(
		fila:in std_logic_vector (3 downto 0);
		columnas:in std_logic_vector(3 downto 0);
		clk, clr,:in std_logic;
		display:inout std_logic_vector(6 downto 0)
	);
end entity;
architecture a_teclado of teclado is

	signal tecla: std_logic_vector (6 downto 0);
	constant dig0: 		std_logic_vector(6 downto 0):="0000001";
	-- aquí van los demás numeros.
	constant notecla: 	std_logic_vector(6 downto 0):="1111111";
	begin
		decodificador : process(f,c)
		begin
			case f&c is
				when "0111"&"011"=>tecla=>dig1;
				when "0111"&"101"=>tecla=>dig2;
				--Aquí van los demás casos
				when others => tecla=>notecla;
			end case;
		end process ; -- decodificador
		anillo : process(clr,clk)
		begin
			if(clr='0') then
				c<="110";
			elsif (clk'event and clk='1') then
				c<=to_stdlogicvector(to_bitvector(c)ror 1);
			end if;
		end process ; -- anillo
		registro : process(clk,clr,display)
		begin
			if (clr='0') then
				display<=notecla;
			elsif (clk'event and clk='1') then
				if (f="1111") then
					display<=display;
				else
					display<=notecla;
				end if ;
			end if ;
		end process ; -- registro

end architecture ; -- a_teclado