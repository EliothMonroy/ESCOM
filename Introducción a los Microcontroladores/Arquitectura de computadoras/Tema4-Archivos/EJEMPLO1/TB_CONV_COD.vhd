--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:05:22 08/09/2012
-- Design Name:   
-- Module Name:   C:/CURSOS/ARQUITECTURA/CONV_COD/TB_CONV_COD.vhd
-- Project Name:  CONV_COD
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONV_COD
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_UNSIGNED.ALL;
USE ieee.std_logic_ARITH.ALL;
USE ieee.std_logic_TEXTIO.ALL;	--PERMITE USAR STD_LOGIC 
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_CONV_COD IS
END TB_CONV_COD;
 
ARCHITECTURE behavior OF TB_CONV_COD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONV_COD
    PORT(
         E : IN  std_logic_vector(2 downto 0);
         S : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal E : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(2 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant clock_period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONV_COD PORT MAP (
          E => E,
          S => S
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
	
	TYPE ARCHIVO_ENTERO IS FILE OF INTEGER;
	FILE MI_ARCHIVO : ARCHIVO_ENTERO IS IN  "ENTRADAS.TXT";

	VARIABLE DATO : INTEGER RANGE 0 TO 7;
   begin		
	
	WHILE NOT ENDFILE(MI_ARCHIVO) LOOP
		READ( MI_ARCHIVO, DATO );
		E <= CONV_STD_LOGIC_VECTOR( DATO, 3 );	
		WAIT FOR 100 NS;
	END LOOP;
   wait;
   end process;

--   stim_proc: process
--		BEGIN
--		wait for 100 ns;	
--		E <= "001";
--		wait for 100 ns;	
--		E <= "010";
--		wait for 100 ns;	
--		E <= "011";
--		wait for 100 ns;	
--		E <= "100";
--		wait for 100 ns;	
--		E <= "101";
--		wait for 100 ns;	
--		E <= "110";
--		wait for 100 ns;	
--		E <= "111";
--      wait;
--   end process;


--	stim_proc: process
--	BEGIN
--		wait for 100 ns;	
--		
--		IF( E = "111" )THEN
--			WAIT;
--		ELSE
--			E <= E + 1;
--		END IF;
--	END process;

END;
