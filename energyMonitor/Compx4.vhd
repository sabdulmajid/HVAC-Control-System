library ieee;
use ieee.std_logic_1164.all;

entity Compx4 is port (
	input_A	: in std_logic_vector(3 downto 0); --Inputs for the two 4-bit numbers, for input_A
	input_B	: in std_logic_vector(3 downto 0); --Inputs for the two 4-bit numbers, for input_B
	AGTB		: out std_logic; -- A greater than B
	AEQB		: out std_logic; -- A equals to B
	ALTB		: out std_logic -- A less than B
);
end Compx4;




architecture logic_Compx4 of Compx4 is

component Compx1 port ( -- Declaration of 1 bit comparator 
	input_A		: in std_logic;
	input_B		: in std_logic;
	A_Greater	: out std_logic;
	B_Greater	: out std_logic;	
	A_Equals_B	: out std_logic
);
end component Compx1;

-- Declaring all the signals needed for the program, coming from four 1-bit comparators

-- Signals from first 1-bit magnitude comparator (A greater than B = GT, A less than B = LT, and A equal to B = EQ)
signal A0GTB0	: std_logic;
signal A0LTB0	: std_logic;
signal A0EQB0	: std_logic;

-- Signals from second 1-bit magnitude comparator (A greater than B = GT, A less than B = LT, and A equal to B = EQ)
signal A1GTB1	: std_logic;
signal A1LTB1	: std_logic;
signal A1EQB1	: std_logic;

-- Signals from third 1-bit magnitude comparator (A greater than B = GT, A less than B = LT, and A equal to B = EQ)
signal A2GTB2	: std_logic;
signal A2LTB2	: std_logic;
signal A2EQB2	: std_logic;

-- Signals from fourth 1-bit magnitude comparator (A greater than B = GT, A less than B = LT, and A equal to B = EQ)
signal A3GTB3	: std_logic;
signal A3LTB3	: std_logic;
signal A3EQB3	: std_logic;

begin -- Here the circuit begins
	
	
	-- Instantiating each of the 1-bit magnitude comparators
	inst1: Compx1 port map(input_A(0), input_B(0), A0GTB0, A0LTB0, A0EQB0);
	inst2: Compx1 port map(input_A(1), input_B(1), A1GTB1, A1LTB1, A1EQB1);
	inst3: Compx1 port map(input_A(2), input_B(2), A2GTB2, A2LTB2, A2EQB2);
	inst4: Compx1 port map(input_A(3), input_B(3), A3GTB3, A3LTB3, A3EQB3);
	
	-- Assigning the definition of AEQB (A equals to B)
	AEQB <= (A0EQB0) AND (A1EQB1) AND (A2EQB2) AND (A3EQB3);
	
	-- Assigning the definition of A_Greater (A greater than B)
	AGTB <= (input_A(3) AND (NOT input_B(3))) OR 
	(A3EQB3 AND input_A(2) AND (NOT input_B(2))) OR 
	(A3EQB3 AND A2EQB2 AND input_A(1) AND (NOT input_B(1))) OR
	(A3EQB3 AND A2EQB2 AND A1EQB1 AND input_A(0) AND (NOT input_B(0)));
	
	-- Assigning the definition of B_Greater (A less than B)
	ALTB <= (input_B(3) AND (NOT input_A(3))) OR 
	(A3EQB3 AND input_B(2) AND (NOT input_A(2))) OR 
	(A3EQB3 AND A2EQB2 AND input_B(1) AND (NOT input_A(1))) OR
	(A3EQB3 AND A2EQB2 AND A1EQB1 AND input_B(0) AND (NOT input_A(0)));
	
	
	
end logic_Compx4;