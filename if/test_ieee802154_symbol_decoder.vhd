LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_ieee802154_symbol_decoder IS
END test_ieee802154_symbol_decoder;
 
ARCHITECTURE behavior OF test_ieee802154_symbol_decoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ieee802154_symbol_decoder
    PORT(
         DRDY_IN : IN  std_logic;
         CHIP : IN  std_logic;
         CLK_FB : IN  std_logic;
         CLK_CHIP : IN  std_logic;
         RST : IN  std_logic;
			SRST : IN std_logic;
         SYMBOL : OUT  std_logic_vector(3 downto 0);
			SYMBOL_CORR : OUT STD_LOGIC_VECTOR(5 downto 0);
         DRDY_OUT : OUT  std_logic
        );
    END COMPONENT;
   
	COMPONENT ieee802154_controller
	PORT(
		DRDY_IN : IN std_logic;
		SYM : IN std_logic_vector(3 downto 0);
		CORR : IN std_logic_vector(5 downto 0);
		CLK_FB : IN std_logic;
		CLK_SYM : IN std_logic;
		RST : IN std_logic;          
		OCTET : OUT std_logic_vector(7 downto 0);
		DATA_RDY : out STD_LOGIC;
		SRST_SYMDEC : OUT std_logic
		);
	END COMPONENT;


   --Inputs
   signal DRDY_IN : std_logic := '0';
   signal CHIP : std_logic := '0';
   signal CLK_FB : std_logic := '0';
   signal CLK_CHIP : std_logic := '0';
   signal RST : std_logic := '0';
	signal SRST : std_logic := '0';

 	--Outputs
   signal SYMBOL : std_logic_vector(3 downto 0);
	signal SYMBOL_CORR : STD_LOGIC_VECTOR(5 downto 0);
   signal DEBUG1 : std_logic_vector(7 downto 0);
   signal DRDY_OUT : std_logic;
	signal OCTET : std_logic_vector(7 downto 0);
	signal OCTET_RDY : std_logic;

   -- Clock period definitions
   constant CLK_FB_period : time := 15.625 ns; -- 64 MHz
   constant CLK_CHIP_period : time := 500 ns; -- 2 MHz

	-- chipping sequences after OQPSK --> MSK transformation
	signal CSEQ_0 : STD_LOGIC_VECTOR(0 to 31) := "01100000011101111010111001101100";
	signal CSEQ_1 : STD_LOGIC_VECTOR(0 to 31) := "01001110000001110111101011100110";
	signal CSEQ_2 : STD_LOGIC_VECTOR(0 to 31) := "01101100111000000111011110101110";
	signal CSEQ_3 : STD_LOGIC_VECTOR(0 to 31) := "01100110110011100000011101111010";
	signal CSEQ_4 : STD_LOGIC_VECTOR(0 to 31) := "00101110011011001110000001110111";
	signal CSEQ_5 : STD_LOGIC_VECTOR(0 to 31) := "01111010111001101100111000000111";
	signal CSEQ_6 : STD_LOGIC_VECTOR(0 to 31) := "01110111101011100110110011100000";
	signal CSEQ_7 : STD_LOGIC_VECTOR(0 to 31) := "00000111011110101110011011001110";
	signal CSEQ_8 : STD_LOGIC_VECTOR(0 to 31) := "00011111100010000101000110010011";
	signal CSEQ_9 : STD_LOGIC_VECTOR(0 to 31) := "00110001111110001000010100011001";
	signal CSEQ_10: STD_LOGIC_VECTOR(0 to 31) := "00010011000111111000100001010001";
	signal CSEQ_11: STD_LOGIC_VECTOR(0 to 31) := "00011001001100011111100010000101";
	signal CSEQ_12: STD_LOGIC_VECTOR(0 to 31) := "01010001100100110001111110001000";
	signal CSEQ_13: STD_LOGIC_VECTOR(0 to 31) := "00000101000110010011000111111000";
	signal CSEQ_14: STD_LOGIC_VECTOR(0 to 31) := "00001000010100011001001100011111";
	signal CSEQ_15: STD_LOGIC_VECTOR(0 to 31) := "01111000100001010001100100110001";
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ieee802154_symbol_decoder PORT MAP (
          DRDY_IN => DRDY_IN,
          CHIP => CHIP,
          CLK_FB => CLK_FB,
          CLK_CHIP => CLK_CHIP,
          RST => RST,
			 SRST => SRST, -- set to '0' for uut0 testing only
          SYMBOL => SYMBOL,
			 SYMBOL_CORR => SYMBOL_CORR,
          DRDY_OUT => DRDY_OUT
        );



	uut_2: ieee802154_controller PORT MAP(
		DRDY_IN => DRDY_OUT,
		SYM => SYMBOL,
		CORR => SYMBOL_CORR,
		CLK_FB => CLK_FB,
		CLK_SYM => DRDY_OUT,
		RST => RST,
		OCTET => OCTET,
		DATA_RDY => OCTET_RDY,
		SRST_SYMDEC => SRST
	);



   -- Clock process definitions
   CLK_FB_process :process
   begin
		CLK_FB <= '0';
		wait for CLK_FB_period/2;
		CLK_FB <= '1';
		wait for CLK_FB_period/2;
   end process;
 
   CLK_CHIP_process :process
   begin
		CLK_CHIP <= '0';
		wait for CLK_CHIP_period/2;
		CLK_CHIP <= '1';
		wait for CLK_CHIP_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '0';
      wait for 100 ns;

		RST <= '1';
      wait for CLK_FB_period*10;
      -- insert stimulus here
		DRDY_IN <= '1';

		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_1(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_2(i);
			wait for CLK_CHIP_period;
		end loop;

		-- FRLEN
		for i in 0 to 31 loop
			CHIP <= CSEQ_3(i);
			wait for CLK_CHIP_period;
		end loop;

		-- FRLEN H
		for i in 0 to 31 loop
			CHIP <= CSEQ_4(i);
			wait for CLK_CHIP_period;
		end loop;

		-- AA
		for i in 0 to 31 loop
			CHIP <= CSEQ_5(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_6(i);
			wait for CLK_CHIP_period;
		end loop;

		-- FF
		for i in 0 to 31 loop
			CHIP <= CSEQ_7(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_8(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_9(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_10(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_11(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_12(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_13(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_14(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_15(i);
			wait for CLK_CHIP_period;
		end loop;



		-- PREAMBLE
		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;
		
		-- SFD 0xA7
		for i in 0 to 31 loop
			CHIP <= CSEQ_7(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_10(i);
			wait for CLK_CHIP_period;
		end loop;

		-- LEN = 2
		for i in 0 to 31 loop
			CHIP <= CSEQ_2(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_0(i);
			wait for CLK_CHIP_period;
		end loop;

		for i in 0 to 31 loop
			CHIP <= CSEQ_10(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_10(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_15(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_15(i);
			wait for CLK_CHIP_period;
		end loop;
		
		for i in 0 to 31 loop
			CHIP <= CSEQ_7(i);
			wait for CLK_CHIP_period;
		end loop;
		for i in 0 to 31 loop
			CHIP <= CSEQ_7(i);
			wait for CLK_CHIP_period;
		end loop;

      wait;
   end process;

END;
