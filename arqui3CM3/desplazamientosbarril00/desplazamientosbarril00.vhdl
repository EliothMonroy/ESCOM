library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagediv00.all;
entity desplazamientosbarril00 is
	port(
		clks: in std_logic;
		enable: in std_logic_vector(2 downto 0);
		limite: in std_logic_vector(3 downto 0);--Esto es para el desplazamiento de barril.
		ins: in std_logic_vector(7 downto 0);
		outs: out std_logic_vector(7 downto 0));
end desplazamientosbarril00;
architecture desplazamientosbarril0 of desplazamientosbarril00 is
signal sins:std_logic_vector(7 downto 0);
signal scont:std_logic_vector(3 downto 0);--Esto es para el desplazamiento de barril.
begin
	ps:process(clks)
	begin
		if(clks'event and clks='1') then
			case enable is
				--Ingresar valor
				when "000" =>
					sins<=ins;
					outs<=(others => '0');--Inicializamos en cero todo el vector
					scont<=(others=>'0');
				--Mostrar dato
				when "001" =>
					outs<=ins;
					scont<=(others=>'0');
				--Desplazamiento Barril Izquierda
				when "011" =>
					--Esto es para barrilL00
					if (scont<limite) then
						scont<=scont+1;
						sins(0)<='0';
						sins(7 downto 1)<=sins(6 downto 0);
						outs<=sins;
					else
						scont<=scont;
					end if;					
				--Desplazamiento Derecha
				when "111" =>
					if (scont<limite) then
						scont<=scont+1;
						sins(7)<='0';
						sins(6 downto 0)<=sins(7 downto 1);
						outs<=sins;
					else
						scont<=scont;
					end if;	
					
				--Rotación Izquierda
				when "110" =>
					if (scont<limite) then
						scont<=scont+1;
						sins(0)<=sins(7);
						sins(7 downto 1)<=sins(6 downto 0);
						outs<=sins;
					else
						scont<=scont;
					end if;	
					
				--Rotación Derecha
				when "100" =>
					if (scont<limite) then
						scont<=scont+1;
						sins(7)<=sins(0);
						sins(6 downto 0)<=sins(7 downto 1);
						outs<=sins;
					else
						scont<=scont;
					end if;	
					
				when others =>null;
			end case;
		end if;
	end process;
end architecture desplazamientosbarril0;