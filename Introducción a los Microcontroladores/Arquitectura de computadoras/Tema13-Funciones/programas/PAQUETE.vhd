LIBRARY STD;
library IEEE;

USE STD.TEXTIO.ALL;
USE ieee.std_logic_TEXTIO.ALL;	--PERMITE USAR STD_LOGIC 

use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

package PAQUETE is
	CONSTANT ADDR_N : INTEGER := 4;
	CONSTANT DATA_N : INTEGER := 8;
	TYPE MEMORIA IS ARRAY(0 TO 2**ADDR_N-1) OF STD_LOGIC_VECTOR(DATA_N-1 DOWNTO 0);

-- function <function_name>  (signal <signal_name> : in <type_declaration>) 
-- return <type_declaration>;
	impure function LLENAR_ROM(ARCHIVO : in string) return MEMORIA;
end PAQUETE;

package body PAQUETE is

	impure function LLENAR_ROM(ARCHIVO : in string) return MEMORIA is                                                   
		FILE ARCH_DATOS      : text is in ARCHIVO;                       
		variable LINEA_DATOS : line;                                 
		variable MEM_ROM     : MEMORIA; 
	begin                                                        
	 for I in MEMORIA'range loop                                  
		  readline(ARCH_DATOS, LINEA_DATOS);                             
		  Hread (LINEA_DATOS, MEM_ROM(I));                                  
	 end loop;                                                    
	 return MEM_ROM;                                                  
	end function;                                                

end PAQUETE;

