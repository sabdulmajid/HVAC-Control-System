library ieee;
use ieee.std_logic_1164.all;

entity full_adder_4bit is
port (
	INPUT_A	: in std_logic_vector(3 downto 0);
	INPUT_B	: in std_logic_vector(3 downto 0);
	CARRY_IN : in std_logic;
	FULL_ADDER_SUM_OUTPUT	: out std_logic_vector(3 downto 0);
	FULL_ADDER_CARRY_OUTPUT : out std_logic

);
end full_adder_4bit;

architecture adder_logic_4bit of full_adder_4bit is

	component full_adder_1bit port (
		INPUT_A							: in std_logic;
		INPUT_B							: in std_logic;
		CARRY_IN							: in std_logic;
		FULL_ADDER_SUM_OUTPUT		: out std_logic;
		FULL_ADDER_CARRY_OUTPUT		: out std_logic

	);
	end component;


	signal tempCarry1, tempCarry2, tempCarry3	: std_logic;
	

begin

	INST1: full_adder_1bit port map(INPUT_A(0), INPUT_B(0), CARRY_IN, FULL_ADDER_SUM_OUTPUT(0), tempCarry1);
	INST2: full_adder_1bit port map(INPUT_A(1), INPUT_B(1), tempCarry1, FULL_ADDER_SUM_OUTPUT(1), tempCarry2);
	INST3: full_adder_1bit port map(INPUT_A(2), INPUT_B(2), tempCarry2, FULL_ADDER_SUM_OUTPUT(2), tempCarry3);
	INST4: full_adder_1bit port map(INPUT_A(3), INPUT_B(3), tempCarry3, FULL_ADDER_SUM_OUTPUT(3), FULL_ADDER_CARRY_OUTPUT);

end adder_logic_4bit;