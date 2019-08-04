library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dado is
	port(
		CLK,CLR,CONTROL: in std_logic;
		display: inout std_logic_vector (6 downto 0));
	attribute loc: string;
	
	attribute loc of clk: signal is "p4";
	attribute loc of control: signal is "p6";
	attribute loc of clr: signal is "p5";

	attribute loc of display: signal is "p130,p131,p132,p133,p134,p135,p138";
end dado;

architecture a_dado of dado is
constant err: std_logic_vector (6 downto 0):="0000001";--0
constant DIG1: std_logic_vector (6 downto 0):="1001111";--1
constant DIG2: std_logic_vector (6 downto 0):="0010010";--2
constant DIG3: std_logic_vector (6 downto 0):="0000110";--3
constant DIG4: std_logic_vector (6 downto 0):="1001100";--4
constant DIG5: std_logic_vector (6 downto 0):="0100100";--5
constant DIG6: std_logic_vector (6 downto 0):="0100000";--6
begin
	process(CLK,CLR,CONTROL)
	begin
		if(CLR='0') then
			display<=dig1;
		elsif(CLK'EVENT and CLK='1') then
			case CONTROL is
				when '0' =>
					case display is
						when dig1=>display<=dig2;
						when dig2=>display<=dig3;
						when dig3=>display<=dig4;
						when dig4=>display<=dig5;
						when dig5=>display<=dig6;
						when dig6=>display<=dig1;
						when others => display <=err;
					end case;
				when others =>
					display<=display;
			end case;
		end if;
	end process;
end a_dado;

