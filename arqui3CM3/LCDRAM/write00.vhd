library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity write00 is
  port(inFlagw : in  std_logic;-- VIENE DEL MÓDULO "config00"
       inFlagwx: in  std_logic;--viene del módulo "contw00"
       incontw : in  std_logic_vector(5 downto 0);
       outwordw: out std_logic_vector(7 downto 0);
       outFlagw: out std_logic);-- VA HACIA EL MÓDULO "bufferlcd00" Y HACIA "contw00" Y HACIA EL EXTERIOR
end write00;

architecture write0 of write00 is
type arrayrom is array(0 to 31) of std_logic_vector(7 downto 0);
constant dato: arrayrom:=("01000001",--A
                          "01001100",--L
			  "01000010",--B
			  "01000101",--E
			  "01010010",--R
                          "01010100",--T
                          "01001111",--O
                          "10100000",--espacio
			  "01010010",--R
                          "01001001",--I
                          "01001111",--O
                          "01010011",--S
                          "10100000",--espacio
                          "01000001",--A
                          "01001100",--L
			  "01000101",--E
			  "01011000",--X
                          "01001001",--I
                          "01010011",--S
                          "10100000",--espacio
                          "01001111",--O
                          "01010011",--S
			  "01001110",--N
                          "01000001",--A
                          "01011001",--Y
                          "01000001",--A
                          others => "10100101");
begin
  pwrite: process(inFlagw, incontw)
  begin
     case inFlagw is
       when '0' =>
           outwordw <= "00110000";
           outFlagw <= '1';
       when '1' =>
           if (incontw < "100000") then
               if (inFlagwx = '1') then
                   outFlagw <= '0';
	       else
		   outwordw <= dato(conv_integer(incontw));
		   outFlagw <= '1';
	       end if;
	   end if;
       when others => null;
     end case;
 end process pwrite;
end write0;

