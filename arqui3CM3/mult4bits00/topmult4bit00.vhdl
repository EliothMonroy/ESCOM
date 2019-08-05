library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packagemult4bit00.all;
entity topmult4bit00 is
	port(
		Am4: in std_logic_vector(3 downto 0);
		Bm4: in std_logic_vector(3 downto 0);
        Rm4: out std_logic_vector(7 downto 0));
	    --Puertos
		attribute loc: string;
		--Dip switch 1
		attribute loc of Am4: signal is "42,44,43,45";
		--Dip switch 2
		attribute loc of Bm4: signal is "52,55,54,56";
		--Pines leds rojo
		attribute loc of Rm4: signal is "24,23,22,21,20,19,14,13";
end topmult4bit00;
architecture topmult4bit0 of topmult4bit00 is
signal S0, S3, S6: std_logic_vector(2 downto 0);
signal S1, S2, S4: std_logic_vector(3 downto 0);
signal S5, S7, S8: std_logic_vector(3 downto 0);
begin
	M00: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(0),
		Ya => Rm4(0)
	);
	M01: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(0),
		Ya => S0(0)
	);
	M02: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(0),
		Ya => S0(1)
	);
	M03: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(0),
		Ya => S0(2)
	);
	M04: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(1),
		Ya => S1(0)
	);
	M05: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(1),
		Ya => S1(1)
	);
	M06: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(1),
		Ya => S1(2)
	);
	M07: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(1),
		Ya => S1(3)
	);
	M08: fa00 port map(
		C00 => '0',
		A00 => S0(0),
		B00 => S1(0),
		S00 => Rm4(1),
		C01 => S2(0)
	);
	M09: fa00 port map(
		C00 => S2(0),
		A00 => S0(1),
		B00 => S1(1),
		S00 => S3(0),
		C01 => S2(1)
	);
	M10: fa00 port map(
		C00 => S2(1),
		A00 => S0(2),
		B00 => S1(2),
		S00 => S3(1),
		C01 => S2(2)
	);
	M11: fa00 port map(
		C00 => S2(2),
		A00 => '0',
		B00 => S1(3),
		S00 => S3(2),
		C01 => S2(3)
	);
	M12: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(2),
		Ya => S4(0)
	);
	M13: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(2),
		Ya => S4(1)
	);
	M14: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(2),
		Ya => S4(2)
	);
	M15: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(2),
		Ya => S4(3)
	);
	M16: fa00 port map(
		C00 => '0',
		A00 => S3(0),
		B00 => S4(0),
		S00 => Rm4(2),
		C01 => S5(0)
	);
	M17: fa00 port map(
		C00 => S5(0),
		A00 => S3(1),
		B00 => S4(1),
		S00 => S6(0),
		C01 => S5(1)
	);
	M18: fa00 port map(
		C00 => S5(1),
		A00 => S3(2),
		B00 => S4(2),
		S00 => S6(1),
		C01 => S5(2)
	);
	M19: fa00 port map(
		C00 => S5(2),
		A00 => S2(3),
		 B00 => S4(3),
		 S00 => S6(2),
		 C01 => S5(3)
	 );
	M20: and00 port map(
		Aa => Am4(0),
		Ba => Bm4(3),
		Ya => S7(0)
	);
	M21: and00 port map(
		Aa => Am4(1),
		Ba => Bm4(3),
		Ya => S7(1)
	);
	M22: and00 port map(
		Aa => Am4(2),
		Ba => Bm4(3),
		Ya => S7(2)
	);
	M23: and00 port map(
		Aa => Am4(3),
		Ba => Bm4(3),
		Ya => S7(3)
	);
	M24: fa00 port map(
		C00 => '0',
		A00 => S6(0),
		B00 => S7(0),
		S00 => Rm4(3),
		C01 => S8(0)
	);					 
	M25: fa00 port map(
		C00 => S8(0),
		A00 => S6(1),
		B00 => S7(1),
		S00 => Rm4(4),
		C01 => S8(1)
	);					 
	M26: fa00 port map(
		C00 => S8(1),
		A00 => S6(2),
		B00 => S7(2),
		S00 => Rm4(5),
		C01 => S8(2)
	);
	M27: fa00 port map(
		C00 => S8(2),
		 A00 => S5(3),
		 B00 => S7(3),
		 S00 => Rm4(6),
		 C01 => S8(3)
	 );
	Rm4(7) <= S8(3);


end topmult4bit0;