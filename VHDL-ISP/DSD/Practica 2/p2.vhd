-- Author : Andrés Saldaña (https://github.com/andresSaldanaAguilar)
library ieee;
use ieee.std_logic_1164.all;
entity fdd is
port(   
	CLR,CLK,PRE,D: in std_logic; --ff_d
	Q, NotQ: out std_logic;    --ff_d
	
	CLR1,PRE1,T: in std_logic; --ff_t
	Q1, NotQ1: inout std_logic; --ff_t

	CLR2,PRE2,J,K: in std_logic; --ff_t
	Q2, NotQ2: inout std_logic; --ff_t

	CLR3,PRE3,S,R: in std_logic; --ff_t
	Q3, NotQ3: inout std_logic --ff_t	

);


	--Puertos ff_d
	attribute loc: string;
	attribute loc of D: signal is "p4";
	attribute loc of CLK: signal is "p5";
	attribute loc of PRE: signal is "p6";
	attribute loc of NotQ: signal is "p8";
	attribute loc of Q: signal is "p9";
	attribute loc of CLR: signal is "p7";

	--Puertos ff_t
	attribute loc: string;
	attribute loc of T: signal is "p28";
	attribute loc of PRE1: signal is "p29";
	attribute loc of Q1: signal is "p30";
	attribute loc of NotQ1: signal is "p31";
	attribute loc of CLR1: signal is "p32";

	--Puertos ff_jk
	attribute loc: string;
	attribute loc of J: signal is "p125";
	attribute loc of K: signal is "p124";
	attribute loc of PRE2: signal is "p123";
	attribute loc of Q2: signal is "p122";
	attribute loc of NotQ2: signal is "p121";
	attribute loc of CLR2: signal is "p120";

	--Puertos ff_sr
	attribute loc: string;
	attribute loc of S: signal is "p98";
	attribute loc of R: signal is "p97";
	attribute loc of PRE2: signal is "p96";
	attribute loc of Q2: signal is "p95";
	attribute loc of NotQ2: signal is "p94";
	attribute loc of CLR2: signal is "p93";


	

end fdd;

architecture arq_ffd of fdd is
begin


------------------------------------------- ff_d

process(CLR,CLK,PRE,D)
begin
	if(CLR='0') then
		Q<='0';
		NotQ <= '1';
	elsif(CLK'EVENT AND CLK='1') then
		if(PRE='1') then
			Q<='1';
			NotQ<='0';
		elsif(D='0') then
			Q<='0';
			NotQ <= '1';
		elsif(D='1') then
			Q<='1';
			NotQ<='0';
		end if;
	end if;
end process;

------------------------------------------- ff_t

process(CLR1,CLK,PRE1,T)
begin
	if(CLR1='0') then
		Q1<='0';
		NotQ1 <= '1';
	elsif(CLK'EVENT AND CLK='1') then
		if(PRE1='1') then
			Q1<='1';
			NotQ1<='0';
		elsif(T='0') then
			Q1<= Q1;
			NotQ1 <= not Q1;
		elsif(T='1') then
			Q1<= not Q1;
			NotQ1 <= Q1;
		end if;
	end if;
end process;


------------------------------------------- ff_jk

process(CLR2,CLK,PRE2,J,K)
begin
	if(CLR2='0') then
		Q2<='0';
		NotQ2 <= '1';
	elsif(CLK'EVENT AND CLK='1') then
		if(PRE2='1') then
			Q2<='1';
			NotQ2<='0';
		elsif(J='0'AND K='0') then
			Q2<= Q2;
			NotQ2 <= not Q2;
		elsif(J='0'AND K='1') then
			Q2<= '0';
			NotQ2 <= '1';
		elsif(J='1'AND K='0') then
			Q2<= '1';
			NotQ2 <= '0';
		elsif(J='1'AND K='1')  then
			Q2 <= not Q2;
			NotQ2 <= Q2;
		end if;
	end if;
end process;

------------------------------------------- ff_sr

process(CLR3,CLK,PRE3,S,R)
begin
	if(CLR3='0') then
		Q3<='0';
		NotQ3 <= '1';
	elsif(CLK'EVENT AND CLK='1') then
		if(PRE3='1') then
			Q3<='1';
			NotQ3<='0';
		elsif(S='0'AND R='0') then
			Q3<= Q3;
			NotQ3 <= not Q3;
		elsif(S='0'AND R='1') then
			Q3<= '0';
			NotQ3 <= '1';
		elsif(S='1'AND R='0') then
			Q3<= '1';
			NotQ3 <= '0';
		elsif(S='1'AND R='1')  then
			Q3 <= '1';
			NotQ3 <= '1';
		end if;
	end if;
end process;
end;