library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	--logic_in0		: in 	std_logic_vector(3 downto 0);
	--logic_in1		: in  std_logic_vector(3 downto 0);
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
	
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
		clk		: in std_logic := '0';
		DIN2		: in std_logic_vector(6 downto 0);
		DIN1		: in std_logic_vector(6 downto 0);
		DOUT		: out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
	); 
	end component;
	
	component PB_Inverters port (
		pb_n: in std_logic_vector(3 downto 0);
		pb: out std_logic_vector(3 downto 0) 
	);
	end component;
	
	component Logic_Processor port (
		mux_select	: in std_logic_vector(1 downto 0);
		logic_in0	: in std_logic_vector(3 downto 0);
		logic_in1	: in std_logic_vector(3 downto 0);
		logic_out	: out std_logic_vector(3 downto 0)
	);
	end component;
	
	component full_adder_4bit port (
		INPUT_A	: in std_logic_vector(3 downto 0);
		INPUT_B	: in std_logic_vector(3 downto 0);
		CARRY_IN : in std_logic;
		FULL_ADDER_SUM_OUTPUT	: out std_logic_vector(3 downto 0);
		FULL_ADDER_CARRY_OUTPUT : out std_logic

	);
	end component;
	
	component mux2To1 port (
		input_A			: in std_logic_vector(3 downto 0);
		input_B			: in std_logic_vector(3 downto 0);
		select_input 	: in std_logic;
		output			: out std_logic_vector(3 downto 0)
	);
	end component;
	
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B		: std_logic_vector(3 downto 0);
	
	signal pb			: std_logic_vector(3 downto 0);

	signal logic_out	: std_logic_vector(3 downto 0);
	
	signal hex_sum		: std_logic_vector(3 downto 0);
	signal hex_carry	: std_logic;
	
	signal hex_4bit_carry	: std_logic_vector(3 downto 0);
	signal muxOut1		:			std_logic_vector(3 downto 0);
	signal muxOut2		:			std_logic_vector(3 downto 0);
	
-- Here the circuit begins

begin
	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	--seg7_data <= seg7_A;

-- COMPONENT HOOKUP
--
-- generate the seven segment coding
	INST0: full_adder_4bit port map(hex_A, hex_B, '0', hex_sum, hex_carry);
	hex_4bit_carry <= "000" & hex_carry;
	INST1: mux2to1 port map(hex_B, hex_4bit_carry, pb(2), muxOut1);
	INST2: mux2to1 port map(hex_A, hex_sum, pb(2), muxOut2);
	
	INST3: SevenSegment port map(muxOut2, seg7_A);
	INST4: SevenSegment port map(muxOut1, seg7_B);
	
	INST5: segment7_mux port map(
		clkin_50,
		seg7_A(6 downto 0),
		seg7_B(6 downto 0),
		seg7_data(6 downto 0),
		seg7_char2,
		seg7_char1
	);
	INST6: PB_Inverters port map(
		pb_n(3 downto 0), 
		pb(3 downto 0)
	);

	INST7: Logic_Processor port map(pb(1 downto 0), hex_A, hex_B, leds(3 downto 0));
	
 
end SimpleCircuit;

