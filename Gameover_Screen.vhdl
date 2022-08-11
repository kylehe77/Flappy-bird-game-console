LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity gameover_screen is
	port(
		SIGNAL clk						      : IN std_logic;
		SIGNAL pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		SIGNAL score_hundreds, score_tens, score_ones 	: IN std_logic_vector(5 downto 0);
		SIGNAL over_text_on				 	: OUT std_logic_vector(11 downto 0)	
		);
end gameover_screen;

architecture behaviour of gameover_screen is

COMPONENT char_rom is
	PORT (
		character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock				: 	IN STD_LOGIC ;
		rom_mux_output		:	OUT STD_LOGIC
	);
end COMPONENT char_rom;

SIGNAL text_out : STD_LOGIC := '0';
SIGNAL score_out  : STD_LOGIC := '0';
SIGNAL menu_out  : STD_LOGIC := '0';

SIGNAL text_val : std_logic_vector(5 downto 0);
SIGNAL score_text : std_logic_vector(5 downto 0);
SIGNAL menu_text : std_logic_vector(5 downto 0);
begin

-- determines when and where to display the text
over_text_on <= "111111111111" when (text_out = '1' and pixel_column <= CONV_STD_LOGIC_VECTOR(480,10) and pixel_column >= CONV_STD_LOGIC_VECTOR(192,10) 
					and pixel_row <= CONV_STD_LOGIC_VECTOR(222,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(192,10)) or
				(score_out = '1' and pixel_column <= CONV_STD_LOGIC_VECTOR(416,10) and pixel_column >= CONV_STD_LOGIC_VECTOR(256,10) 
					and pixel_row <= CONV_STD_LOGIC_VECTOR(254,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(240,10)) or
				(menu_out = '1' and pixel_column <= CONV_STD_LOGIC_VECTOR(480,10) and pixel_column >= CONV_STD_LOGIC_VECTOR(208,10) 
					and pixel_row <= CONV_STD_LOGIC_VECTOR(414,10) and pixel_row >= CONV_STD_LOGIC_VECTOR(400,10)) else	
				"000000000000";

-- prints "GAME OVER" 32x32 size character
text_val <= CONV_STD_LOGIC_VECTOR(7,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(224,10) else 		--"G"
				CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(256,10) else 		--"A
				CONV_STD_LOGIC_VECTOR(13,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(288,10) else 	--"M"
				CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(320,10) else 		--"E"
				CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(352,10) else 	--" "
				CONV_STD_LOGIC_VECTOR(15,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(384,10) else 	--"O"
				CONV_STD_LOGIC_VECTOR(22,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(416,10) else 	--"V"
				CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(448,10) else 		--"E"
				CONV_STD_LOGIC_VECTOR(18,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(480,10) else 	--"R"
				"100000";																										--" "

-- prints "SCORE:s" where s is the score value 16x16 size character
score_text <= CONV_STD_LOGIC_VECTOR(19,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(272,10) else	--"S"
				CONV_STD_LOGIC_VECTOR(3,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(288,10) else		--"C"
				CONV_STD_LOGIC_VECTOR(15,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(304,10) else		--"O"
				CONV_STD_LOGIC_VECTOR(18,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(320,10) else		--"R"
				CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(336,10) else		--"E"
				CONV_STD_LOGIC_VECTOR(45,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(352,10) else		--"-"
				CONV_STD_LOGIC_VECTOR(45,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(368,10) else		--"-"
				score_hundreds when pixel_column <= CONV_STD_LOGIC_VECTOR(384,10) else
				score_tens when pixel_column <= CONV_STD_LOGIC_VECTOR(400,10) else
				score_ones when pixel_column <= CONV_STD_LOGIC_VECTOR(416,10) else
				"100000";																										--" "
				
--prints "MAIN MENU - bt0" 16x16 size character
menu_text <= CONV_STD_LOGIC_VECTOR(13,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(224,10) else	--"M"
				CONV_STD_LOGIC_VECTOR(1,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(240,10) else		--"A"
				CONV_STD_LOGIC_VECTOR(9,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(256,10) else		--"I"
				CONV_STD_LOGIC_VECTOR(14,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(272,10) else		--"N"
				CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(288,10) else		--"_"
				CONV_STD_LOGIC_VECTOR(13,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(304,10) else		--"M"
				CONV_STD_LOGIC_VECTOR(5,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(320,10) else		--"E"
				CONV_STD_LOGIC_VECTOR(14,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(336,10) else		--"N"
				CONV_STD_LOGIC_VECTOR(21,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(352,10) else		--"U"
				CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(368,10) else		--"-"
				CONV_STD_LOGIC_VECTOR(45,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(384,10) else		--"-"
				CONV_STD_LOGIC_VECTOR(45,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(400,10) else		--"-"
				CONV_STD_LOGIC_VECTOR(32,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(416,10) else		--"_"
				CONV_STD_LOGIC_VECTOR(2,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(432,10) else		--"B"
				CONV_STD_LOGIC_VECTOR(20,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(448,10) else		--"T"
				CONV_STD_LOGIC_VECTOR(48,6) when pixel_column <= CONV_STD_LOGIC_VECTOR(464,10) else		--"0"
				"100000";																										--" "

gameovertext: char_rom port map (text_val, pixel_row(4 downto 2), pixel_column(4 downto 2), clk, text_out);		--32x32
scoretext: char_rom port map (score_text, pixel_row(3 downto 1), pixel_column(3 downto 1), clk, score_out);		--16x16
mainmenutext: char_rom port map (menu_text, pixel_row(3 downto 1), pixel_column(3 downto 1), clk, menu_out);	--16x16	

end architecture behaviour;