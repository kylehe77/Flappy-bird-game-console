library ieee;
use ieee.std_logic_1164.all;

library altera_mf;
use altera_mf.all;

entity Flappybird_rom is
	port
	(
		pixel_x,pixel_y : in std_logic_vector (4 downto 0);
		clock		: in std_logic  := '1';
		q		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
end Flappybird_rom;


architecture syn of Flappybird_rom is

	signal sub_wire0	: std_logic_vector (11 downto 0);
	signal combined_address: std_logic_vector (9 downto 0);

	component altsyncram
	generic (
		address_aclr_a				: string;
		clock_enable_input_a		: string;
		clock_enable_output_a	: string;
		init_file					: string;
		intended_device_family	: string;
		lpm_hint						: string;
		lpm_type						: string;
		numwords_a					: natural;
		operation_mode				: string;
		outdata_aclr_a				: string;
		outdata_reg_a				: string;
		widthad_a					: natural;
		width_a						: natural;
		width_byteena_a			: natural
	);
	port (
			address_a				: in std_logic_vector (9 downto 0);
			clock0					: in std_logic ;
			q_a						: out std_logic_vector (11 downto 0)
	);
	end component;

begin
	q    <= sub_wire0(11 downto 0);

	altsyncram_component : altsyncram
	generic map (
		address_aclr_a => "none",
		clock_enable_input_a => "bypass",
		clock_enable_output_a => "bypass",
		init_file => "flappybird.mif",
		intended_device_family => "cyclone iii",
		lpm_hint => "enable_runtime_mod=no",
		lpm_type => "altsyncram",
		numwords_a => 1024,
		operation_mode => "rom",
		outdata_aclr_a => "none",
		outdata_reg_a => "clock0",
		widthad_a => 10,
		width_a => 12,
		width_byteena_a => 1
	)
	port map (
		address_a => combined_address,
		clock0 => clock,
		q_a => sub_wire0
	);

	combined_address <= pixel_y & pixel_x;


end syn;