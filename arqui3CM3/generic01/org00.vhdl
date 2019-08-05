library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity org00 is
	port (
		clko: in std_logic;
		codopgo: in std_logic_vector(4 downto 0);
		portAgo: in std_logic_vector(7 downto 0);
		portBgo: in std_logic_vector(7 downto 0);
		outgo: out std_logic_vector(15 downto 0);
		inFlago: in std_logic;
		outFlago: out std_logic
	);
end entity ; -- org00
architecture arch of org00 is
begin
	porg : process(clko)
	variable aux:bit:='0';
	begin
		if (clko'event and clko='1') then
			if codopgo="00001" then
			case(inFlago) is
				when '0' => 
					outFlago<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outgo(7 downto 0)<=portAgo or portBgo;
						outgo(15 downto 8)<="00000000";
						outFlago<='1';
					else
						outFlago<='0';
					end if ;
				when others =>null;
			end case ;
		else
			outgo<=(others=>'Z');
			outFlago<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- pandg
end architecture ; -- arch