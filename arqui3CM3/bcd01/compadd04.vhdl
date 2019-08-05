library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity compadd04 is

port( 
	clkca: in std_logic ;
	codopca: in std_logic_vector ( 3 downto 0 );
	inBuf12ca: in std_logic_vector ( 11 downto 0 );
	inFlagUCca: in std_logic ;
	outFlagca: out std_logic ;
	outBuf12ca: out std_logic_vector ( 11 downto 0 ) );

end;

architecture compadd0 of compadd04 is
signal snibb00, snibb01, snibb02: std_logic_vector(3 downto 0);
begin
  compadd: process(clkca, inBuf12ca, inFlagUCca)
   variable aux: bit:='0';
   begin
     if (clkca'event and clkca = '1') then
        if (codopca = "0011") then
           if (inFlagUCca = '1') then
               outFlagca <= '0';
               if (inBuf12ca(3 downto 0) > "0100") then
                   snibb00 <= inBuf12ca(3 downto 0) + 3;
               else
                   snibb00 <= inBuf12ca(3 downto 0);
               end if;
               if (inBuf12ca(7 downto 4) > "0100") then
                  snibb01 <= inBuf12ca(7 downto 4) + 3;
               else
                  snibb01 <= inBuf12ca(7 downto 4);
               end if;
               if (inBuf12ca(11 downto 8) > "0100") then
                  snibb02 <= inBuf12ca(11 downto 8) + 3;
               else
                  snibb02 <= inBuf12ca(11 downto 8);
               end if;
           elsif (aux = '0') then
                  aux := '1';
                  outBuf12ca <= snibb02 & snibb01 & snibb00;
                  outFlagca <= '1';
           elsif (aux = '1') then
                  outFlagca <= '0';
           end if;
        else
          outBuf12ca <= (others => 'Z');
          outFlagca <= 'Z';
          aux := '0';
        end if;
     end if;
   end process compadd;
end compadd0;
