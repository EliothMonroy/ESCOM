library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.components.all;
use packageadder.all;
entity topadder4bits is
	port(
		SL: in std_logic;
		Ai: in std_logic_vector(3 downto 0);
		Bi: in std_logic_vector(3 downto 0);
		S0:
	);
end entity;

architecture arch of topadder4bits is
begin
	S04: fa port map(C => SL, A=>Ai(0), B=>SB(0), S=>SA(0), C01=>SC(0));
	S08: and port map(Aa=>Saa, Ba=>SA(0), Ya=>So(0));
	S12: xnor port map(Ax=> SC(2), Bx=>SC(3), Yx=>Saa);
	
end architecture;