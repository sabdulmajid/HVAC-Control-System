library ieee;
use ieee.std_logic_1164.all;

entity mux2To1 is port(
	input_A	: in std_logic_vector(3 downto 0);
	input_B	: in std_logic_vector(3 downto 0);
	select_input 	: in std_logic;
	output	: out std_logic_vector(3 downto 0)
);
end mux2To1;

architecture mux2To1_logic of mux2To1 is
begin
	with select_input select
	output <= 	input_A when '0',
					input_B when '1';

end mux2To1_logic;



