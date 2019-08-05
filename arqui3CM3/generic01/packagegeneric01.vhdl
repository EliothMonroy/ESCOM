library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
package packagegeneric01 is
	component toposcdiv00
		port(
			indiv0:in std_logic_vector (3 downto 0);
			outdiv0:inout std_logic
		);
	end component;
	component topfa8bits00
		port(
			SL: in std_logic;--Nos dice si queremos sumar o restar, 0 -> Suma, 1 -> Resta 
			Ai: in std_logic_vector(7 downto 0);
			Bi: in std_logic_vector(7 downto 0);
			So: inout std_logic_vector(15 downto 0);
			LED: out std_logic
		);
	end component;
	component andg00
		port (
			clka: in std_logic;
			codopga: in std_logic_vector(4 downto 0);
			portAga: in std_logic_vector(7 downto 0);
			portBga: in std_logic_vector(7 downto 0);
			outga: out std_logic_vector(15 downto 0);
			inFlaga: in std_logic;
			outFlaga: out std_logic
		);
	end component;
	component xorg00
		port (
			clkx: in std_logic;
			codopx: in std_logic_vector(4 downto 0);
			portAgx: in std_logic_vector(7 downto 0);
			portBgx: in std_logic_vector(7 downto 0);
			outgx: out std_logic_vector(15 downto 0);
			inFlagx: in std_logic;
			outFlagx: out std_logic
		);
	end component;
	component org00
		port (
			clko: in std_logic;
			codopgo: in std_logic_vector(4 downto 0);
			portAgo: in std_logic_vector(7 downto 0);
			portBgo: in std_logic_vector(7 downto 0);
			outgo: out std_logic_vector(15 downto 0);
			inFlago: in std_logic;
			outFlago: out std_logic
		);
	end component;
	component notg00
		port (
			clknot: in std_logic;
			codopgnot: in std_logic_vector(4 downto 0);
			portAgnot: in std_logic_vector(7 downto 0);
			outgnot: out std_logic_vector(15 downto 0);
			inFlagnot: in std_logic;
			outFlagnot: out std_logic
		);
	end component;
	component nandg00
		port (
			clknand: in std_logic;
			codopgnand: in std_logic_vector(4 downto 0);
			portAgnand: in std_logic_vector(7 downto 0);
			portBgnand: in std_logic_vector(7 downto 0);
			outgnand: out std_logic_vector(15 downto 0);
			inFlagnand: in std_logic;
			outFlagnand: out std_logic
		);
	end component;
	component norg00
		port (
			clknor: in std_logic;
			codopgnor: in std_logic_vector(4 downto 0);
			portAgnor: in std_logic_vector(7 downto 0);
			portBgnor: in std_logic_vector(7 downto 0);
			outgnor: out std_logic_vector(15 downto 0);
			inFlagnor: in std_logic;
			outFlagnor: out std_logic
		);
	end component;
	component xnorg00
		port (
			clkxnor: in std_logic;
			codopgxnor: in std_logic_vector(4 downto 0);
			portAgxnor: in std_logic_vector(7 downto 0);
			portBgxnor: in std_logic_vector(7 downto 0);
			outgxnor: out std_logic_vector(15 downto 0);
			inFlagxnor: in std_logic;
			outFlagxnor: out std_logic
		);
	end component;
	component addg00
		port (
			clkgadd: in std_logic;
			codopgadd: in std_logic_vector(4 downto 0);
			inadd: in std_logic_vector(15 downto 0);
			inLEDadd: in std_logic;
			outgadd: out std_logic_vector(15 downto 0);
			inFlagadd: in std_logic;
			outFlagadd: out std_logic;
			outoverflowadd:out std_logic;
			outSLadd: out std_logic
		);
	end component;
	component substg00
		port (
			clkgsub: in std_logic;
			codopgsub: in std_logic_vector(4 downto 0);
			insub: in std_logic_vector(15 downto 0);
			inLEDsub: in std_logic;
			outgsub: out std_logic_vector(15 downto 0);
			inFlagsub: in std_logic;
			outFlagsub: out std_logic;
			outoverflowsub: out std_logic;
			outSLsub: out std_logic
		);
	end component;
	component uc00
		port(
			clkuc: in std_logic;
			enableuc: in std_logic;
			overflowuc: in std_logic;
			inuc: in std_logic_vector(15 downto 0);
			inFlaguc: in std_logic;
			outuc: out std_logic_vector(15 downto 0);
			outoverfuc: out std_logic;
			outFlaguc: out std_logic
		);
	end component;
	component topmult8bit00
		port(
			Am4: in std_logic_vector(7 downto 0);
			Bm4: in std_logic_vector(7 downto 0);
			Rm4: out std_logic_vector(15 downto 0)
		);
	end component;
	component multg00
		port (
			clkmult: in std_logic;
			codopgmult: in std_logic_vector(4 downto 0);
			inmult: in std_logic_vector(15 downto 0);
			outgmult: out std_logic_vector(15 downto 0);
			inFlagmult: in std_logic;
			outFlagmult: out std_logic
		);
	end component;
end package ; -- packagegeneric00 