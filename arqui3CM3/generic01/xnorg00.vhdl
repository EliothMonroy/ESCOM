library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity xnorg00 is
	port (
		clkxnor: in std_logic;
		codopgxnor: in std_logic_vector(4 downto 0);
		portAgxnor: in std_logic_vector(7 downto 0);
		portBgxnor: in std_logic_vector(7 downto 0);
		outgxnor: out std_logic_vector(15 downto 0);
		inFlagxnor: in std_logic;
		outFlagxnor: out std_logic
	);
end entity ; -- xnorg00
architecture arch of xnorg00 is
begin
	pxnorg : process(clkxnor)
	variable aux:bit:='0';
	begin
		if (clkxnor'event and clkxnor='1') then
			if codopgxnor="00110" then
			case(inFlagxnor) is
				when '0' => 
					outFlagxnor<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outgxnor(7 downto 0)<=portAgxnor xnor portBgxnor;
						outgxnor(15 downto 8)<="00000000";
						outFlagxnor<='1';
					else
						outFlagxnor<='0';
					end if ;
				when others =>null;
			end case ;
		else
			outgxnor<=(others=>'Z');
			outFlagxnor<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- pandg
end architecture ; -- arch