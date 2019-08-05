library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sust04 is

port( 
	clksu: in std_logic ;
	codopsu: in std_logic_vector ( 3 downto 0 );
	inAC8bitsu: in std_logic_vector ( 7 downto 0 );
	inAC12bitsu: in std_logic_vector ( 11 downto 0 );
	inFlagAC12su: in std_logic ;
	outAC12bitsu: out std_logic_vector ( 11 downto 0 );
	outsust: out std_logic_vector ( 11 downto 0 );
	outFlagsuB: out std_logic;
	outFlagsu: out std_logic  );

end;

architecture sust0 of sust04 is
begin
  processust: process(clksu, codopsu, inAC8bitsu, inAC12bitsu, inFlagAC12su)
  variable aux: bit:= '0';
  begin
     if (clksu'event and clksu = '1') then
         if (codopsu = "0010") then
            if (inFlagAC12su = '1') then
                outAC12bitsu <= inAC12bitsu(11 downto 1)&inAC8bitsu(7);
                outsust <= inAC12bitsu(11 downto 1)&inAC8bitsu(7);
                outFlagsu <= '1';
	        outFlagsuB <= '1';
            else
                outFlagsu <= '0';
	        outFlagsuB <= '0';
            end if;
         else
             outAC12bitsu <= (others => 'Z');
             --outsust <= (others => 'Z');
             outFlagsu <= 'Z';
	     outFlagsuB <= 'Z';
             aux:= '0';
         end if;
     end if;
  end process processust;
end sust0;
