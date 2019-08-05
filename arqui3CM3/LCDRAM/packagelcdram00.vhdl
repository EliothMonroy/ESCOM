library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

package packagelcdram00 is

  component toposc00
	port(
	   cdiv0: in std_logic_vector(3 downto 0);
       outdiv0: inout std_logic);
  end component;

  component div00
    port(clkdiv: in    std_logic;
		indiv : in    std_logic_vector(3 downto 0);
        outdiv: out   std_logic);
  end component;
  
  component topkey00
    port(clkk    : in    std_logic;
	 resetk  : in    std_logic;
	 inkeyk  : in    std_logic_vector(3 downto 0);
	 inFlagk : in    std_logic;
	 outcontk: inout std_logic_vector(3 downto 0);
	 out7segk: out   std_logic_vector(7 downto 0);
	 outrk   : inout std_logic_vector(3 downto 0);
     outFlagk: out   std_logic);
  end component;
  
  component ram00
    port(clkm       : in    std_logic;
		resetm     : in    std_logic;
		wrm        : in    std_logic;
		inFlagm    : in    std_logic;
		inFlagw : in  std_logic;
		inFlagwx: in  std_logic;
		outFlagw: out std_logic;
		indirReadm : in    std_logic_vector(3 downto 0);
		indirWritem: in    std_logic_vector(3 downto 0);
		inWordm : in    std_logic_vector(7 downto 0);
		outWordm : out   std_logic_vector(7 downto 0);
        outFlagm : inout std_logic);
  end component;
 
  component contRead00
    port(clkcont : in    std_logic;
		wrCont : in    std_logic;
		inFlagcw : in    std_logic;-- VIENE DEL MÓDULO "config00"
		inFlagx  : in    std_logic;-- viene del módulo "write00"
		RWcw     : out   std_logic;
		RScw     : out   std_logic;
		ENcw     : out   std_logic;
		outFlagcw: out   std_logic;
		inContKey  : in    std_logic_vector(3 downto 0);
        outContRead: inout std_logic_vector(3 downto 0));
  end component;

  component contconfig00
    port(clkcc    : in    std_logic;
		resetcc  : in    std_logic;
		inFlagcc : in    std_logic;
		outcc    : inout std_logic_vector(5 downto 0);
		outFlagcc: out   std_logic);
  end component;
  
  component config00
    port(resetc  : in  std_logic;
		inFlagc : in  std_logic;
		incontc : in  std_logic_vector(5 downto 0);
		outWordc: out std_logic_vector(7 downto 0);
		RWc     : out std_logic;
		RSc     : out std_logic;
		ENc     : out std_logic;
        outFlagc: out std_logic);
  end component;


  component bufferlcd00
	port(inFlagbuffconfig: in  std_logic;
       inFlagbuffwrite : in  std_logic;
       RWcb            : in  std_logic;
       RScb            : in  std_logic;
       ENcb            : in  std_logic;
       RWwb            : in  std_logic;
       RSwb            : in  std_logic;
       ENwb             : in  std_logic;
       inwordconfig    : in  std_logic_vector(7 downto 0);
       inwordwrite     : in  std_logic_vector(7 downto 0);
       RWbb            : out std_logic;
       RSbb            : out std_logic;
       ENbb            : out std_logic;
       outwordbuff     : out std_logic_vector(7 downto 0));
  end component;
end packageLCDRAM00;

