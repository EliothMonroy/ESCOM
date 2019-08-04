library ieee;
use ieee.std_logic_1164.all;
entity ff is port(
	v: in std_logic_vector(1 downto 0);
	D, clk, pre, clr: in std_logic; -- D es la entrada y clk señal de relog
	Q,Qn: 		inout std_logic); -- Q es la salida y Qn su complemento
	attribute loc: string;
	attribute loc of v: signal is "p4";
end ff;
architecture a_ff is
begin
	process(clk,pre,clr)--entradas asincronas
	begin
		if(clr='0') then
			Q<='0';
			Qn<='1';
		elsif (clk'event and clk='1') then
			if (pre='1') then
				Q<='1';
				Qn<='0';
			else
				process(v)--Hacemos un proceso con la variable de control
				begin
					if(v='00') then -- el primer ff
					--codigo del primer ff
					elsif(v='01') then -- el segundo ff
					--codigo del segundo ff
					elsif(v='10') then -- el tercer ff
					--codigo del tercer ff
					else--entonces es el cuarto ff (11)
						--codigo del cuarto ff
					end if;
				end process;
			end if;
		end if;
	end process;
end a_ff;