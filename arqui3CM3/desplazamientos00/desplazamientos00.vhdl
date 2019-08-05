library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagediv00.all;
entity desplazamientos00 is
	port(
		clks: in std_logic;
		enable: in std_logic_vector(2 downto 0);
		--limite: in std_logic_vector(2 downto 0);--Esto es para el desplazamiento de barril.
		ins: in std_logic_vector(7 downto 0);
		outs: out std_logic_vector(7 downto 0));
end desplazamientos00;
architecture desplazamientos0 of desplazamientos00 is
signal sins:std_logic_vector(7 downto 0);
--signal scont:std_logic_vector(2 downto 0);--Esto es para el desplazamiento de barril.
begin
	ps:process(clks)
	begin
		if(clks'event and clks='1') then
			case enable is
				--Ingresar valor
				when "000" =>
					sins<=ins;
					outs<=(others => '0');--Inicializamos en cero todo el vector
				--Mostrar dato
				when "001" =>
					outs<=ins;
				--Desplazamiento Izquierda
				when "011" =>
					--Esto es para barrilR00
					--if (scont<limite) then
					--	scont<=scont+1
					--else
					--	scont<=scont;
					--end if;
					sins(0)<='0';
					sins(7 downto 1)<=sins(6 downto 0);
					outs<=sins;
				--Desplazamiento Derecha
				when "111" =>
					sins(7)<='0';
					sins(6 downto 0)<=sins(7 downto 1);
					outs<=sins;
				--Rotación Izquierda
				when "110" =>
					sins(0)<=sins(7);
					sins(7 downto 1)<=sins(6 downto 0);
					outs<=sins;
				--Rotación Derecha
				when "100" =>
					sins(7)<=sins(0);
					sins(6 downto 0)<=sins(7 downto 1);
					outs<=sins;
				when others =>null;
			end case;
		end if;
	end process;
end architecture desplazamientos0;