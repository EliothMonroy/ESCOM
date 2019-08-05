library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use packagelcdram00.all;

entity toplcdram00 is
  port(clk0         : inout std_logic;
       cdiv00       : in    std_logic_vector(3 downto 0);
       reset0       : in    std_logic;
       wr0          : in    std_logic;
       inFlagk0     : inout std_logic;
       outFlagk0    : inout std_logic;
       inkey0       : in    std_logic_vector(3 downto 0);
       outr0        : inout std_logic_vector(3 downto 0);

       outContWrite0: inout std_logic_vector(3 downto 0);
       outContRead0 : inout std_logic_vector(3 downto 0);

       oscdis0      : in    std_logic;
       oscout0      : out   std_logic;
       tmrrst0      : inout std_logic;
       inFlagcc0 : inout std_logic;--entra al módulo "contconfig00" y sale delmódulo "config00"
       outcc0    : inout std_logic_vector(5 downto 0);
       outFlagcc0: inout std_logic;--sale del módulo "contconfig00"
       outFlagw0 : inout std_logic;
       outword0  : out   std_logic_vector(7 downto 0);

       RW0       : out   std_logic;
       RS0       : out   std_logic;
       EN0       : inout std_logic);

attribute loc: string;
attribute loc of oscdis0       : signal is "p38";--No importa
attribute loc of tmrrst0       : signal is "p45";--No importa
attribute loc of oscout0       : signal is "p104";--No importa

attribute loc of cdiv00        : signal is "p100, p76, p101, p77";--switch cuatro
attribute loc of reset0        : signal is "p81";--switch dos primero
attribute loc of wr0           : signal is "p87";--switch uno primero
attribute loc of clk0          : signal is "p98";-- led rojo derecha
attribute loc of inkey0        : signal is "p53 ,p52, p51 ,p50";--teclado
attribute loc of outr0         : signal is "p43 ,p44, p48 ,p49";--filas teclado

attribute loc of inFlagk0      : signal is "p59";--QUE NO EXISTA 
attribute loc of outFlagk0     : signal is "p60";--QUE NO EXISTA 

attribute loc of inFlagcc0      : signal is "p58";--QUE NO EXISTA X
attribute loc of outFlagcc0     : signal is "p61";--QUE NO EXISTA 
attribute loc of outFlagw0      : signal is "p13";--QUE NO EXISTA

attribute loc of outword0       : signal is "p142, p141, p140, p42, p139, p138, p39, p33";--pantalla
attribute loc of RS0            : signal is "p134";--configuracion pantalla
attribute loc of RW0            : signal is "p32";--configuracion pantalla
attribute loc of EN0            : signal is "p135";--configuracion pantalla


attribute loc of outcc0        : signal is "p122, p95, p123, p96, p124, p97";--leds azules
attribute loc of outContWrite0 : signal is "p28, p130, p29, p131";--leds azules
attribute loc of outContRead0  : signal is "p4, p5, p6, p7";--leds verdes

end toplcdram00;

architecture toplcdram0 of toplcdram00 is
  signal sout7segk, soutWordm, soutWordc: std_logic_vector(7 downto 0);
  signal tmrout: std_logic;

  signal sRWc, sRSc, sENc, sRWw, sRSw, sENw: std_logic;
  signal soutFlagcw: std_logic;


  begin

  K00:osc00 port map(osc_dis => oscdis0,
                     tmr_rst => tmrrst0,
                     osc_out => oscout0,
                     tmr_out => tmrout);
  
  K01: div00 port map(indiv  => cdiv00,
		      clkdiv => tmrout,
		      outdiv => clk0);

  
  RA02: topkey00 port map(clkk     => clk0,
                          resetk   => reset0,
			  inkeyk   => inkey0,
			  inFlagk  => inFlagk0,
			  outcontk => outContWrite0,
			  out7segk => sout7segk,
			  outrk    => outr0,
                          outFlagk => outFlagk0);
  
  RA03: ram00 port map(clkm        => clk0,
                       resetm      => reset0,
		       wrm         => wr0,
                       outFlagw    => outFlagw0,
                       inFlagm     => outFlagk0,

                       inFlagw  => inFlagcc0,
                       inFlagwx => soutFlagcw,


		       indirReadm  => outContRead0,
		       indirWritem => outContWrite0,
		       inWordm     => sout7segk,
		       outWordm    => soutWordm,
		       outFlagm    => inFlagk0);
  

  RA05: contRead00 port map(clkcont     => clk0,
                            wrCont      => wr0,
                            inFlagcw    => inFlagcc0,
                            inFlagx     => outFlagw0,

			    inContKey   => outContWrite0,
                            outFlagcw => soutFlagcw,
                            RWcw      => sRWw,
			    RScw      => sRSw,
			    ENcw      => sENw,
                            outContRead => outContRead0);

 LCD02: contconfig00 port map(clkcc     => clk0,
                               resetcc   => reset0,
			       inFlagcc  => inFlagcc0,
			       outcc     => outcc0,
                               outFlagcc => outFlagcc0);
  
  LCD03: config00 port map(resetc   => reset0,
			   inFlagc  => outFlagcc0,
			   incontc  => outcc0,
			   outWordc => soutWordc,
			   RWc      => sRWc,
			   RSc      => sRSc,
			   ENc      => sENc,
                           outFlagc => inFlagcc0);
  
  LCD06: bufferlcd00 port map(inFlagbuffconfig => inFlagcc0,
                              inFlagbuffwrite  => outFlagw0,
                              RWcb => sRWc,
			      RScb => sRSc,
			      ENcb => sENc,
			      RWwb => sRWw,
			      RSwb => sRSw,
			      ENwb => sENw,
			      inwordconfig => soutWordc,
			      inwordwrite => soutWordm,
			      RWbb => RW0,
			      RSbb => RS0,
			      ENbb => EN0,
			      outwordbuff => outword0);


end toplcdram0;

