library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity addg00 is
	port (
		clkgadd: in std_logic;
		codopgadd: in std_logic_vector(4 downto 0);
		inadd: in std_logic_vector(15 downto 0);
		inLEDadd: in std_logic;
		outgadd: out std_logic_vector(15 downto 0);
		inFlagadd: in std_logic;
		outFlagadd: out std_logic;
		outoverflowadd:out std_logic;
		outSLadd: out std_logic
	);
end entity ; -- addg00
architecture arch of addg00 is
begin
	paddg : process(clkgadd)
	variable aux:bit:='0';
	begin
		if (clkgadd'event and clkgadd='1') then
			if codopgadd="00111" then
			case(inFlagadd) is
				when '0' => 
					outFlagadd<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outFlagadd<='0';
						outSLadd<='0';
					else
						outFlagadd<='1';
						outgadd<=inadd;
						outoverflowadd<=inLEDadd;
					end if ;
				when others =>null;
			end case ;
		else
			outgadd<=(others=>'Z');
			outFlagadd<='Z';
			outSLadd<='Z';
			outoverflowadd<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- paddg
end architecture ; -- arch