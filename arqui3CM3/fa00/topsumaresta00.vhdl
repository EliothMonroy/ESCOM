library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packagesumaresta00.all;
entity topsumaresta00 is
	port(
		SL: in std_logic;--Nos dice si queremos sumar o restar, 0 -> Suma, 1 -> Resta 
		Ai: in std_logic_vector(3 downto 0);
		Bi: in std_logic_vector(3 downto 0);
		So: inout std_logic_vector(3 downto 0);
		LED: out std_logic);
		--Puertos
		attribute loc: string;
		--Dip switch 1
		attribute loc of Ai: signal is "42,44,43,45";
		--Dip switch 2
		attribute loc of Bi: signal is "52,55,54,56";
		--Pines leds rojo
		attribute loc of So: signal is "20,19,14,13";
		--Pin de sobrepasamiento
		attribute loc of LED: signal is "24";-- El siguiente sería 21
		--tercer dip switch
		attribute loc of SL: signal is "61";
end topsumaresta00;
architecture topsumaresta0 of topsumaresta00 is
signal sb, sa, sc: std_logic_vector(3 downto 0);
signal sd: std_logic;
begin
	SR01: xor00 port map(
		Ax=>SL, Bx=>Bi(0), Yx=> sb(0)
	);
	SR02: xor00 port map(
		Ax=>SL, Bx=>Bi(1), Yx=> sb(1)
	);
	SR03: xor00 port map(
		Ax=>SL, Bx=>Bi(2), Yx=> sb(2)
	);
	SR04: xor00 port map(
		Ax=>SL, Bx=>Bi(3), Yx=>sb(3)
	);
	S05: topfa00 port map(
		C00=>SL, A00=>Ai(0), B00=>sb(0), C01=>sc(0), S00=>sa(0)
	);
	S06: topfa00 port map(
		C00=>sc(0), A00=>Ai(1), B00=>sb(1), C01=>sc(1), S00=>sa(1)
	);
	S07: topfa00 port map(
		C00=>sc(1), A00=>Ai(2), B00=>sb(2), C01=>sc(2), S00=>sa(2)
	);
	S08: topfa00 port map(
		C00=>sc(2), A00=>Ai(3), B00=>sb(3), C01=>sc(3), S00=>sa(3)
	);
	S09: xor00 port map(
		Ax=>sc(3), Bx=>sc(2), Yx=>LED
	);
	S10: xnor00 port map(
		Anx=>sc(3), Bnx=>sc(2),Ynx=>sd
	);
	S11: and00 port map(
		Aa=>sd, Ba=>sa(0), Ya=>So(0)
	);
	S12: and00 port map(
		Aa=>sd, Ba=>sa(1), Ya=>So(1)
	);
	S13: and00 port map(
		Aa=>sd, Ba=>sa(2), Ya=>So(2)
	);
	S14: and00 port map(
		Aa=>sd, Ba=>sa(3), Ya=>So(3)
	);
end topsumaresta0;
