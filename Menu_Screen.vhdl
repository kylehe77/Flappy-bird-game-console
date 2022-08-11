LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity Menu_Screen is
	port(
		SIGNAL clk						    	: IN std_logic;
		SIGNAL pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		SIGNAL menu_text_on   		 		: OUT std_logic_vector(11 downto 0)	
		);
end Menu_Screen;

architecture behaviour of Menu_Screen is

COMPONENT char_rom is
	PORT (
		character_address		:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock						: 	IN STD_LOGIC ;
		rom_mux_output			:	OUT STD_LOGIC
	);
end COMPONENT char_rom;

SIGNAL text_out  : STD_LOGIC := '0';
SIGNAL info_out  : STD_LOGIC := '0';

SIGNAL text_val  : std_logic_vector(5 downto 0); 
SIGNAL info_text : std_logic_vector(5 downto 0);

begin

-- determines when and where to display the text
menu_text_on <= "111111111111" when (text_out = '1' and pixel_column <= CONV_STD_LOGIC_VECTOR(512,10) and pixel_column >= CONV_STD_LOGIC_VECTOR(160,10) 
					and pixel_row <= CONV_STD_LOGIC_VECTOR(222,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(192,10)) or
				(info_out = '1' and pixel_column <= CONV_STD_LOGIC_VECTOR(574,10) and pixel_column >= CONV_STD_LOGIC_VECTOR(64,10) 
					and pixel_row <= CONV_STD_LOGIC_VECTOR(382,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(368,10)) else
				"000000000000";
					  
-- prints "FLAPPY BIRD" 32x32 size character
text_val <= CONV_STD_LOGIC_VECTOR(6,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(192,10) else 	--"F"
				CONV_STD_LOGIC_VECTOR(12,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(224,10) else --"L"
				CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(256,10) else 	--"A"
				CONV_STD_LOGIC_VECTOR(16,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(288,10) else --"P"
				CONV_STD_LOGIC_VECTOR(16,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(320,10) else --"P"
				CONV_STD_LOGIC_VECTOR(25,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(352,10) else --"Y"
				CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(384,10) else --" "
				CONV_STD_LOGIC_VECTOR(2,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(416,10) else  --"B"
				CONV_STD_LOGIC_VECTOR(9,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(448,10) else 	--"I"
				CONV_STD_LOGIC_VECTOR(18,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(480,10) else --"R"
				CONV_STD_LOGIC_VECTOR(4,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(512,10) else 	--"D"
				"100000";																									--" "

--prints "PB1-TRAIN      PB2-REGULAR" 16x16 size character
info_text <= CONV_STD_LOGIC_VECTOR(2,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(80,10) else   --"B"
				 CONV_STD_LOGIC_VECTOR(20,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(96,10) else  --"T"
				 CONV_STD_LOGIC_VECTOR(49,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(112,10) else --"1"
				 CONV_STD_LOGIC_VECTOR(45,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(128,10) else --"-"
				 CONV_STD_LOGIC_VECTOR(20,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(144,10) else --"t"
				 CONV_STD_LOGIC_VECTOR(18,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(160,10) else --"r"
				 CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(176,10) else  --"a"
				 CONV_STD_LOGIC_VECTOR(9,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(192,10) else  --"i"
				 CONV_STD_LOGIC_VECTOR(14,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(208,10) else --"n"

				 CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(398,10) else --" "	
				 
				 CONV_STD_LOGIC_VECTOR(2,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(414,10) else  --"B"
				 CONV_STD_LOGIC_VECTOR(20,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(430,10) else --"T"
				 CONV_STD_LOGIC_VECTOR(50,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(446,10) else --"2"
				 CONV_STD_LOGIC_VECTOR(45,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(462,10) else --"-"
				 CONV_STD_LOGIC_VECTOR(18,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(478,10) else --"R"
				 CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(494,10) else  --"E"
				 CONV_STD_LOGIC_VECTOR(7,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(510,10) else  --"G"
				 CONV_STD_LOGIC_VECTOR(21,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(526,10) else --"U"
				 CONV_STD_LOGIC_VECTOR(12,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(542,10) else --"L"
				 CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(558,10) else  --"A"
			    CONV_STD_LOGIC_VECTOR(18,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(574,10) else --"R"
				 "100000";																									 --" "

text: char_rom port map (text_val, pixel_row(4 downto 2), pixel_column(4 downto 2), clk, text_out);	--32x32	
info: char_rom port map (info_text, pixel_row(3 downto 1), pixel_column(3 downto 1), clk, info_out);	--16x16

end architecture behaviour;