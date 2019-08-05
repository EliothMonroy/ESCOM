library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use packagep04.all;

entity topp04 is

  port( 
      clk0: inout std_logic ;
      cdiv0: in std_logic_vector(3 downto 0) ;
      reset0: in std_logic ;
      soutFlagpc: inout std_logic ;
      sFlagInst: inout std_logic ;
      sFlag8out: inout std_logic;
      sFlag12out: inout std_logic;
      sFlag12B: inout std_logic;
      soutFlagrom: inout std_logic;
      outpcport: inout std_logic_vector ( 3 downto 0 );
      outcodeport: inout std_logic_vector ( 3 downto 0 );
      inport8a0: inout std_logic_vector ( 7 downto 0 );
      outport120: inout std_logic_vector ( 11 downto 0 );
      outport8a0: inout std_logic_vector ( 7 downto 0 ); 
      outTransist0: inout std_logic_vector(3 downto 0);
      outDisplay: out std_logic_vector(6 downto 0));
   attribute loc: string;
   --attribute loc of clk0: signal is "p56";
   --attribute loc of cdiv0: signal is "p24";
   --attribute loc of reset0: signal is "p104";
   --attribute loc of soutFlagpc: signal is "p13";
   --attribute loc of sFlagInst: signal is "p14";
   --attribute loc of sFlag8out: signal is "p15";
   --attribute loc of sFlag12out: signal is "p16";
   --attribute loc of soutFlagrom: signal is "p21";
   --attribute loc of outpcport: signal is "p58, p59, p60, p61";
   --attribute loc of outcodeport: signal is "p62, p63, p70, p71";
   --attribute loc of inport8a0: signal is "p125, p124, p123, p122, p121, p120, p117, p110";
   --attribute loc of outport8a0: signal is "p4, p5, p6, p7, p8, p9, p11, p12";
   --attribute loc of outport120: signal is "p28, p29, p30, p31, p32, p33, p39, p40, p41, p42, p43, p143";
   --attribute loc of outDisplay: signal is "p130, p131, p132, p133, p134, p135, p138";
   --attribute loc of outTransist0: signal is "p139, p140, p141, p142";
end;

architecture topp0 of topp04 is
signal sAC8b: std_logic_vector(7 downto 0);
signal sout, sAC12a, sAC12b: std_logic_vector(11 downto 0);
signal sFlag12Inst, soutFlagIt: std_logic;
signal soutU, soutD, soutC: std_logic_vector(6 downto 0);
begin

  U01: init04 port map(clkinit => clk0,
                       codopinit => outcodeport,
                       inFlag8init => soutFlagrom,
                       --inFlagreset => soutFlagreset,
                       outACA8init => sAC8b,
                       outACA12init =>sAC12b,
                       outFlag12init => sFlag12Inst,
                       outFlag8init => sFlagInst);

  U02: portAB04 port map(clkLp => clk0,
                         codopLp => outcodeport,
                         portALp => inport8a0,
                         ACLpA => sAC8b,
                         inFlagLp => soutFlagrom,
                         outFlagLp => sFlagInst);

  U03: pcinc04 port map(clkpc => clk0,
                        resetpc => reset0,
                        --outFlagreset => soutFlagreset,
                        incode => outcodeport,
                        outpc => outpcport,
                        inFlagAC8bit => sFlag8out,
                        inFlagAC12bit => sFlag12out,
                        flagiter => soutFlagIt,
                        outFlagpc => soutFlagpc);

  U04: ac8bit04 port map(clkac8 => clk0,
                        inac8 => sAC8b,
                        outac8 => outport8a0,
                        inFlagac8Inst => sFlagInst,
                        outFlagac8 => sFlag8out);

   U05: leeInst04 port map(
                         inFlagInstrom => soutFlagpc,
                         outFlagrom => soutFlagrom,
                         inPCrom => outpcport,
                         outcode => outcodeport);

   U06: shift8bit04 port map(clks => clk0,
                             codops => outcodeport,
                             inACs => outport8a0,
                             inFlags => soutFlagrom,
                             outACs => sAC8b,
                             outFlags => sFlagInst);

   U07: ac12bit04 port map (clkac12 => clk0,
                            inac12 => sAC12b,
                            outac12 => sAC12a,
                            inFlagac12Inst => sFlag12Inst,
                            outFlagac12 => sFlag12out);

   U08: sust04 port map(clksu => clk0,
                        codopsu => outcodeport,
                        inAC8bitsu => outport8a0,
                        inAC12bitsu => sAC12a,
                        inFlagAC12su => soutFlagrom,
                        outAC12bitsu => sAC12b,
                        outsust => outport120,--sout, --outport120,
                	outFlagsuB => sFlag12B,
                        outFlagsu => sFlag12Inst);

   U09: compadd04 port map (clkca => clk0,
                           codopca => outcodeport,
                           inBuf12ca => sAC12a,
                           inFlagUCca => soutFlagrom,
                           outFlagca => sFlag12Inst,
                           outBuf12ca => sAC12b);

   U10: shift12bit04 port map(clkss => clk0,
                            codopss => outcodeport,
                            inACss => sAC12a,
                            inFlagss => soutFlagrom,
                            outACss => sAC12b,
                            outFlagss => sFlag12Inst);


   U11: contiter04 port map(clkit => clk0,
                           resetIt => reset0,
                           inFlagIt => sFlag12B,
                           outFlagIt => soutFlagIt);

   U12: coderNibbles04 port map(AC12bit03 => outport120,--sAC12a,
                                outU => soutU,
                                outD => soutD,
                                outC => soutC);

   U13: contring04 port map(clkr => clk0,
                            resetr => reset0,
                            outr => outTransist0);

   U14: toposcdiv00 port map(indiv0 => cdiv0,
                       outdiv0 => clk0);

   U15: mux04 port map(selmux => outTransist0,
                       intBCDU=> soutU,
                       intBCDD=> soutD,
                       intBCDC=> soutC,
                       outBCDmux => outDisplay);
end topp0;
