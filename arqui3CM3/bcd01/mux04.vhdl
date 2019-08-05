library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mux04 is

port( 
	selmux: in std_logic_vector ( 3 downto 0 );
	intBCDU: in std_logic_vector ( 6 downto 0 );
	intBCDD: in std_logic_vector ( 6 downto 0 );
	intBCDC: in std_logic_vector ( 6 downto 0 );
	outBCDmux: out std_logic_vector ( 6 downto 0 ) );

end;

architecture mux0 of mux04 is
begin
  muxp: process(selmux)
    begin
       case selmux is
         when "1110" =>
           outBCDmux <= intBCDU;
         when "1101" =>
           outBCDmux <= intBCDD;
         when "1011" =>
           outBCDmux <= intBCDC;
         when "0111" =>
           outBCDmux <= "0000001";
         when others => null;
       end case; 
    end process muxp;
end mux0;
