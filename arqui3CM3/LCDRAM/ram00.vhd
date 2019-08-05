library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ram00 is
  port(clkm       : in    std_logic;
       resetm     : in    std_logic;
       wrm        : in    std_logic;

       inFlagw : in  std_logic;-- VIENE DEL MÓDULO "config00"
       inFlagwx: in  std_logic;--viene del módulo "contw00"
       outFlagw: out std_logic;-- VA HACIA EL MÓDULO "bufferlcd00" Y HACIA "contw00" Y HACIA EL EXTERIOR


       inFlagm    : in    std_logic;
       indirReadm : in    std_logic_vector(3 downto 0);
       indirWritem: in    std_logic_vector(3 downto 0);
       inWordm    : in    std_logic_vector(7 downto 0);
       outWordm   : out   std_logic_vector(7 downto 0);
       outFlagm   : inout std_logic);                --VA HACIA EL EXTERIOR Y HACIA EL TOPKEY

end ram00;

architecture ram0 of ram00 is

  type arrayram is array(0 to 15) of std_logic_vector(7 downto 0);
  signal sram: arrayram:=(others => (others => '0'));

begin
  pram: process(clkm, resetm, wrm, inFlagm, inFlagw, indirReadm, indirWritem)
  variable aux: bit:='0';
  begin
   if(clkm'event and clkm = '1') then
     case resetm is
       when '0' =>
          outWordm <= "01000001";
          outFlagm <= '1';
          outFlagw <= '1';
       when '1' =>
          case wrm is
             when '0' =>
	        if ((aux = '0') or (inFlagm = '1')) then
                  aux:='1';
	          sram(conv_integer(indirWritem)) <= inWordm;
	          outFlagm <= '1';
	        else
	          outFlagm <= '0';
	        end if;
	     when '1' =>
		case inFlagw is			          
			when '1' =>
			      if(indirReadm <= indirWritem) then
		                if (inFlagwx = '1') then
                                  outFlagw <= '0';
			       else
                                outFlagw <= '1';
		                outWordm <= sram(conv_integer(indirReadm));
				
			       end if;
			      end if;
                         when others => null;
                 end case;
	     when others => null;
	  end case;
      when others => null;
    end case;
   end if;
  end process pram;
end ram0;

