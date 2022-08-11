LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;

entity game_fsm is
port (
		clk, reset, PB1, PB2, SW_pause : in std_logic; 
		game_over : in std_logic;
		game_reset, game_pause : out std_logic;
		selected_mode : out std_logic_vector(1 downto 0)
		);
		
end entity;

architecture behaviour of game_fsm is
type state_type is (s_menu, s_regular, s_training, s_over);
signal state, next_state : state_type := s_menu;

begin
	sync_proc : process(clk, reset) --synchronously move to next state
	begin
		if (reset = '1') then
			state <= s_menu;
		elsif (rising_edge(clk)) then
			state <= next_state;
		end if;
	end process;

	next_states_fn: process(state, PB1, PB2, SW_pause, game_over, reset) --asynchronously decide next state based only on current state and inputs
	begin
		case(state) is
			when s_menu =>
				if (PB1 = '0') then
					next_state <= s_training;
				elsif (PB2 = '0') then
					next_state <= s_regular;
				else 
					next_state <= s_menu;
				end if;
				
			when s_training =>
				if (game_over = '1') then 
					next_state <= s_over;
				elsif (reset = '1') then
					next_state <= s_menu;	
				else
					next_state <= s_training;
				end if;
				
			when s_regular =>
				if (game_over = '1') then 
					next_state <= s_over;
				elsif (reset = '1') then
					next_state <= s_menu;
				else
					next_state <= s_regular;
				end if;
				
			when s_over =>
				if (reset = '1') then
					next_state <= s_menu;
				else 
					next_state <= s_over;
				end if;
				
		end case;
		game_pause <= SW_pause;
	end process;
	
	Output_decode : process(state)
		begin
			case (state) is
				when s_menu =>
					game_reset <= '1';
					selected_mode <= "00";
				when s_training =>
					game_reset <= '0';
					selected_mode <= "01";
				when s_regular =>
					game_reset <= '0';
					selected_mode <= "10";
				when s_over =>
					game_reset <= '0';
					selected_mode <= "11";
			end case;
		end process;
end architecture behaviour;