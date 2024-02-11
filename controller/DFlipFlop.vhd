library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DFlipFlop is port (

    clk	      	: in std_logic;
    input      	: in std_logic;
    reset       	: in std_logic;
    output      	: out std_logic

);
end DFlipFlop;

architecture logic of DFlipFlop is
    signal temp  : std_logic;

begin
    process(clk)

    begin
        if(reset = '1') then
            temp <= '0';

        else
			if (rising_edge(clk)) then
            temp <= input;
			end if;
        end if;
    end process;

    output <= temp;

end architecture logic;