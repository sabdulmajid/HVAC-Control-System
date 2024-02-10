library ieee;

use ieee.std_logic_1164.all;

 

entity synchronizer is

    port (

        clk   : in std_logic;
        reset : in std_logic;
        din   : in std_logic;
        dout  : out std_logic
    );

end synchronizer;


architecture circuit of synchronizer is

	component DFlipFlop port (
		clk	      	: in std_logic;
		input      		: in std_logic;
		reset       	: in std_logic;
		output      	: out std_logic
	);
	end component;

    signal sreg 	: std_logic_vector(1 downto 0) := "00";

begin
	
	 inst0: DFlipFlop port map (clk, din, reset, sreg(0));
	 inst1: DFlipFlop port map (clk, sreg(0), reset, sreg(1));
	 
	 dout <= sreg(1);

end circuit;