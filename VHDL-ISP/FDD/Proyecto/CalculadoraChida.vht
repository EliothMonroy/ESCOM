
-- VHDL Test Bench Created from source file CalculadoraChida.vhd -- 12/11/16  21:28:20
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Lattice recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "source->import"
-- menu in the ispLEVER Project Navigator to import the testbench.
-- Then edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
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
