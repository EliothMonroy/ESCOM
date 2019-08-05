library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity xorg00 is
	port (
		clkx: in std_logic;
		codopx: in std_logic_vector(4 downto 0);
		portAgx: in std_logic_vector(7 downto 0);
		portBgx: in std_logic_vector(7 downto 0);
		outgx: out std_logic_vector(7 downto 0);
		inFlagx: in std_logic;
		outFlagx: out std_logic
	);
end entity ; -- xorg00
architecture arch of xorg00 is
begin
	pandg : process(clkx)
	variable aux:bit:='0';
	begin
		if (clkx'event and clkx='1') then
			if codopx="00010" then
			case(inFlagx) is
				when '0' => 
					outFlagx<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outgx<=portAgx xor portBgx;
						outFlagx<='1';
					else
						outFlagx<='0';
					end if ;
				when others =>null;
			end case ;
		else
			outgx<=(others=>'Z');
			outFlagx<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- pandg
end architecture ; -- arch