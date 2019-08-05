library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity nandg00 is
	port (
		clknand: in std_logic;
		codopgnand: in std_logic_vector(4 downto 0);
		portAgnand: in std_logic_vector(7 downto 0);
		portBgnand: in std_logic_vector(7 downto 0);
		outgnand: out std_logic_vector(15 downto 0);
		inFlagnand: in std_logic;
		outFlagnand: out std_logic
	);
end entity ; -- nandg00
architecture arch of nandg00 is
begin
	pnandg : process(clknand)
	variable aux:bit:='0';
	begin
		if (clknand'event and clknand='1') then
			if codopgnand="00100" then
			case(inFlagnand) is
				when '0' => 
					outFlagnand<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outgnand(7 downto 0)<=portAgnand nand portBgnand;
						outgnand(15 downto 8)<="00000000";
						outFlagnand<='1';
					else
						outFlagnand<='0';
					end if ;
				when others =>null;
			end case ;
		else
			outgnand<=(others=>'Z');
			outFlagnand<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- pandg
end architecture ; -- arch