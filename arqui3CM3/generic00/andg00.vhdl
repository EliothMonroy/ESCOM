library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
entity andg00 is
	port (
		clka: in std_logic;
		codopga: in std_logic_vector(4 downto 0);
		portAga: in std_logic_vector(7 downto 0);
		portBga: in std_logic_vector(7 downto 0);
		outga: out std_logic_vector(7 downto 0);
		inFlaga: in std_logic;
		outFlaga: out std_logic
	);
end entity ; -- andg00
architecture arch of andg00 is
begin
	pandg : process(clka)
	variable aux:bit:='0';
	begin
		if (clka'event and clka='1') then
			if codopga="00000" then
			case(inFlaga) is
				when '0' => 
					outFlaga<='0';
					aux:='0';
				when '1' =>
					if aux='0' then
						aux:='1';
						outga<=portAga and portBga;
						outFlaga<='1';
					else
						outFlaga<='0';
					end if ;
				when others =>null;
			end case ;
		else
			outga<=(others=>'Z');
			outFlaga<='Z';
			aux:='0';
		end if ;
	end if ;
	end process ; -- pandg
end architecture ; -- arch