library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
--use lattice.components.all;
--library machx02;

entity osc00 is
	port(osc_int: out std_logic);
end osc00;
architecture osc0 of osc00 is
component OSCH
	GENERIC (NOM_FREQ:string:="2.08");
	port(STDBY: in std_logic;
		OSC: out std_logic);
end component;
attribute NOM_FREQ:string;
attribute NOM_FREQ of OSCInst0:label is "2.08";
begin
	OSCInst0:OSCH
	generic map (NOM_FREQ => "2.08")
	port map(STDBY=>'0',OSC=>osc_int);
end;