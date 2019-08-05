library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity uc00 is
	port (
		clkuc: in std_logic;
		enableuc: in std_logic;
		inuc: in std_logic_vector(7 downto 0);
		inFlaguc: in std_logic;
		outuc: out std_logic_vector(7 downto 0);
		outFlaguc: out std_logic
	);
end entity ; -- uc00
architecture arch of uc00 is
begin
	puc : process(clkuc)
	variable aux:bit:='0';
	begin
		if (clkuc'event and clkuc='1') then
			case(enableuc) is
				when '0' =>
					outuc<=(others=>'0');
					outFlaguc<='0';
					aux:='0';
				when '1' =>
					if (aux='0' or inFlaguc='1') then
						aux:='1';
						outuc<=inuc;
						outFlaguc<='1';
					elsif aux='1' then
						aux:='0';
						outFlaguc<='1';
					end if ;
				when others =>null;
			end case ;
		end if ;
	end process ; -- puc
end architecture ; -- arch