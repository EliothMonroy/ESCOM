LIBRARY ieee;
LIBRARY generics;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE generics.components.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT CalculadoraChida
	PORT(
		A : IN std_logic_vector(4 downto 0);
		B : IN std_logic_vector(4 downto 0);
		SEL : IN std_logic_vector(1 downto 0);          
		SAL : OUT std_logic_vector(9 downto 0)
		);
	END COMPONENT;

	SIGNAL A :  std_logic_vector(4 downto 0);
	SIGNAL B :  std_logic_vector(4 downto 0);
	SIGNAL SEL :  std_logic_vector(1 downto 0);
	SIGNAL SAL :  std_logic_vector(9 downto 0);

BEGIN

	uut: CalculadoraChida PORT MAP(
		A => A,
		B => B,
		SEL => SEL,
		SAL => SAL
	);


-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;

