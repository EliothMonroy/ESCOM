library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity lcdmux00 is
	port (
		clklm: in std_logic;
		resetlm: in std_logic;
		inflagclm: in std_logic;--lógica fuerte
		inflagdlm: in std_logic;-- viene de la rom
		inwordclm:in std_logic_vector(7 downto 0);
		inworddlm: in std_logic_vector(7 downto 0);
		RWc: in std_logic;
		RSc:in std_logic;
		ENc:in std_logic;
		RWd: in std_logic;
		RSd: in std_logic;
		ENdd: in std_logic;
		outwordlm: inout std_logic_vector(7 downto 0);
		RWlm: out std_logic;
		RSlm: out std_logic;
		ENlm: out std_logic
	);
end entity ; -- lcdmux00
architecture arch of lcdmux00 is
begin
	plcdmux : process(clklm,inwordclm,inworddlm)
	begin
		if (clklm'event and clklm='1') then
			case(resetlm) is
				when '0' =>
					--Colocamos todas las salidas en cero
					outwordlm<="00100010";
					RWlm<='0';
					RSlm<='0';
					ENlm<='0';
				when '1' =>
					case(inflagclm) is
						when '0' =>
							outwordlm<=inwordclm;
							RWlm<=RWc;
							RSlm<=RSc;
							ENlm<=ENc;
						when '1' =>
							--if inflagdlm='1' then
							outwordlm<=inworddlm;
							RWlm<=RWd;
							RSlm<=RSd;
							ENlm<=ENdd;
							--end if ;
						when others =>null;
					end case ;
				when others =>null;
			end case ;
		end if ;
	end process ; -- plcdmux
end architecture ; -- arch