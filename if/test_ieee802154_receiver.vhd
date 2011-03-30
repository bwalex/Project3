
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

 
ENTITY test_ieee802154_receiver IS
END test_ieee802154_receiver;
 
ARCHITECTURE behavior OF test_ieee802154_receiver IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ieee802154_angle
    generic(
			IQ_WIDTH : integer := 8;
			DELAY: integer := 7;
			MULTIPLICAND_WIDTH : integer := 18;
			XY_WIDTH : integer := 36 -- XXX: must match the normal fp mult for simulation (36 vs hardware: 48)
	);
    PORT(
         I : IN  SIGNED(7 downto 0);
         Q : IN  SIGNED(7 downto 0);
         PHI : OUT  std_logic_vector(7 downto 0);
         DRDY : OUT  std_logic;
         CLK_FB : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;

    COMPONENT ieee802154_chip_decoder
    PORT(
         PHI : IN  SIGNED(7 downto 0);
         DRDY_IN : IN  std_logic;
         CHIP : OUT  std_logic;
         CLK_FB : IN  std_logic;
         RST : IN  std_logic;
         DRDY : OUT  std_logic
        );
    END COMPONENT;    


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
   signal I : SIGNED(7 downto 0) := (others => '0');
   signal Q : SIGNED(7 downto 0) := (others => '0');
   signal CLK_14 : std_logic := '0';
	signal CLK_56 : std_logic := '0';
	signal CLK_64 : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal PHI : std_logic_vector(7 downto 0);
   signal DRDY_PHI : std_logic;

	signal CHIP : std_logic;
	signal DRDY_CHIP : std_logic;

   -- Clock period definitions
   constant CLK_14_period : time := 71.4286 ns;
	constant CLK_56_period : time := 17.8571 ns;
	constant CLK_64_period : time := 15.625 ns;
 
 
 	signal SRST : std_logic := '0';

 	--Outputs
   signal SYMBOL : std_logic_vector(3 downto 0);
	signal SYMBOL_CORR : STD_LOGIC_VECTOR(5 downto 0);
	signal DRDY_SYM : std_logic;
	signal OCTET : std_logic_vector(7 downto 0);
	signal OCTET_RDY : std_logic;
 
	--
	signal CLK_IN : std_logic := '0';
	signal TEST : signed(7 downto 0) := (others => '0');
	signal DATA_I : signed(7 downto 0) := (others => '0');
	signal DATA_Q : signed(7 downto 0) := (others => '0');

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut_angle: ieee802154_angle PORT MAP (
          I => DATA_I,
          Q => DATA_Q,
          PHI => PHI,
          DRDY => DRDY_PHI,
          CLK_FB => CLK_56,
          RST => RST
        );

	uut_chip_decoder: ieee802154_chip_decoder PORT MAP(
		PHI => signed(PHI),
		DRDY_IN => DRDY_PHI,
		CHIP => CHIP,
		CLK_FB => CLK_14,
		RST => RST,
		DRDY => DRDY_CHIP
	);


   uut_symbol_decoder: ieee802154_symbol_decoder PORT MAP (
          DRDY_IN => DRDY_CHIP,
          CHIP => CHIP,
          CLK_FB => CLK_64,
          CLK_CHIP => DRDY_CHIP,
          RST => RST,
			 SRST => SRST, -- set to '0' for uut0 testing only
          SYMBOL => SYMBOL,
			 SYMBOL_CORR => SYMBOL_CORR,
          DRDY_OUT => DRDY_SYM
        );



	uut_controller: ieee802154_controller PORT MAP(
		DRDY_IN => DRDY_SYM,
		SYM => SYMBOL,
		CORR => SYMBOL_CORR,
		CLK_FB => CLK_64,
		CLK_SYM => DRDY_SYM,
		RST => RST,
		OCTET => OCTET,
		DATA_RDY => OCTET_RDY,
		SRST_SYMDEC => SRST
	);



   -- Clock process definitions
   CLK_64_process :process
   begin
		CLK_64 <= '0';
		wait for CLK_64_period/2;
		CLK_64 <= '1';
		wait for CLK_64_period/2;
   end process;

   -- Clock process definitions
   CLK_56_process :process
   begin
		CLK_56 <= '1';
		wait for CLK_56_period/2;
		CLK_56 <= '0';
		wait for CLK_56_period/2;
   end process;

	-- Clock process for input data
	CLK_14_process :process
	begin
		CLK_14 <= '0';
		wait for CLK_14_period/2;
		CLK_14 <= '1';
		wait for CLK_14_period/2;
	end process;
 
 
 
  	f_input : process(CLK_14)
		file data_file_i : TEXT is IN "ieee802154_data_i.txt";
		file data_file_q : TEXT is IN "ieee802154_data_q.txt";
		variable data_line_i : line;
		variable data_line_q : line;
		variable s_i: integer;
		variable s_q: integer;
		variable s: ieee.numeric_std.signed(7 downto 0);
	begin
		if rising_edge(CLK_14) and RST='1' and NOT Endfile(data_file_i) and NOT Endfile(data_file_q) then
			readline(data_file_i, data_line_i);
			read(data_line_i, s_i);
			--I <= TO_SIGNED(s_i, I'length);
			DATA_I <= signed(std_logic_vector( to_signed(  s_i, 8 )));

			readline(data_file_q, data_line_q);
			read(data_line_q, s_q);
			DATA_Q <= TO_SIGNED(s_q, 8);

			TEST <=  signed(std_logic_vector( to_signed(  s_i, 8 )));
		end if;
	end process;


	f_output : process(CLK_IN)
		file data_file_i : TEXT open write_mode is "ieee802154_angle.txt";
		variable data_line_i : line;
		variable s: ieee.numeric_std.signed(7 downto 0);
		variable i: integer;
	begin
		if rising_edge(CLK_IN) and RST='1' and DRDY_PHI='1' then
			s(7 downto 0) := ieee.numeric_std.signed(PHI);
			i := TO_INTEGER(s);
			write(data_line_i, i);
			writeline(data_file_i, data_line_i);
		end if;
	end process;


	f_output_octets : process(OCTET_RDY)
		file data_file_i : TEXT open write_mode is "ieee802154_octet.txt";
		variable data_line_i : line;
		variable s: ieee.numeric_std.signed(7 downto 0);
		variable i: integer;
	begin
		if rising_edge(OCTET_RDY) and RST='1' then
			s(7 downto 0) := ieee.numeric_std.signed(OCTET);
			i := TO_INTEGER(s);
			write(data_line_i, i);
			writeline(data_file_i, data_line_i);
		end if;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '0';
		I <= (others => '0');
		Q <= (others => '0');
      wait for 100 ns;	

      wait for CLK_14_period*10;
		RST <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
