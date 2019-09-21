--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:55:12 09/12/2012
-- Design Name:   
-- Module Name:   C:/CURSOS/ARQUITECTURA/CONT_GEN/TB_CONT_GEN.vhd
-- Project Name:  CONT_GEN
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONT_GEN
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
LIBRARY STD;
USE STD.TEXTIO.ALL;
USE ieee.std_logic_TEXTIO.ALL;	--PERMITE USAR STD_LOGIC 

USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_UNSIGNED.ALL;
USE ieee.std_logic_ARITH.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_CONT_GEN IS
END TB_CONT_GEN;
 
ARCHITECTURE behavior OF TB_CONT_GEN IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONT_GEN
    PORT(
         CLK : IN  std_logic;
         CLR : IN  std_logic;
         D : IN  std_logic_vector(7 downto 0);
         OPER : IN  std_logic_vector(1 downto 0);
         Q : INOUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal CLR : std_logic := '0';
   signal D : std_logic_vector(7 downto 0) := (others => '0');
   signal OPER : std_logic_vector(1 downto 0) := (others => '0');

	--BiDirs
   signal Q : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONT_GEN PORT MAP (
          CLK => CLK,
          CLR => CLR,
          D => D,
          OPER => OPER,
          Q => Q
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process																	
   stim_proc: process
	file ARCH_RES : TEXT;																					
	variable LINEA_RES : line;
	VARIABLE VAR_Q : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	file ARCH_VEC : TEXT;
	variable LINEA_VEC : line;
	VARIABLE VAR_OPER : STD_LOGIC_VECTOR(1 DOWNTO 0);
	VARIABLE VAR_D : STD_LOGIC_VECTOR(7 DOWNTO 0);
	VARIABLE VAR_CLR : STD_LOGIC;
	VARIABLE CADENA : STRING(1 TO 4);
   begin		
		file_open(ARCH_VEC, "VECTORES.TXT", READ_MODE); 	
		file_open(ARCH_RES, "RESULTADO.TXT", WRITE_MODE); 	

		CADENA := "OPER";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "OPER"
		CADENA := "   D";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "   D"
		CADENA := " CLR";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA " CLR"
		CADENA := "   Q";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "   Q"
		writeline(ARCH_RES,LINEA_RES);-- escribe la linea en el archivo

		WAIT FOR 100 NS;
		FOR I IN 0 TO 14 LOOP
			readline(ARCH_VEC,LINEA_VEC); -- lee una linea completa

			read(LINEA_VEC, VAR_OPER);
			OPER <= VAR_OPER;
			Hread(LINEA_VEC, VAR_D);
			D <= VAR_D;		
			read(LINEA_VEC, VAR_CLR);  
			CLR <= VAR_CLR;
			
			WAIT UNTIL RISING_EDGE(CLK);	--ESPERO AL FLANCO DE SUBIDA 

			VAR_Q := Q;	
			write(LINEA_RES, VAR_OPER, right, 5);	--ESCRIBE EL CAMPO OPER
			Hwrite(LINEA_RES, VAR_D, 	right, 5);	--ESCRIBE EL CAMPO D
			write(LINEA_RES, VAR_CLR, 	right, 5);	--ESCRIBE EL CAMPO CLR
			Hwrite(LINEA_RES, VAR_Q, 	right, 5);	--ESCRIBE EL CAMPO Q

			writeline(ARCH_RES,LINEA_RES);-- escribe la linea en el archivo
			
		end loop;
		file_close(ARCH_VEC);  -- cierra el archivo
		file_close(ARCH_RES);  -- cierra el archivo

      wait;
   end process;
	
END;
