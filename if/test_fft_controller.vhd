LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.ALL;

use std.textio.all;
 
ENTITY test_fft_controller IS
END test_fft_controller;



ARCHITECTURE behavior OF test_fft_controller IS 
	constant WIDTH : integer := 22;
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fft_controller
	 GENERIC (
		WIDTH: 	positive:=22
	 );
    PORT(
         DATA_I : IN  std_logic_vector(WIDTH-1 downto 0);
         DATA_Q : IN  std_logic_vector(WIDTH-1 downto 0);
         CLK_FB : IN  std_logic;
         RST : IN  std_logic;
			EN	 : in  STD_LOGIC;
         DATA_RDY : OUT  std_logic;
         OUT_I : OUT  std_logic_vector(WIDTH-1 downto 0);
         OUT_Q : OUT  std_logic_vector(WIDTH-1 downto 0);
			XN_IDX		: out std_logic_vector (10 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DATA_I : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
   signal DATA_Q : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
   signal CLK_FB : std_logic := '0';
   signal RST : std_logic := '0';
	signal EN  : std_logic := '0';

 	--Outputs
   signal DATA_RDY : std_logic;
   signal OUT_I : std_logic_vector(WIDTH-1 downto 0);
   signal OUT_Q : std_logic_vector(WIDTH-1 downto 0);
	signal XN_IDX		: std_logic_vector (10 downto 0);

   -- Clock period definitions
   constant CLK_FB_period : time := 10 ns; -- 105 MHz
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fft_controller
	generic map(
			WIDTH => WIDTH
	)
	PORT MAP (
          DATA_I => DATA_I,
          DATA_Q => DATA_Q,
          CLK_FB => CLK_FB,
          RST => RST,
			 EN => EN,
          DATA_RDY => DATA_RDY,
          OUT_I => OUT_I,
          OUT_Q => OUT_Q,
			 XN_IDX => XN_IDX
        );

   -- Clock process definitions
   CLK_FB_process :process
   begin
		CLK_FB <= '0';
		wait for CLK_FB_period/2;
		CLK_FB <= '1';
		wait for CLK_FB_period/2;
   end process;
 
 
 
	f_input : process(CLK_FB)
		file data_file : TEXT is IN "data_i.txt";
		variable data_line : line;
		variable s: integer;
	begin
		if rising_edge(CLK_FB) and RST='1' and NOT  Endfile(data_file) then
			readline(data_file, data_line);
			read(data_line, s);
			DATA_I <= CONV_STD_LOGIC_VECTOR(s, DATA_I'length);
		end if;
	end process;
	
	
	f_output : process(CLK_FB)
		file data_file_i : TEXT open write_mode is "fft_i.txt";
		file data_file_q : TEXT open write_mode is "fft_q.txt";
		variable data_line_i : line;
		variable data_line_q : line;
		variable s: ieee.numeric_std.signed(15 downto 0);
		variable i: integer;
		variable q: integer;
	begin
		if rising_edge(CLK_FB) and RST='1' and DATA_RDY='1' then
			s(15 downto 0) := ieee.numeric_std.signed(OUT_I);
			i := TO_INTEGER(s);
			write(data_line_i, i);
			writeline(data_file_i, data_line_i);

			s(15 downto 0) := ieee.numeric_std.signed(OUT_Q);
			q := TO_INTEGER(s);
			write(data_line_q, q);
			writeline(data_file_q, data_line_q);
		end if;
	end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		RST <= '0';
      wait for CLK_FB_period*10;
		RST <= '1';

		wait for CLK_FB_period*2;
		EN <= '1';

      wait;
   end process;

END;
