library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
use packagediv00.all;
entity shiftR00 is
	port(
		clks: in std_logic;
		enable: in std_logic;
		--limite: in std_logic_vector(2 downto 0);--Esto es para el desplazamiento de barril.
		ins: in std_logic_vector(7 downto 0);
		outs: out std_logic_vector(7 downto 0));
end shiftR00;
architecture shiftR0 of shiftR00 is
signal sins:std_logic_vector(7 downto 0);
--signal scont:std_logic_vector(2 downto 0);--Esto es para el desplazamiento de barril.
begin
	ps:process(clks)
	begin
		if(clks'event and clks='1') then
			case enable is
				when '0' =>
					sins<=ins;
					outs<=(others => '0');--Inicializamos en cero todo el vector
				when '1' =>
					--Esto es para barrilR00
					--if (scont<limite) then
					--	scont<=scont+1
					--else
					--	scont<=scont;
					--end if;
					sins(7)<='0';
					sins(6 downto 0)<=sins(7 downto 1);
					outs<=sins;
				when others =>null;
			end case;
		end if;
	end process;
end architecture shiftR0;