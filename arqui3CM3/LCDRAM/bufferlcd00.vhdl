library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity bufferlcd00 is
  port( inFlagbuffconfig: in std_logic;
	inFlagbuffwrite: in std_logic;
	RWcb: in std_logic;
	RScb: in std_logic;
	ENcb: in std_logic;
	RWwb: in std_logic;
	RSwb: in std_logic;
	ENwb: in std_logic;
	inwordconfig: in std_logic_vector(7 downto 0);
	inwordwrite: in std_logic_vector(7 downto 0);
	RWbb: out std_logic;
	RSbb: out std_logic;
	ENbb: out std_logic;
        outwordbuff: out std_logic_vector(7 downto 0));
end bufferlcd00;

architecture bufferlcd0 of bufferlcd00 is
begin
pbuff: process(ENcb, ENwb, inFlagbuffconfig, inFlagbuffwrite)
  begin
    if (inFlagbuffconfig = '0') then
	outwordbuff <= inwordconfig;
	RWbb <= RWcb;
	RSbb <= RScb;
	ENbb <= ENcb;
    elsif (inFlagbuffwrite = '1') then
        outwordbuff <= inwordwrite;
  	RWbb <= RWwb;
 	RSbb <= RSwb;
	ENbb <= ENwb;
    end if;
  end process pbuff;
end bufferlcd0;

