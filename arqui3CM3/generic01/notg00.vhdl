library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity notg00 is
	port (
		clknot: in std_logic;
		codopgnot: in std_logic_vector(4 downto 0);
		portAgnot: in std_logic_vector(7 downto 0);
		outgnot: out std_logic_vector(15 downto 0);
		inFlagnot: in std_logic;
		outFlagnot: out std_logic
	);
end entity ; -- notg00
architecture arch of notg00 is
begin
	pnotg : process(clknot)
	variable aux:bit:='0';
	begin
		if (clknot'event and clknot='1') then
			if codopgnot="00011" then
			case(inFlagnot) is
				when '0' => 
					outFlagnot<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outgnot(7 downto 0)<=not(portAgnot);
						outgnot(15 downto 8)<="00000000";
						outFlagnot<='1';
					else
						outFlagnot<='0';
					end if ;
				when others =>null;
			end case ;
		else
			outgnot<=(others=>'Z');
			outFlagnot<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- pandg
end architecture ; -- arch