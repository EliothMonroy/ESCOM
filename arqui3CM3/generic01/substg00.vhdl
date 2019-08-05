library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity substg00 is
	port (
		clkgsub: in std_logic;
		codopgsub: in std_logic_vector(4 downto 0);
		insub: in std_logic_vector(15 downto 0);
		inLEDsub: in std_logic;
		outgsub: out std_logic_vector(15 downto 0);
		inFlagsub: in std_logic;
		outFlagsub: out std_logic;
		outoverflowsub:out std_logic;
		outSLsub: out std_logic
	);
end entity ; -- substg00
architecture arch of substg00 is
begin
	psubstg : process(clkgsub)
	variable aux:bit:='0';
	begin
		if (clkgsub'event and clkgsub='1') then
			if codopgsub="01000" then
			case(inFlagsub) is
				when '0' => 
					outFlagsub<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outFlagsub<='0';
						outSLsub<='1';
					else
						outFlagsub<='1';
						outgsub<=insub;
						outoverflowsub<=inLEDsub;
					end if ;
				when others =>null;
			end case ;
		else
			outgsub<=(others=>'Z');
			outFlagsub<='Z';
			outSLsub<='Z';
			outoverflowsub<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- psubstg
end architecture ; -- arch