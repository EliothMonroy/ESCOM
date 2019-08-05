library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity coder00 is

  port(clkc    : in    std_logic;
       inFlago : in    std_logic;
       resetc  : in    std_logic;
       incontc : in    std_logic_vector(3 downto 0);
       outcontc: inout std_logic_vector(3 downto 0);
       inkeyc  : in    std_logic_vector(3 downto 0);
       out7segc: out   std_logic_vector(7 downto 0);
       outFlago: out   std_logic);
end coder00;

architecture coder0 of coder00 is
begin
  pcoder: process(incontc, inkeyc)
  variable aux01: bit:='0';
  variable aux02: bit:='0';
  variable aux03: bit:='0';
  variable aux04: bit:='0';
    begin
        if (clkc'event and clkc ='1') then
	  if (resetc = '0') then
	     outcontc <= "1111";
	     outFlago <= '0';
             out7segc <= "11111111"; 

	  else
	     case incontc is
	        when "1000" =>
		   case inkeyc is
		      when "0000" =>

		          aux01:='0';
		          outFlago <= '0';
		          outcontc <= outcontc;

		      when "0001" =>

                          if (( aux01 ='0') or (inFlago = '1')) then
			     aux01:='1';
			     out7segc <= "01000001";--A
		 	     outcontc <= outcontc + '1';
			     outFlago <= '1';
		      	  else
		      	     outFlago <= '0';
		      	  end if;

		      when "0010" =>

			  if (( aux01 ='0') or (inFlago = '1')) then
			     aux01:='1';
			     out7segc <= "01000010";--B
			     outcontc <= outcontc + '1';
			     outFlago <= '1';
			  else
			     outFlago <= '0';
			  end if;

		       when "0100" =>

		           if (( aux01='0') or (inFlago = '1')) then
		              aux01:='1';
			      out7segc <= "01001100";--L
			      outcontc <= outcontc + '1';
			      outFlago <= '1';
			   else
			      outFlago <= '0';
			   end if;

		       when "1000" =>

		           if (( aux01='0') or (inFlago = '1')) then
		              aux01:='1';
			      out7segc <= "01000101";--E
			      outcontc <= outcontc + '1';
			      outFlago <= '1';
			   else
			      outFlago <= '0';
			   end if;
		       when others => null;
	           end case;
                when "0100" =>
   	           case inkeyc is
	              when "0000" =>

			  aux02:='0';
			  outFlago <= '0';
			  outcontc <= outcontc;

		      when "0001" =>

                          if (( aux02='0') or (inFlago = '1')) then
			     aux02:='1';
			     out7segc <= "01010010";--R
			     outcontc <= outcontc + '1';
			     outFlago <= '1';
			  else
			     outFlago <= '0';
			  end if;

		       when "0010" =>

                           if (( aux02='0') or (inFlago = '1')) then
			      aux02:='1';
			      out7segc <= "01010100";--T
			      outcontc <= outcontc + '1';
			      outFlago <= '1';
			   else
			      outFlago <= '0';
			   end if;
                          
                       when "0100" =>
		           if (( aux02='0') or (inFlago = '1')) then
		              aux02:='1';
			      out7segc <= "01001111";--O
			      outcontc <= outcontc + '1';
			      outFlago <= '1';
			   else
			      outFlago <= '0';
			   end if;

                       when "1000" =>

		           if (( aux02='0') or (inFlago = '1')) then
			      aux02:='1';
			      out7segc <= "01001111";--O
			      outcontc <= outcontc + '1';
			      outFlago <= '1';
			   else
			      outFlago <= '0';
			   end if;

		       when others => null;

                   end case;
		when "0010" =>
		   case inkeyc is
		      when "0000" =>

		          aux03:='0';
                          outFlago <= '0';
			  outcontc <= outcontc;

		      when "0001" =>

                          if (( aux03='0') or (inFlago = '1')) then
                             aux03:='1';
			     out7segc <= "01001111";--O
			     outcontc <= outcontc + '1';
			     outFlago <= '1';
			  else
			     outFlago <= '0';
			  end if;

                      when "0010" =>

		          if (( aux03='0') or (inFlago = '1')) then
		             aux03:='1';
			     out7segc <= "01001111";--O
			     outcontc <= outcontc + '1';
			     outFlago <= '1';
			  else
			     outFlago <= '0';
			  end if;

                      when "0100" =>

		          if (( aux03='0') or (inFlago = '1')) then
		             aux03:='1';
			     out7segc <=  "01010011";--S
			     outcontc <= outcontc + '1';
			     outFlago <= '1';
			  else
			     outFlago <= '0';
			  end if;

                      when "1000" =>

		          if (( aux03='0') or (inFlago = '1')) then
		             aux03:='1';
			     out7segc <=  "01010011";--S
			     outcontc <= outcontc + '1';
			     outFlago <= '1';
			  else
			     outFlago <= '0';
			  end if;

		      when others => null;

                  end case;
               when "0001" =>

                  case inkeyc is

		     when "0000" =>

		         aux04:='0';
		         outFlago <= '0';
		         outcontc <= outcontc;

		     when "0001" =>

		         if (( aux04='0') or (inFlago = '1')) then
		            aux04:='1';
			    out7segc <= "01011000";--X
			    outcontc <= outcontc + '1';
			    outFlago <= '1';
			  else
			    outFlago <= '0';
			  end if;

		     when "0010" =>

		         if (( aux04='0') or (inFlago = '1')) then
		            aux04:='1';
			    out7segc <= "01011000";--X
			    outcontc <= outcontc + '1';
			    outFlago <= '1';
			 else
			    outFlago <= '0';
			 end if;

		     when "0100" =>

		         if (( aux04='0') or (inFlago = '1')) then
		            aux04:='1';
			    out7segc <= "01011001";--Y
			    outcontc <= outcontc + '1';
			    outFlago <= '1';
			 else
			    outFlago <= '0';
			end if;

		    when "1000" =>

		        if (( aux04='0') or (inFlago = '1')) then
		           aux04:='1';
		           out7segc <= "01011001";--Y
			   outcontc <= outcontc + '1';
			   outFlago <= '1';
			else
			   outFlago <= '0';
			end if;

		    when others => null;

		end case;
	     when others => null;
	   end case;
       end if;
    end if;
  end process pcoder;
end coder0;

