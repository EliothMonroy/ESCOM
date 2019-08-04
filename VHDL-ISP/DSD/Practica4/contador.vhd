library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador is

port( 
	ctrl: in std_logic_vector (2 downto 0);
	CLK,CLR: in std_logic;
	q: inout std_logic_vector (2 downto 0); 												--qa,qb,qc
	JKa,JKb,JKc: inout std_logic_vector (1 downto 0));										--ja,ka,jb,kb,jc,kc
	
	--Puertos 
	attribute loc: string;
	attribute loc of ctrl: signal is "p4";
	attribute loc of CLK: signal is "p5";
	attribute loc of CLR: signal is "p6";
	attribute loc of q: signal is "p28,p29,p30";
	attribute loc of JKa: signal is "p125,p124,p123";
	attribute loc of JKb: signal is "p122,p121,p120";
	attribute loc of JKc: signal is "p98,p97,p96";

end;

architecture a_contador of contador is
begin

	
	process(ctrl,CLR,CLK,JKa,JKb,JKc,q)
	begin
		JKa(0)<=(ctrl and (not q(1) and not q(2))) or (not ctrl and (q(1) and q(2))); --ja
		JKa(1)<=(ctrl and (not q(1) and not q(2))) or (not ctrl and (q(1) and q(2)));	--ka
		JKb(0)<=ctrl xor q(2);															--jb
		JKb(1)<=ctrl xor q(2);															--kb
		JKc(0)<='1';																	--jc
		JKc(1)<='1';																	--kc
	-------------------------------------------------ff1
		if(CLR='0') then
			Q(0)<='0';
			--NotQ(0) <= '1';
		elsif(CLK'EVENT AND CLK='1') then
			if(JKa="00") then
				Q(0)<= Q(0);
				--NotQ(0) <= not Q(0);
			elsif(JKa="01") then
				Q(0)<= '0';
				--NotQ(0) <= '1';
			elsif(JKa="10") then
				Q(0)<= '1';
				--NotQ(0) <= '0';
			elsif(JKa="11")  then
				Q(0) <= not Q(0);
				--NotQ(0) <= Q(0);
			end if;
		end if;
	-------------------------------------------------ff2
		if(CLR='0') then
			Q(1)<='0';
			--NotQ(1) <= '1';
		elsif(CLK'EVENT AND CLK='1') then
			if(JKb="00") then
				Q(1)<= Q(1);
				--NotQ(1) <= not Q(1);
			elsif(JKb="01") then
				Q(1)<= '0';
				--NotQ(1) <= '1';
			elsif(JKb="10") then
				Q(1)<= '1';
				--NotQ(1) <= '0';
			elsif(JKb="11")  then
				Q(1) <= not Q(1);
				--NotQ(1) <= Q(1);
			end if;
		end if;
	------------------------------------------------ff3
		if(CLR='0') then
			Q(2)<='0';
			--NotQ(2) <= '1';
		elsif(CLK'EVENT AND CLK='1') then
			if(JKc="00") then
				Q(2)<= Q(2);
				--NotQ(2) <= not Q(2);
			elsif(JKc="01") then
				Q(2)<= '0';
				--NotQ(2) <= '1';
			elsif(JKc="10") then
				Q(2)<= '1';
				--NotQ(2) <= '0';
			elsif(JKc="11")  then
				Q(2) <= not Q(2);
				--NotQ(2) <= Q(2);
			end if;
		end if;
	end process;
end a_contador;
