library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity coder00 is
	port(
		incontcd: in std_logic_vector(3 downto 0);
		inkeycd: in std_logic_vector(3 downto 0);
		clkcd: in std_logic;
		enablecd: in std_logic;
		rwcd:in std_logic;
		outcodercd: out std_logic_vector(3 downto 0);
		outcontwcd:inout std_logic_vector(4 downto 0);--Contador (es la dirección a escribir)
		outflagcd:out std_logic);
end coder00;
architecture coder0 of coder00 is
begin
	pcoder: process(incontcd,clkcd)
	variable aux0: bit:='0';
	variable aux1: bit:='0';
	variable aux2: bit:='0';
	variable aux3: bit:='0';
	begin
	if(clkcd'event and clkcd='1') then
		if(enablecd='0') then
			outcodercd<=(others =>'0');--Apagamos display
			outcontwcd<=(others =>'1');
			outflagcd<='0';
		elsif ((enablecd='1') and (rwcd='1')) then
			outcontwcd<=outcontwcd;
		elsif((enablecd='1') and (rwcd='0')) then 
			case incontcd is --Contador de anillo
				when "1000" => 
					case inkeycd is --Entrada teclado
						when "0000" =>
							aux0:='0';
							outcontwcd<=outcontwcd;
							outflagcd<='0';
						when "0001" =>
							if(aux0='0') then
								aux0:='1';
								outcodercd<="0001";-- 1
								outcontwcd<=outcontwcd+'1';--Aumentamos en 1 el contador
								outflagcd<='1';--Indicamos a la ram que escriba el valor
							end if;
						when "0010" =>
							if(aux0='0') then
								aux0:='1';
								outcodercd<="0010"; -- 2
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when "0100" =>
							if(aux0='0') then
								aux0:='1';
								outcodercd<="0011"; -- 3
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when others =>null;
					end case;
				when "0100" => 
					case inkeycd is
						when "0000" =>
							aux1:='0';
							outcontwcd<=outcontwcd;
							outflagcd<='0';
						when "0001" =>
							if(aux1='0') then
								aux1:='1';
								outcodercd<="0100"; -- 4
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when "0010" =>
							if(aux1='0') then
								aux1:='1';
								outcodercd<="0101"; -- 5
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when "0100" =>
							if(aux1='0') then
								aux1:='1';
								outcodercd<="0110"; -- 6
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when others =>null;
					end case;
				when "0010" => 
					case inkeycd is
						when "0000" =>
							aux2:='0';
							outcontwcd<=outcontwcd;
							outflagcd<='0';
						when "0001" =>
							if(aux2='0') then
								aux2:='1';
								outcodercd<="0111"; -- 7
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when "0010" =>
							if(aux2='0') then
								aux2:='1';
								outcodercd<="1000"; -- 8
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when "0100" =>
							if(aux2='0') then
								aux2:='1';
								outcodercd<="1001"; -- 9
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when others =>null;
					end case;
				when "0001" => 
					case inkeycd is
						when "0010" =>
							if(aux3='0') then
								aux3:='1';
								outcodercd<="0000"; -- 0
								outcontwcd<=outcontwcd+'1';
								outflagcd<='1';
							end if;
						when others =>null;
					end case;
				when others => null;
			end case;
			end if;
		end if;
	end process pcoder;
end coder0;