-- Author : Andrés Saldaña (https://github.com/andresSaldanaAguilar)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity d is port( 
	
	A,B,C,D: in std_logic_vector (1 downto 0); --diferentes entradas de valores
	S: in std_logic_vector(1 downto 0); --selector
	O: inout std_logic_vector (1 downto 0); --salida del demux
								       --display
	E: in std_logic_vector (1 downto 0); --entrada del valor seleccionado
	F,I,H: out std_logic_vector (6 downto 0);	--displays

	G: in std_logic_vector(1 downto 0);	--comparador numero de ref
	X,Y,Z: inout std_logic);
	
	
	
	attribute loc: string;
    attribute loc of A: signal is "p4,p5";	--demux
    attribute loc of B: signal is "p6,p7";
    attribute loc of C: signal is "p8,p9";
    attribute loc of D: signal is "p11,p12";
	attribute loc of S: signal is "p13,p14";
	attribute loc of O: signal is "p15,p16"; --demux

	attribute loc of E:signal is "p17,p20";
	attribute loc of F:signal is "p125,p124,p123,p122,p121,p120,p116"; --Display 1
			                   --   A   B    C    D    E    F   G	

	attribute loc of G:signal is "p28,p29";
	attribute loc of I:signal is "p98,p97,p96,p95,p94,p93,p88"; --Display 2
			                  --   A   B   C   D   E   F   G  

	attribute loc of H:signal is "p66,p67,p68,p69,p70,p71,p58"; --Display 3
			                  --   A   B   C  D    E   F   G	 
 
end;

architecture behavioral of d is
begin
-----------------------------
Process(S,A,B,C,D)
variable temp : std_logic_vector (1 downto 0);            -- declaracion de variable temporal
	Begin
	

	if(S="00")then
	temp:=A;
	
	elsif(S="01")then                   
	temp:=B;
	
	elsif(S="10")then
	temp:=C;
	
	else
	temp:=D;
	end if;                                
	
	O<=temp;                       
end Process;
-----------------------------
Process(O) begin
		--Display de la salida del mux
		case O is--Anodo (Prende con ceros)
				       --ABCDEFG
			when "00" =>F<= "0000001";
			when "01" =>F<= "1001111";
			when "10" =>F<= "0010010";
			when "11" =>F<= "0000110";
		end case;
end process ; 
-----------------------------Comparador y salida del mux
process(G,O)
	-- Display salida del que dice si es mayor, menor igual
	Begin
	if (G=O) then
		I<="1110110";
	elsif (G>O) then
		I<= "1110010";
	else
		I<="1100110";
	end if;
end process;
-----------------------------

-----------------------------
Process(G) begin
		--Display del selector
		case G is--Anodo (Prende con ceros)
				       --ABCDEFG
			when "00" =>H<= "1111110";
			when "01" =>H<= "0110000";
			when "10" =>H<= "1101101";
			when "11" =>H<= "1111001";
		end case;
end process ; 
------------------------------

end behavioral;




