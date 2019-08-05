library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity shift12bit04 is

port( 
	clkss: in std_logic ;
	codopss: in std_logic_vector ( 3 downto 0 );
	inACss: in std_logic_vector ( 11 downto 0 );
	inFlagss: in std_logic ;
	outACss: inout std_logic_vector ( 11 downto 0 );
	outFlagss: out std_logic  );

end;

architecture shift12bit0 of shift12bit04 is
begin
  shiftp12: process(clkss, codopss, inACss, inFlagss)
  variable aux: bit := '0';
    begin
      if (clkss'event and clkss = '1') then
         if (codopss = "0101") then
             if (inFlagss = '1') then
                if (aux = '0') then
                    aux := '1';
                    outFlagss <= '1';
                    outACss(0) <= '0';
                    outACss(11 downto 1) <= inACss(10 downto 0);
                elsif (aux = '1') then
                    outFlagss <= '0';
                end if;
             elsif (inFlagss = '0') then
                    outFlagss <= '0';
             end if;
         else
             outACss <= (others => 'Z');
             outFlagss <= 'Z';
             aux := '0';
         end if;
      end if;
    end process shiftp12;
end shift12bit0;
