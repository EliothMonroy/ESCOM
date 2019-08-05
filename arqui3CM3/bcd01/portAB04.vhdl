library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity portAB04 is

port( 
	clkLp: in std_logic ;
	codopLp: in std_logic_vector ( 3 downto 0 );
	portALp: in std_logic_vector ( 7 downto 0 );
	ACLpA: out std_logic_vector ( 7 downto 0 );
	inFlagLp: in std_logic ;
	outFlagLp: out std_logic  );

end;

architecture portAB0 of portAB04 is
begin
  readport: process(clkLp, codopLp, portALp, inFlagLp)
    begin
      if (clkLp'event and clkLp = '1') then
         if (codopLp = "0001") then
              if (inFlagLp = '1') then
                 ACLpA <= portALp;
                 outFlagLp <= '1';
              elsif (inFlagLp = '0') then
                   outFlagLp <= '0';
              end if;
          else
                 ACLpA <= (others => 'Z');
                 outFlagLp <= 'Z';
        end if;
      end if;
    end process readport;
end portAB0;
