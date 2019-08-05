library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
entity coder00 is
	port(
		incont: in std_logic_vector(3 downto 0);
		inkey: in std_logic_vector(3 downto 0);
		clkc: in std_logic;
		outcoder: out std_logic_vector(6 downto 0));
end coder00;
architecture coder0 of coder00 is
begin
	pcoder: process(incont,clkc)
	variable aux0: bit:='0';
	variable aux1: bit:='0';
	variable aux2: bit:='0';
	variable aux3: bit:='0';
	begin
	if(clkc'event and clkc='1') then
		--Falta señal de relog
			case incont is
				when "1000" => 
					case inkey is
						when "0000" =>
							aux0:='0';						
						when "0001" =>
							if(aux0='0') then
								aux0:='1';
								outcoder<="0110000"; -- 1							
							end if;
						when "0010" =>
							if(aux0='0') then
								aux0:='1';
								outcoder<="1101101"; -- 2							
							end if;
						when "0100" =>
							if(aux0='0') then
								aux0:='1';
								outcoder<="1111001"; -- 3							
							end if;
						when "1000" =>
							if(aux0='0') then
								aux0:='1';
								outcoder<="1110111"; -- A							
							end if;
						when others =>null;
					end case;
				when "0100" => 
					case inkey is
						when "0000" =>
							aux1:='0';						
						when "0001" =>
							if(aux1='0') then
								aux1:='1';
								outcoder<="0110011"; -- 4							
							end if;
						when "0010" =>
							if(aux1='0') then
								aux1:='1';
								outcoder<="1011011"; -- 5							
							end if;
						when "0100" =>
							if(aux1='0') then
								aux1:='1';
								outcoder<="1011111"; -- 6							
							end if;
						when "1000" =>
							if(aux1='0') then
								aux1:='1';
								outcoder<="0011111"; -- b							
							end if;
						when others =>null;
					end case;
				when "0010" => 
					case inkey is
						when "0000" =>
							aux2:='0';						
						when "0001" =>
							if(aux2='0') then
								aux2:='1';
								outcoder<="1110000"; -- 7							
							end if;
						when "0010" =>
							if(aux2='0') then
								aux2:='1';
								outcoder<="1111111"; -- 8							
							end if;
						when "0100" =>
							if(aux2='0') then
								aux2:='1';
								outcoder<="1110011"; -- 9							
							end if;
						when "1000" =>
							if(aux2='0') then
								aux2:='1';
								outcoder<="1001110"; -- c							
							end if;
						when others =>null;
					end case;
				when "0001" => 
					case inkey is
						when "0000" =>
							aux3:='0';						
						when "0001" =>
							if(aux3='0') then
								aux3:='1';
								outcoder<="1100011"; -- *							
							end if;
						when "0010" =>
							if(aux3='0') then
								aux3:='1';
								outcoder<="1111110"; -- 0							
							end if;
						when "0100" =>
							if(aux3='0') then
								aux3:='1';
								outcoder<="0011101"; -- +							
							end if;
						when "1000" =>
							if(aux3='0') then
								aux3:='1';
								outcoder<="0000001"; -- (-)							
							end if;
						when others =>null;
					end case;
				when others => null;
			end case;
		end if;		
	end process pcoder;
end coder0;