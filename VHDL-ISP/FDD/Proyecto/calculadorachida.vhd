library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CalculadoraChida is

port( 
	A: in std_logic_vector ( 3 downto 0 );
	B: in std_logic_vector ( 3 downto 0 );
	SEL: in std_logic_vector (1 downto 0) ;
	SAL: OUT std_logic_vector ( 7 downto 0 ) );

end;

architecture calcu of CalculadoraChida is
begin
	process(A,B,SEL)
	begin
	case SEL is
	when "00" => SAL<="0000"&(A-B);
	when "01" => SAL<="0000"&(A+B);
	when "10" => SAL<=(A*B);	
	WHEN others => SAL<="00000000";
	end case;
	end process;

end calcu;
