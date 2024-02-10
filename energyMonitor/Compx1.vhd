library ieee;
use ieee.std_logic_1164.all;

entity Compx1 is port (
	input_A		: in std_logic;
	input_B		: in std_logic;
	A_Greater	: out std_logic;
	B_Greater	: out std_logic;	
	A_Equals_B	: out std_logic
	-- 3 output btis to store which case is true when comparing the two input bits
	-- if A > B -> A_Greater will be 1
	-- if A = b -> A_Equals_B will be 1
	-- if A < b -> B_Greater will be 1
															
);
end Compx1;

architecture logic_magnitude_cmp_1bit of Compx1 is

begin
	A_Equals_B <= input_A XNOR input_B; --The XNOR bit will be 1 will both are either 1 and 1 or 0 and 0 ensuring equality
	A_Greater <= input_A AND (NOT input_B); -- Now that we know that the bits are not equal we can just and either bit with 1 to find out which one is greater
	B_Greater <= input_B AND (NOT input_A);
	

end logic_magnitude_cmp_1bit;

