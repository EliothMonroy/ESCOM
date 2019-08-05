library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity lcddata00 is
	port(
		clkdd:in std_logic;
		resetdd:in std_logic;
		inFlagdd:in std_logic;
		inflagcf: in std_logic;
		indirdd:in std_logic_vector(4 downto 0);
		outworddd:out std_logic_vector(7 downto 0);
		outFlagdd:out std_logic
	);
end entity ; -- lcddata00
architecture arch of lcddata00 is
type arraydata is array(0 to 63) of std_logic_vector(7 downto 0);
constant worddata:arraydata:=(
			"01000101",--E
			"01001100",--L
			"01001001",--I
			"01001111",--O
			"01010100",--T
			"01001000",--H
			"00100000",--Espacio
			"01001101",--M
			"01001111",--O
			"01001110",--N
			"01010010",--R
			"01001111",--O
			"01011001",--Y
			"00100000",--Espacio
			"00100000",--Espacio
			"01001101",--M
			"01001111",--O
			"01001110",--N
			"01010010",--R
			"01001111",--O
			"01011001",--Y
			others => "01000011"
		);
begin
	pdata : process(clkdd,indirdd)
	begin
		if (clkdd'event and clkdd='1') then
			case(resetdd) is
				when '0' =>
					--Todo a ceros
					outworddd<=(others=>'0');
					outFlagdd<='0';
				when '1' =>
					case(inflagcf) is
						when '0' =>
							--Todo a ceros
							outworddd<=(others=>'0');
							outFlagdd<='0';
						when '1' =>
							if inFlagdd='1' then
								outworddd<=worddata(conv_integer(indirdd));
							end if ;
						when others =>null;
					end case ;
				when others =>null;
			end case ;
		end if ;
	end process ; -- pdata
end architecture ; -- arch