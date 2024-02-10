library ieee;

use ieee.std_logic_1164.all;

 

entity holding_register is

  port (

    clk           : in  std_logic;
    reset         : in  std_logic;
    register_clr  : in  std_logic;
    din           : in  std_logic;
    dout          : out std_logic;
	 ledout			: out std_logic
  );

end holding_register;


architecture circuit of holding_register is

	component DFlipFlop port (
	 clk	      	: in std_logic;
    input      	: in std_logic;
    reset       	: in std_logic;
    output      	: out std_logic
	);
	end component;

  signal sreg 		: std_logic := '0';

begin

  -- Holding register logic
	inst0: DFlipFlop port map (clk, (din or sreg) and (not register_clr), reset, sreg);
 
	-- Output the holding register value
	dout <= sreg;
	ledout <= sreg;

 

end architecture;