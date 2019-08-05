library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packagemult4bit00.all;
entity topmult8bit00 is
	port(
		Am4: in std_logic_vector(7 downto 0);
		Bm4: in std_logic_vector(7 downto 0);
		Rm4: out std_logic_vector(15 downto 0));
end topmult8bit00;
architecture topmult8bit0 of topmult8bit00 is
signal S0, S3, S6, S9, S12, S15, S18: std_logic_vector(6 downto 0);
signal S1, S4, S7, S10, S13, S16, S19: std_logic_vector(7 downto 0);
signal S2, S5, S8, S11, S14, S17, S20: std_logic_vector(7 downto 0);
begin
	--Primeras and
	M01: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(0),
		Ya => Rm4(0)
	);
	M02: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(0),
		Ya => S0(0)
	);
	M03: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(0),
		Ya => S0(1)
	);
	M04: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(0),
		Ya => S0(2)
	);
	M05: and00 port map(
		Aa => Am4(4),
		Ba => Bm4(0),
		Ya => S0(3)
	);
	M06: and00 port map(
		Aa => Am4(5),
		Ba => Bm4(0),
		Ya => S0(4)
	);
	M07: and00 port map(
		Aa => Am4(6),
		Ba => Bm4(0),
		Ya => S0(5)
	);
	M08: and00 port map(
		Aa => Am4(7),
		Ba => Bm4(0),
		Ya => S0(6)
	);
	--Segundas and
	M09: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(1),
		Ya => S1(0)
	);
	M10: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(1),
		Ya => S1(1)
	);
	M11: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(1),
		Ya => S1(2)
	);
	M12: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(1),
		Ya => S1(3)
	);
	M13: and00 port map(
		Aa => Am4(4),
		Ba => Bm4(1),
		Ya => S1(4)
	);
	M14: and00 port map(
		Aa => Am4(5),
		Ba => Bm4(1),
		Ya => S1(5)
	);	
	M15: and00 port map(
		Aa => Am4(6),
		Ba => Bm4(1),
		Ya => S1(6)
	);
	M16: and00 port map(
		Aa => Am4(7),
		Ba => Bm4(1),
		Ya => S1(7)
	);	
	--Primeros Sumadores
	M17: fa00 port map(
		C00 => '0',
		A00 => S0(0),
		B00 => S1(0),
		S00 => Rm4(1),
		C01 => S2(0)
	);
	M18: fa00 port map(
		C00 => S2(0),
		A00 => S0(1),
		B00 => S1(1),
		S00 => S3(0),
		C01 => S2(1)
	);
	M19: fa00 port map(
		C00 => S2(1),
		A00 => S0(2),
		B00 => S1(2),
		S00 => S3(1),
		C01 => S2(2)
	);
	M20: fa00 port map(
		C00 => S2(2),
		A00 => S0(3),
		B00 => S1(3),
		S00 => S3(2),
		C01 => S2(3)
	);
	M21: fa00 port map(
		C00 => S2(3),
		A00 => S0(4),
		B00 => S1(4),
		S00 => S3(3),
		C01 => S2(4)
	);
	M22: fa00 port map(
		C00 => S2(4),
		A00 => S0(5),
		B00 => S1(5),
		S00 => S3(4),
		C01 => S2(5)
	);
	M23: fa00 port map(
		C00 => S2(5),
		A00 => S0(6),
		B00 => S1(6),
		S00 => S3(5),
		C01 => S2(6)
	);
	M24: fa00 port map(
		C00 => S2(6),
		A00 => '0',
		B00 => S1(7),
		S00 => S3(6),
		C01 => S2(7)
	);
	--Terceras and
	M25: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(2),
		Ya => S4(0)
	);
	M26: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(2),
		Ya => S4(1)
	);
	M27: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(2),
		Ya => S4(2)
	);
	M28: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(2),
		Ya => S4(3)
	);
	M29: and00 port map(
		Aa => Am4(4),
		Ba => Bm4(2),
		Ya => S4(4)
	);
	M30: and00 port map(
		Aa => Am4(5),
		Ba => Bm4(2),
		Ya => S4(5)
	);
	M31: and00 port map(
		Aa => Am4(6),
		Ba => Bm4(2),
		Ya => S4(6)
	);
	M32: and00 port map(
		Aa => Am4(7),
		Ba => Bm4(2),
		Ya => S4(7)
	);
	--Segundos sumadores
	M33: fa00 port map(
		C00 => '0',
		A00 => S3(0),
		B00 => S4(0),
		S00 => Rm4(2),
		C01 => S5(0)
	);
	M34: fa00 port map(
		C00 => S5(0),
		A00 => S3(1),
		B00 => S4(1),
		S00 => S6(0),
		C01 => S5(1)
	);
	M35: fa00 port map(
		C00 => S5(1),
		A00 => S3(2),
		B00 => S4(2),
		S00 => S6(1),
		C01 => S5(2)
	);
	M36: fa00 port map(
		C00 => S5(2),
		A00 => S3(3),
		B00 => S4(3),
		S00 => S6(2),
		C01 => S5(3)
	);
	M37: fa00 port map(
		C00 => S5(3),
		A00 => S3(4),
		B00 => S4(4),
		S00 => S6(3),
		C01 => S5(4)
	);
	M38: fa00 port map(
		C00 => S5(4),
		A00 => S3(5),
		B00 => S4(5),
		S00 => S6(4),
		C01 => S5(5)
	);
	M39: fa00 port map(
		C00 => S5(5),
		A00 => S3(6),
		B00 => S4(6),
		S00 => S6(5),
		C01 => S5(6)
	);
	M40: fa00 port map(
		C00 => S5(6),
		A00 => S2(7),
		B00 => S4(7),
		S00 => S6(6),
		C01 => S5(7)
	);
	--Cuartas and
	M41: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(3),
		Ya => S7(0)
	);
	M42: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(3),
		Ya => S7(1)
	);
	M43: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(3),
		Ya => S7(2)
	);
	M44: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(3),
		Ya => S7(3)
	);
	M45: and00 port map(
		Aa => Am4(4),
		Ba => Bm4(3),
		Ya => S7(4)
	);
	M46: and00 port map(
		Aa => Am4(5),
		Ba => Bm4(3),
		Ya => S7(5)
	);
	M47: and00 port map(
		Aa => Am4(6),
		Ba => Bm4(3),
		Ya => S7(6)
	);
	M48: and00 port map(
		Aa => Am4(7),
		Ba => Bm4(3),
		Ya => S7(7)
	);
	--Terceros sumadores
	M49: fa00 port map(
		C00 => '0',
		A00 => S6(0),
		B00 => S7(0),
		S00 => Rm4(3),
		C01 => S8(0)
	);					 
	M50: fa00 port map(
		C00 => S8(0),
		A00 => S6(1),
		B00 => S7(1),
		S00 => S9(0),
		C01 => S8(1)
	);					 
	M51: fa00 port map(
		C00 => S8(1),
		A00 => S6(2),
		B00 => S7(2),
		S00 => S9(1),
		C01 => S8(2)
	);
	M52: fa00 port map(
		C00 => S8(2),
		A00 => S6(3),
		B00 => S7(3),
		S00 => S9(2),
		C01 => S8(3)
	);
	M53: fa00 port map(
		C00 => S8(3),
		A00 => S6(4),
		B00 => S7(4),
		S00 => S9(3),
		C01 => S8(4)
	);
	M54: fa00 port map(
		C00 => S8(4),
		A00 => S6(5),
		B00 => S7(5),
		S00 => S9(4),
		C01 => S8(5)
	);
	M55: fa00 port map(
		C00 => S8(5),
		A00 => S6(6),
		B00 => S7(6),
		S00 => S9(5),
		C01 => S8(6)
	);
	M56: fa00 port map(
		C00 => S8(6),
		A00 => S5(7),
		B00 => S7(7),
		S00 => S9(6),
		C01 => S8(7)
	);
	--Quintas and
	M57: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(4),
		Ya => S10(0)
	);
	M58: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(4),
		Ya => S10(1)
	);
	M59: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(4),
		Ya => S10(2)
	);
	M60: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(4),
		Ya => S10(3)
	);
	M61: and00 port map(
		Aa => Am4(4),
		Ba => Bm4(4),
		Ya => S10(4)
	);
	M62: and00 port map(
		Aa => Am4(5),
		Ba => Bm4(4),
		Ya => S10(5)
	);
	M63: and00 port map(
		Aa => Am4(6),
		Ba => Bm4(4),
		Ya => S10(6)
	);
	M64: and00 port map(
		Aa => Am4(7),
		Ba => Bm4(4),
		Ya => S10(7)
	);
	--Cuartos sumadores
	M65: fa00 port map(
		C00 => '0',
		A00 => S9(0),
		B00 => S10(0),
		S00 => Rm4(4),
		C01 => S11(0)
	);					 
	M66: fa00 port map(
		C00 => S11(0),
		A00 => S9(1),
		B00 => S10(1),
		S00 => S12(0),
		C01 => S11(1)
	);					 
	M67: fa00 port map(
		C00 => S11(1),
		A00 => S9(2),
		B00 => S10(2),
		S00 => S12(1),
		C01 => S11(2)
	);
	M68: fa00 port map(
		C00 => S11(2),
		A00 => S9(3),
		B00 => S10(3),
		S00 => S12(2),
		C01 => S11(3)
	);
	M69: fa00 port map(
		C00 => S11(3),
		A00 => S9(4),
		B00 => S10(4),
		S00 => S12(3),
		C01 => S11(4)
	);
	M70: fa00 port map(
		C00 => S11(4),
		A00 => S9(5),
		B00 => S10(5),
		S00 => S12(4),
		C01 => S11(5)
	);
	M71: fa00 port map(
		C00 => S11(5),
		A00 => S9(6),
		B00 => S10(6),
		S00 => S12(5),
		C01 => S11(6)
	);
	M72: fa00 port map(
		C00 => S11(6),
		A00 => S8(7),
		B00 => S10(7),
		S00 => S12(6),
		C01 => S11(7)
	);
	--Sextas and
	M73: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(5),
		Ya => S13(0)
	);
	M74: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(5),
		Ya => S13(1)
	);
	M75: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(5),
		Ya => S13(2)
	);
	M76: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(5),
		Ya => S13(3)
	);
	M77: and00 port map(
		Aa => Am4(4),
		Ba => Bm4(5),
		Ya => S13(4)
	);
	M78: and00 port map(
		Aa => Am4(5),
		Ba => Bm4(5),
		Ya => S13(5)
	);
	M79: and00 port map(
		Aa => Am4(6),
		Ba => Bm4(5),
		Ya => S13(6)
	);
	M80: and00 port map(
		Aa => Am4(7),
		Ba => Bm4(5),
		Ya => S13(7)
	);
	--Quintos sumadores
	M81: fa00 port map(
		C00 => '0',
		A00 => S12(0),
		B00 => S13(0),
		S00 => Rm4(5),
		C01 => S14(0)
	);					 
	M82: fa00 port map(
		C00 => S14(0),
		A00 => S12(1),
		B00 => S13(1),
		S00 => S15(0),
		C01 => S14(1)
	);					 
	M83: fa00 port map(
		C00 => S14(1),
		A00 => S12(2),
		B00 => S13(2),
		S00 => S15(1),
		C01 => S14(2)
	);
	M84: fa00 port map(
		C00 => S14(2),
		A00 => S12(3),
		B00 => S13(3),
		S00 => S15(2),
		C01 => S14(3)
	);
	M85: fa00 port map(
		C00 => S14(3),
		A00 => S12(4),
		B00 => S13(4),
		S00 => S15(3),
		C01 => S14(4)
	);
	M86: fa00 port map(
		C00 => S14(4),
		A00 => S12(5),
		B00 => S13(5),
		S00 => S15(4),
		C01 => S14(5)
	);
	M87: fa00 port map(
		C00 => S14(5),
		A00 => S12(6),
		B00 => S13(6),
		S00 => S15(5),
		C01 => S14(6)
	);
	M88: fa00 port map(
		C00 => S14(6),
		A00 => S11(7),
		B00 => S13(7),
		S00 => S15(6),
		C01 => S14(7)
	);
	--Séptimas and
	M89: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(6),
		Ya => S16(0)
	);
	M90: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(6),
		Ya => S16(1)
	);
	M91: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(6),
		Ya => S16(2)
	);
	M92: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(6),
		Ya => S16(3)
	);
	M93: and00 port map(
		Aa => Am4(4),
		Ba => Bm4(6),
		Ya => S16(4)
	);
	M94: and00 port map(
		Aa => Am4(5),
		Ba => Bm4(6),
		Ya => S16(5)
	);
	M95: and00 port map(
		Aa => Am4(6),
		Ba => Bm4(6),
		Ya => S16(6)
	);
	M96: and00 port map(
		Aa => Am4(7),
		Ba => Bm4(6),
		Ya => S16(7)
	);
	--Sextos sumadores
	M97: fa00 port map(
		C00 => '0',
		A00 => S15(0),
		B00 => S16(0),
		S00 => Rm4(6),
		C01 => S17(0)
	);					 
	M98: fa00 port map(
		C00 => S17(0),
		A00 => S15(1),
		B00 => S16(1),
		S00 => S18(0),
		C01 => S17(1)
	);					 
	M99: fa00 port map(
		C00 => S17(1),
		A00 => S15(2),
		B00 => S16(2),
		S00 => S18(1),
		C01 => S17(2)
	);
	M100: fa00 port map(
		C00 => S17(2),
		A00 => S15(3),
		B00 => S16(3),
		S00 => S18(2),
		C01 => S17(3)
	);
	M101: fa00 port map(
		C00 => S17(3),
		A00 => S15(4),
		B00 => S16(4),
		S00 => S18(3),
		C01 => S17(4)
	);
	M102: fa00 port map(
		C00 => S17(4),
		A00 => S15(5),
		B00 => S16(5),
		S00 => S18(4),
		C01 => S17(5)
	);
	M103: fa00 port map(
		C00 => S17(5),
		A00 => S15(6),
		B00 => S16(6),
		S00 => S18(5),
		C01 => S17(6)
	);
	M104: fa00 port map(
		C00 => S17(6),
		A00 => S14(7),
		B00 => S16(7),
		S00 => S18(6),
		C01 => S17(7)
	);
	--Octavas and
	M105: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(7),
		Ya => S19(0)
	);
	M106: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(7),
		Ya => S19(1)
	);
	M107: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(7),
		Ya => S19(2)
	);
	M108: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(7),
		Ya => S19(3)
	);
	M109: and00 port map(
		Aa => Am4(4),
		Ba => Bm4(7),
		Ya => S19(4)
	);
	M110: and00 port map(
		Aa => Am4(5),
		Ba => Bm4(7),
		Ya => S19(5)
	);
	M111: and00 port map(
		Aa => Am4(6),
		Ba => Bm4(7),
		Ya => S19(6)
	);
	M112: and00 port map(
		Aa => Am4(7),
		Ba => Bm4(7),
		Ya => S19(7)
	);
	--Séptimos sumadores
	M113: fa00 port map(
		C00 => '0',
		A00 => S18(0),
		B00 => S19(0),
		S00 => Rm4(7),
		C01 => S20(0)
	);					 
	M114: fa00 port map(
		C00 => S20(0),
		A00 => S18(1),
		B00 => S19(1),
		S00 => Rm4(8),
		C01 => S20(1)
	);					 
	M115: fa00 port map(
		C00 => S20(1),
		A00 => S18(2),
		B00 => S19(2),
		S00 => Rm4(9),
		C01 => S20(2)
	);
	M116: fa00 port map(
		C00 => S20(2),
		A00 => S18(3),
		B00 => S19(3),
		S00 => Rm4(10),
		C01 => S20(3)
	);
	M117: fa00 port map(
		C00 => S20(3),
		A00 => S18(4),
		B00 => S19(4),
		S00 => Rm4(11),
		C01 => S20(4)
	);
	M118: fa00 port map(
		C00 => S20(4),
		A00 => S18(5),
		B00 => S19(5),
		S00 => Rm4(12),
		C01 => S20(5)
	);
	M119: fa00 port map(
		C00 => S20(5),
		A00 => S18(6),
		B00 => S19(6),
		S00 => Rm4(13),
		C01 => S20(6)
	);
	M120: fa00 port map(
		C00 => S20(6),
		A00 => S17(7),
		B00 => S19(7),
		S00 => Rm4(14),
		C01 => S20(7)
	);
	--Asignamiento final
	Rm4(15) <= S20(7);


end topmult8bit0;