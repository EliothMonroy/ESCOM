library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity multg00 is
	port (
		clkmult: in std_logic;
		codopgmult: in std_logic_vector(4 downto 0);
		inmult: in std_logic_vector(15 downto 0);
		outgmult: out std_logic_vector(15 downto 0);
		inFlagmult: in std_logic;
		outFlagmult: out std_logic
	);
end entity ; -- multg00
architecture arch of multg00 is
begin
	paddg : process(clkmult)
	variable aux:bit:='0';
	begin
		if (clkmult'event and clkmult='1') then
			if codopgmult="01001" then
			case(inFlagmult) is
				when '0' => 
					outFlagmult<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outFlagmult<='0';
					else
						outgmult<=inmult;
					end if ;
				when others =>null;
			end case ;
		else
			outgmult<=(others=>'Z');
			outFlagmult<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- paddg
end architecture ; -- arch