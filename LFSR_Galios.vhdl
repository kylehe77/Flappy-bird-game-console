LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity LFSR_Galios is
	port(   
		Clk : in std_logic;
		output : out std_logic_vector(8 downto 0)
	);
end entity LFSR_Galios;

architecture behaviour of LFSR_Galios is 
  SIGNAL Currstate, Nextstate: std_logic_vector (7 DOWNTO 0) := "10101010";
  SIGNAL feedback: std_logic;
BEGIN

  StateReg: PROCESS (Clk)
  BEGIN
    IF (rising_edge(clk)) THEN
      Currstate <= Nextstate;
    END IF;
  END PROCESS;
  
  feedback <= Currstate(7) XOR Currstate(3) XOR Currstate(2) XOR Currstate(0);
  Nextstate <= feedback & Currstate(7 DOWNTO 1);
  output <= ('0' & Currstate) + CONV_STD_LOGIC_VECTOR(100, 9);		--increasing the range from 100-356 because range of 8 bit is 0-256 but the screen has 0-479 rows.  
  
end behaviour;