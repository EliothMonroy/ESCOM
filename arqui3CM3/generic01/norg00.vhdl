library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity norg00 is
	port (
		clknor: in std_logic;
		codopgnor: in std_logic_vector(4 downto 0);
		portAgnor: in std_logic_vector(7 downto 0);
		portBgnor: in std_logic_vector(7 downto 0);
		outgnor: out std_logic_vector(15 downto 0);
		inFlagnor: in std_logic;
		outFlagnor: out std_logic
	);
end entity ; -- norg00
architecture arch of norg00 is
begin
	pandg : process(clknor)
	variable aux:bit:='0';
	begin
		if (clknor'event and clknor='1') then
			if codopgnor="00101" then
			case(inFlagnor) is
				when '0' => 
					outFlagnor<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outgnor(7 downto 0)<=portAgnor nor portBgnor;
						outgnor(15 downto 8)<="00000000";
						outFlagnor<='1';
					else
						outFlagnor<='0';
					end if ;
				when others =>null;
			end case ;
		else
			outgnor<=(others=>'Z');
			outFlagnor<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- pandg
end architecture ; -- arch