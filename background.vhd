library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

library altera_mf;
use altera_mf.all;

entity background is
	port(
		clk : in std_logic;
		pixel_row, pixel_column : in std_logic_vector(9 downto 0);
		rom_mux_output : out std_logic_vector(11 downto 0)
	);
end entity background;

architecture behaviour of background is 

component background_rom 
	PORT (
			clock : in std_logic;
			address : in std_logic_vector(14 downto 0);
			q : out std_logic_vector (11 downto 0)
	);
END COMPONENT;

signal rom_data : std_logic_vector(11 downto 0);				--Data out is 12-bit, 4-bits each for red, green and blue
signal rom_address : std_logic_vector(14 downto 0);			--15-bit is used because the depth of the background .MIF image is 19200 which is less than 2^15

begin 
	background_game : background_rom
		port map (clock => clk, address => rom_address, q => rom_data);
		
		rom_address <= pixel_column(9 downto 2) + conv_std_logic_vector((conv_integer(pixel_row(9 downto 2)) * 160), 15);		--The length of the background image is 160 as the image is 160x120 
		rom_mux_output <= rom_data;								--9 downto 2 is used because after adding both the row*160 and column, the pixel location on the 640*480 corresponds to an address in the .MIF file
end architecture behaviour;
	