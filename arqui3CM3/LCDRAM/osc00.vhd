library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.components.all;

entity osc00 is

port(osc_dis: in std_logic ;
     tmr_rst: in std_logic ;
     osc_out: out std_logic ;
     tmr_out: out std_logic  );
end;

architecture osc0 of osc00 is
component OSCTIMER
generic(TIMER_DIV : string);

port(DYNOSCDIS: in  STD_ULOGIC; 
     TIMERRES : in  STD_ULOGIC;
     OSCOUT   : out  STD_ULOGIC;
     TIMEROUT : out  STD_ULOGIC); 
end component;

begin
inst11: OSCTIMER
generic map (TIMER_DIV => "1024")

	port map (DYNOSCDIS => osc_dis,
		  TIMERRES  => tmr_rst,
	          OSCOUT    => osc_out,
                  TIMEROUT  => tmr_out);
end osc0;

