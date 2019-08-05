library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use packagelcdram00.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

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
       inFlagcc0 : inout std_logic;
       outcc0    : inout std_logic_vector(5 downto 0);
       outFlagcc0: inout std_logic;
       outFlagw0 : inout std_logic;
       outword0  : out   std_logic_vector(7 downto 0);
       RW0       : out   std_logic;
       RS0       : out   std_logic;
       EN0       : inout std_logic);
end toplcdram00;

architecture toplcdram0 of toplcdram00 is
  signal sout7segk, soutWordm, soutWordc: std_logic_vector(7 downto 0);
  signal sRWc, sRSc, sENc, sRWw, sRSw, sENw: std_logic;
  signal soutFlagcw: std_logic;
  begin
  
					 
  K01: toposc00 port map(cdiv0  => cdiv00,
		      outdiv0 => clk0);

  
  RA02: topkey00 port map(clkk => clk0,
						resetk => reset0,
						inkeyk => inkey0,
						inFlagk => inFlagk0,
						outcontk => outContWrite0,
						out7segk => sout7segk,
						outrk => outr0,
                        outFlagk => outFlagk0);
  
  RA03: ram00 port map(clkm => clk0,
                       resetm => reset0,
					   wrm => wr0,
                       outFlagw => outFlagw0,
                       inFlagm => outFlagk0,
                       inFlagw => inFlagcc0,
                       inFlagwx => soutFlagcw,
					   indirReadm  => outContRead0,
					   indirWritem => outContWrite0,
					   inWordm     => sout7segk,
					   outWordm    => soutWordm,
					   outFlagm    => inFlagk0);  

  RA05: contRead00 port map(clkcont => clk0,
                            wrCont => wr0,
                            inFlagcw => inFlagcc0,
                            inFlagx => outFlagw0,
							inContKey => outContWrite0,
                            outFlagcw => soutFlagcw,
                            RWcw => sRWw,
							RScw => sRSw,
							ENcw => sENw,
							outContRead => outContRead0);

 LCD02: contconfig00 port map(clkcc => clk0,
                              resetcc => reset0,
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

