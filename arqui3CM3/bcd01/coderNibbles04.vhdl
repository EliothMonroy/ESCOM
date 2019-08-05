library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity coderNibbles04 is

port( 
	AC12bit03: in std_logic_vector ( 11 downto 0 );
	outU: out std_logic_vector ( 6 downto 0 );
	outD: out std_logic_vector ( 6 downto 0 );
	outC: out std_logic_vector ( 6 downto 0 ) );

end;

architecture coderNibbles0 of coderNibbles04 is
signal nibbU, nibbD, nibbC: std_logic_vector(3 downto 0);
begin
  pbuffNibb: process(AC12bit03)
    begin
       nibbU <= AC12bit03(3 downto 0);
       nibbD <= AC12bit03(7 downto 4);
       nibbC <= AC12bit03(11 downto 8);
    end process pbuffNibb;

  pcoderU: process(nibbU)
    begin
       case nibbU is
          when "0000" => 
             outU <= "0000001";
          when "0001" => 
             outU <= "1001111";
          when "0010" => 
             outU <= "0010010";
          when "0011" => 
             outU <= "0000110";
          when "0100" => 
             outU <= "1001100";
          when "0101" => 
             outU <= "0100100";
          when "0110" => 
             outU <= "0100000";
          when "0111" => 
             outU <= "0001111";
          when "1000" => 
             outU <= "0000000";
          when "1001" => 
             outU <= "0000100";
          when others => outU <= "1111111";
       end case;
    end process pcoderU;

  pcoderD: process(nibbD)
    begin
       case nibbD is
          when "0000" => 
             outD <= "0000001";
          when "0001" => 
             outD <= "1001111";
          when "0010" => 
             outD <= "0010010";
          when "0011" => 
             outD <= "0000110";
          when "0100" => 
             outD <= "1001100";
          when "0101" => 
             outD <= "0100100";
          when "0110" => 
             outD <= "0100000";
          when "0111" => 
             outD <= "0001111";
          when "1000" => 
             outD <= "0000000";
          when "1001" => 
             outD <= "0000100";
          when others => outD <= "1111111";
       end case;
    end process pcoderD;

  pcoderC: process(nibbC)
    begin
       case nibbC is
          when "0000" => 
             outC <= "0000001";
          when "0001" => 
             outC <= "1001111";
          when "0010" => 
             outC <= "0010010";
          when "0011" => 
             outC <= "0000110";
          when "0100" => 
             outC <= "1001100";
          when "0101" => 
             outC <= "0100100";
          when "0110" => 
             outC <= "0100000";
          when "0111" => 
             outC <= "0001111";
          when "1000" => 
             outC <= "0000000";
          when "1001" => 
             outC <= "0000100";
          when others => outC <= "1111111";
       end case;
    end process pcoderC;
end coderNibbles0;
