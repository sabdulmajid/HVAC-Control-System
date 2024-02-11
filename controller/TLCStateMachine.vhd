library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TLCStateMachine is port(
	clk						: in std_logic;
	sm_clken					: in std_logic;
	reset						: in std_logic;
	blink_sig				: in std_logic;
	reqNorthSouth			: in std_logic;
	reqEastWest				: in std_logic;
	
	displayOutNS			: out std_logic_vector(6 downto 0);
	displayOutEW			: out std_logic_vector(6 downto 0);
	
	crossNorthSouth		: out std_logic;
	crossEastWest			: out std_logic;
	
	registerClrNS			: out std_logic;
	registerClrEW			: out std_logic;
	currentStateOut		: out std_logic_vector(3 downto 0)
	
);
end Entity;

Architecture TLCStateMachine_logic of TLCStateMachine is

type state is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15);

signal currentState, nextState : state;

begin

Mealy_Machine: Process(clk)
Begin
	if (rising_edge(clk)) then
		if (reset = '1') then
			currentState <= s0;
		elsif (reset = '0' and sm_clken = '1') then
			currentState <= nextState;
		end if;
	end if;
end process;


Transitional_logic: process (currentState)

Begin
	case currentState is
	
		when s0 =>
			
			if (reqEastWest = '1' and reqNorthSouth = '0') then
				nextState <= s6;
			else 
				nextState <= s1;
			end if;
		when s1 =>
			if (reqEastWest = '1' and reqNorthSouth = '0') then
				nextState <= s7;
			else 
				nextState <= s2;
			end if;
		when s2 =>
			nextState <= s3;
		when s3 =>
			nextState <= s4;
		when s4 =>
			nextState <= s5;
		when s5 =>
			nextState <= s6;
		when s6 =>
			nextState <= s7;
		when s7 =>
			nextState <= s8;
		when s8 =>
			if (reqEastWest = '0' and reqNorthSouth = '1') then
				nextState <= s14;
			else
				nextState <= s9;
			end if;
		when s9 =>
			if (reqEastWest = '0' and reqNorthSouth = '1') then
				nextState <= s14;
			else
				nextState <= s10;
			end if;
		when s10 =>
			nextState <= s11;
		when s11 =>
			nextState <= s12;
		when s12 =>
			nextState <= s13;
		when s13 =>
			nextState <= s14;
		when s14 =>
			nextState <= s15;
		when s15 =>
			nextState <= s0;
		
		end case;
end process;

Mealy_decoder: PROCESS (currentState, blink_sig)

BEGIN

 CASE currentState IS
    
    WHEN s0 =>
        IF (blink_sig = '1') THEN
            displayOutNS <= "0001000";
        ELSE 
            displayOutNS <= "0000000"; 
        END IF;

        displayOutEW <= "0000001"; 
        crossNorthSouth <= '0';
        crossEastWest <= '0';
        currentStateOut <= "0000";
        registerClrEW <= '0'; 
        registerClrNS <= '0'; 
    WHEN s1 => 
    IF (blink_sig = '1') THEN 
        displayOutNS <= "0001000";
    ELSE
        displayOutNS <= "0000000";
    END IF;
    displayOutEW <= "0000001";
    crossNorthSouth <= '0';
    crossEastWest <= '0';
    currentStateOut <= "0001";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s2 =>
    displayOutNS <= "0001000";
    displayOutEW <= "0000001";
    crossNorthSouth <= '1';
    crossEastWest <= '0';
    currentStateOut <= "0010";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s3 =>
    displayOutNS <= "0001000";
    displayOutEW <= "0000001";
    crossNorthSouth <= '1';
    crossEastWest <= '0';
    currentStateOut <= "0011";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s4 =>
    displayOutNS <= "0001000";
    displayOutEW <= "0000001";
    crossNorthSouth <= '1';
    crossEastWest <= '0';
    currentStateOut <= "0100";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s5 =>
    displayOutNS <= "0001000";
    displayOutEW <= "0000001";
    crossNorthSouth <= '1';
    crossEastWest <= '0';
    currentStateOut <= "0101";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s6 =>
    displayOutNS <= "1000000";
    displayOutEW <= "0000001";
    crossNorthSouth <= '0';
    crossEastWest <= '0';
    currentStateOut <= "0110";
    registerClrEW <= '0';
    registerClrNS <= '1';

    WHEN s7 =>
    displayOutNS <= "1000000";
    displayOutEW <= "0000001";
    crossNorthSouth <= '0';
    crossEastWest <= '0';
    currentStateOut <= "0111";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s8 =>
    displayOutNS <= "0000001";

    IF (blink_sig = '1') THEN
        displayOutEW <= "0001000";
    ELSE
        displayOutEW <= "0000000";
    END IF;

    crossNorthSouth <= '0';
    crossEastWest <= '0';
    currentStateOut <= "1000";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s9 =>
    displayOutNS <= "0000001";
    IF (blink_sig = '1') THEN
        displayOutEW <= "0001000";
    ELSE
        displayOutEW <= "0000000";
    END IF;
    crossNorthSouth <= '0';
    crossEastWest <= '0';
    currentStateOut <= "1001";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s10 =>
    displayOutNS <= "0000001";
    displayOutEW <= "0001000";
    crossNorthSouth <= '0';
    crossEastWest <= '1';
    currentStateOut <= "1010";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s11 =>
    displayOutNS <= "0000001";
    displayOutEW <= "0001000";
    crossNorthSouth <= '0';
    crossEastWest <= '1';
    currentStateOut <= "1011";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s12 =>
    displayOutNS <= "0000001";
    displayOutEW <= "0001000";
    crossNorthSouth <= '0';
    crossEastWest <= '1';
    currentStateOut <= "1100";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s13 =>
    displayOutNS <= "0000001";
    displayOutEW <= "0001000";
    crossNorthSouth <= '0';
    crossEastWest <= '1';
    currentStateOut <= "1101";
    registerClrEW <= '0';
    registerClrNS <= '0';

    WHEN s14 =>
    displayOutNS <= "0000001";
    displayOutEW <= "1000000";
    crossNorthSouth <= '0';
    crossEastWest <= '0';
    currentStateOut <= "1110";
    registerClrEW <= '1';
    registerClrNS <= '0';

    WHEN s15 =>
    displayOutNS <= "0000001";
    displayOutEW <= "1000000";
    crossNorthSouth <= '0';
    crossEastWest <= '0';
    currentStateOut <= "1111";
    registerClrEW <= '0';
    registerClrNS <= '0';

    END CASE;
END PROCESS;

END ARCHITECTURE TLCStateMachine_logic;




			
				
			
			

			




















