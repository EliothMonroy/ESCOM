library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity leeInst04 is

port( 
	inFlagInstrom: in std_logic ;
	outFlagrom: out std_logic ;
	inPCrom: in std_logic_vector ( 3 downto 0 );
	outcode: out std_logic_vector(3 downto 0)  );

end;

architecture leeInst0 of leeInst04 is
type arrayrom is array(0 TO 16) OF std_logic_vector(3 downto 0);
constant memrom: arrayrom:= ("0000",
                             "0001",
                             "0010",
			     "0011",
			     "0100",
			     "0101",
			     "0110",
			     others => "0000");

begin
  romp: process(inFlagInstrom, inPCrom)
    begin
         if (inFlagInstrom = '1') then
               outcode <= memrom(conv_integer(inPCrom));
             outFlagrom <= '1';
         elsif (inFlagInstrom = '0') then 
             outFlagrom <= '0';
         end if;
    end process romp;
end leeInst0;
