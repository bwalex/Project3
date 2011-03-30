LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
 
ENTITY test_ieee802154_angle IS
END test_ieee802154_angle;
 
ARCHITECTURE behavior OF test_ieee802154_angle IS 
 
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
    

   --Inputs
   signal I : SIGNED(7 downto 0) := (others => '0');
   signal Q : SIGNED(7 downto 0) := (others => '0');
   signal CLK_FB : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal PHI : std_logic_vector(7 downto 0);
   signal DRDY : std_logic;

   -- Clock period definitions
   constant CLK_FB_period : time := 10 ns;
 
 
	--
	signal CLK_IN : std_logic := '0';
	signal TEST : signed(7 downto 0) := (others => '0');
	signal DATA_I : signed(7 downto 0) := (others => '0');
	signal DATA_Q : signed(7 downto 0) := (others => '0');

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ieee802154_angle PORT MAP (
          I => DATA_I,
          Q => DATA_Q,
          PHI => PHI,
          DRDY => DRDY,
          CLK_FB => CLK_FB,
          RST => RST
        );

   -- Clock process definitions
   CLK_FB_process :process
   begin
		CLK_FB <= '0';
		wait for CLK_FB_period/2;
		CLK_FB <= '1';
		wait for CLK_FB_period/2;
   end process;

	-- Clock process for input data
	CLK_IN_process :process
	begin
		CLK_IN <= '1';
		wait for CLK_FB_period*2;
		CLK_IN <= '0';
		wait for CLK_FB_period*2;
	end process;
 
 
 
  	f_input : process(CLK_IN)
		file data_file_i : TEXT is IN "ieee802154_data_i.txt";
		file data_file_q : TEXT is IN "ieee802154_data_q.txt";
		variable data_line_i : line;
		variable data_line_q : line;
		variable s_i: integer;
		variable s_q: integer;
		variable s: ieee.numeric_std.signed(7 downto 0);
	begin
		if rising_edge(CLK_IN) and RST='1' and NOT Endfile(data_file_i) and NOT Endfile(data_file_q) then
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
		if rising_edge(CLK_IN) and RST='1' and DRDY='1' then
			s(7 downto 0) := ieee.numeric_std.signed(PHI);
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

      wait for CLK_FB_period*10;
		RST <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
