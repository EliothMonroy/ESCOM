library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity shift8bit04 is

port( 
	clks: in std_logic ;
	codops: in std_logic_vector ( 3 downto 0 );
	inACs: in std_logic_vector ( 7 downto 0 );
	inFlags: in std_logic ;
	outACs: out std_logic_vector ( 7 downto 0 );
	outFlags: out std_logic  );

end;

architecture shift8bit0 of shift8bit04 is
begin
  shiftp: process(clks, codops, inACs, inFlags)
  variable aux: bit := '0';
    begin
      if (clks'event and clks = '1') then
         if (codops = "0100") then
             if (inFlags = '1') then
                if (aux = '0') then
                    aux := '1';
                    outFlags <= '1';
                    outACs(0) <= '0';
                    outACs(7 downto 1) <= inACs(6 downto 0);
                else
                    outFlags <= '0';
                end if;
             elsif (inFlags = '0') then
                    outFlags <= '0';
             end if;
         else
             outACs <= (others => 'Z');
             outFlags <= 'Z';
             aux := '0';
         end if;
      end if;
    end process shiftp;
end shift8bit0;
