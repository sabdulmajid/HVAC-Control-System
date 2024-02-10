LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LogicalStep_Lab4_top IS
   PORT
	(
   clkin_50		: in	std_logic;							-- The 50 MHz FPGA Clockinput
	rst_n			: in	std_logic;							-- The RESET input (ACTIVE LOW)
	pb_n			: in	std_logic_vector(3 downto 0); -- The push-button inputs (ACTIVE LOW)
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds			: out std_logic_vector(7 downto 0);	-- for displaying the the lab4 project details
	-------------------------------------------------------------
	-- you can add temporary output ports here if you need to debug your design 
	-- or to add internal signals for your simulations
	-------------------------------------------------------------
	
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic;
	
	aNorthSouth, dNorthSouth, gNorthSouth	: out std_logic;
	aEastWest, dEastWest, gEastWest			: out std_logic;
	
	sm				: out std_logic;
	blk			: out std_logic
	
	);
END LogicalStep_Lab4_top;

ARCHITECTURE SimpleCircuit OF LogicalStep_Lab4_top IS

   component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);	--bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DIN1 		: in  std_logic_vector(6 downto 0); --bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
   );
   end component;

   component clock_generator port (
			sim_mode			: in boolean;
			reset				: in std_logic;
         clkin      		: in  std_logic;
			sm_clken			: out	std_logic;
			blink		  		: out std_logic
  );
   end component;

   component pb_inverters port (
			 pb_n					: in std_logic_vector(3 downto 0);
			 pb			  		: out std_logic_vector(3 downto 0)
  );
   end component;
	

	
	component synchronizer port(
			clk					: in std_logic;
			reset					: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
   end component;
 
  component holding_register port (
			clk					: in std_logic;
			reset					: in std_logic;
			register_clr		: in std_logic;
			din					: in std_logic;
			dout					: out std_logic;
			ledout 				: out std_logic
  );
  end component;
  
  component TLCStateMachine port (
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
  end component;
				

----------------------------------------------------------------------------------------------------
	CONSTANT	sim_mode							: boolean := TRUE; -- set to FALSE for LogicalStep board downloads
																			-- set to TRUE for SIMULATIONS
	SIGNAL sm_clken, blink_sig				: std_logic;

	SIGNAL pb									: std_logic_vector(3 downto 0); -- pb(3) is used as an active-high reset for all registers
	SIGNAL syncOut1, syncOut2				: std_logic;

	signal muxNorthSouth, muxEastWest	: std_logic_vector(6 downto 0);
	signal reqNorthSouth, reqEastWest	: std_logic;

	signal registerClrNS, registerClrEW	: std_logic;
	
	
BEGIN

----------------------------------------------------------------------------------------------------
INST1: pb_inverters		port map (pb_n, pb);
INST2: clock_generator 	port map (sim_mode, pb(3), clkin_50, sm_clken, blink_sig);

sm <= sm_clken;
blk <= blink_sig;

INST3: synchronizer	 	port map (clkin_50, pb(3), pb(1), syncOut1);
INST4: synchronizer		port map (clkin_50, pb(3), pb(0), syncOut2);
INST5: holding_register port map (clkin_50, pb(3), registerClrEW, syncOut1, reqEastWest, leds(3));
INST6: holding_register port map (clkin_50, pb(3), registerClrNS, syncOut2, reqNorthSouth, leds(1));
INST7: TLCStateMachine 	port map (clkin_50, sm_clken, pb(3), blink_sig, reqNorthSouth, reqEastWest, muxNorthSouth, muxEastWest, leds(0), leds(2), registerClrNS, registerClrEW, leds(7 downto 4));
aNorthSouth <= muxNorthSouth(0);
dNorthSouth <= muxNorthSouth(3);
gNorthSouth <= muxNorthSouth(6);

aEastWest <= muxEastWest(0);
dEastWest <= muxEastWest(3);
gEastWest <= muxEastWest(6);



INST8: segment7_mux		port map (clkin_50, muxNorthSouth, muxEastWest, seg7_data, seg7_char2, seg7_char1);


END SimpleCircuit;
