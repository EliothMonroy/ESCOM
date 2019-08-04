													
													library IEEE;
													use  IEEE.std_logic_1164.all;
													use  IEEE.std_logic_unsigned.all;
													
													entity Top is
														port (
															CLK : in STD_LOGIC;
															RESET : in STD_LOGIC;
															Output : out STD_LOGIC_VECTOR (9 downto 0)
														); 
													end Top;
													
													architecture Structure of Top is
													
														component Counter is
															port (
																CLK : in STD_LOGIC;
																RESET : in STD_LOGIC;
																Q : out STD_LOGIC_VECTOR (3 downto 0)
															);
														end component;
													
														component Decoder is
															port (
																DataIn : in STD_LOGIC_VECTOR (3 downto 0);
																Output : out STD_LOGIC_VECTOR (9 downto 0)
															);
														end component;
													
														signal Internal : STD_LOGIC_VECTOR (3 downto 0);
													
													begin
														
														CNT : Counter
														port map (CLK,RESET,Internal);
													
														DEC : Decoder
														port map (Internal, Output);
													
													end structure;													