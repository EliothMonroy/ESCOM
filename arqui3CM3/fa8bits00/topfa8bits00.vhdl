library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packagesumaresta00.all;
entity topfa8bits00 is
	port(
		SL: in std_logic;--Nos dice si queremos sumar o restar, 0 -> Suma, 1 -> Resta 
		Ai: in std_logic_vector(7 downto 0);
		Bi: in std_logic_vector(7 downto 0);
		So: inout std_logic_vector(7 downto 0);
		LED: out std_logic);
		--Puertos
		attribute loc: string;
		--Dip switch 1
		attribute loc of Ai: signal is "42,44,43,45,47,49,48,50";
		--Dip switch 2
		attribute loc of Bi: signal is "52,55,54,56,57,59,58,60";
		--Pines leds rojo
		attribute loc of So: signal is "24,23,22,21,20,19,14,13";
		--Pin de sobrepasamiento
		attribute loc of LED: signal is "113";
		--Cuarto Dip dip switch
		attribute loc of SL: signal is "61";
end topfa8bits00;
architecture topfa8bits0 of topfa8bits00 is
signal sb, sa, sc: std_logic_vector(7 downto 0);
signal sd: std_logic;
begin
	--Compuertas Xor
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
	);--Ampliación
	SR05: xor00 port map(
		Ax=>SL, Bx=>Bi(4), Yx=>sb(4)
	);
	SR06: xor00 port map(
		Ax=>SL, Bx=>Bi(5), Yx=>sb(5)
	);
	SR07: xor00 port map(
		Ax=>SL, Bx=>Bi(6), Yx=>sb(6)
	);
	SR08: xor00 port map(
		Ax=>SL, Bx=>Bi(7), Yx=>sb(7)
	);
	--Sumadores Completos
	S09: topfa00 port map(
		C00=>SL, A00=>Ai(0), B00=>sb(0), C01=>sc(0), S00=>sa(0)
	);
	S10: topfa00 port map(
		C00=>sc(0), A00=>Ai(1), B00=>sb(1), C01=>sc(1), S00=>sa(1)
	);
	S11: topfa00 port map(
		C00=>sc(1), A00=>Ai(2), B00=>sb(2), C01=>sc(2), S00=>sa(2)
	);
	S12: topfa00 port map(
		C00=>sc(2), A00=>Ai(3), B00=>sb(3), C01=>sc(3), S00=>sa(3)
	);
	S13: topfa00 port map(
		C00=>sc(3), A00=>Ai(4), B00=>sb(4), C01=>sc(4), S00=>sa(4)
	);
	S14: topfa00 port map(
		C00=>sc(4), A00=>Ai(5), B00=>sb(5), C01=>sc(5), S00=>sa(5)
	);
	S15: topfa00 port map(
		C00=>sc(5), A00=>Ai(6), B00=>sb(6), C01=>sc(6), S00=>sa(6)
	);
	S16: topfa00 port map(
		C00=>sc(6), A00=>Ai(7), B00=>sb(7), C01=>sc(7), S00=>sa(7)
	);
	--Compuerta Xor
	S17: xor00 port map(
		Ax=>sc(7), Bx=>sc(6), Yx=>LED
	);
	--Compuerta Xnor
	S18: xnor00 port map(
		Anx=>sc(7), Bnx=>sc(6),Ynx=>sd
	);
	--Compuertas And
	S19: and00 port map(
		Aa=>sd, Ba=>sa(0), Ya=>So(0)
	);
	S20: and00 port map(
		Aa=>sd, Ba=>sa(1), Ya=>So(1)
	);
	S21: and00 port map(
		Aa=>sd, Ba=>sa(2), Ya=>So(2)
	);
	S22: and00 port map(
		Aa=>sd, Ba=>sa(3), Ya=>So(3)
	);
	S23: and00 port map(
		Aa=>sd, Ba=>sa(4), Ya=>So(4)
	);
	S24: and00 port map(
		Aa=>sd, Ba=>sa(5), Ya=>So(5)
	);
	S25: and00 port map(
		Aa=>sd, Ba=>sa(6), Ya=>So(6)
	);
	S26: and00 port map(
		Aa=>sd, Ba=>sa(7), Ya=>So(7)
	);
end topfa8bits0;
