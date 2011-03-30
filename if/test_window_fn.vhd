LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;


ENTITY test_window_fn IS
END test_window_fn;
 
ARCHITECTURE behavior OF test_window_fn IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	constant OUT_WIDTH : integer := 22;
 
    COMPONENT window_fn
    generic(
			IN_WIDTH: 	positive:=14;
			OUT_WIDTH:	positive:=16;
			WINDOW_WIDTH:	positive:=11; -- 2048
			WINDOW_DEPTH:	positive:=8
	);
    PORT(
         DATA_I : IN  std_logic_vector(13 downto 0);
         DATA_Q : IN  std_logic_vector(13 downto 0);
         CLK_FB : IN  std_logic;
         RST : IN  std_logic;
         EN : IN  std_logic;
         DATA_RDY : OUT  std_logic;
         OUT_I : OUT  std_logic_vector(OUT_WIDTH-1 downto 0);
         OUT_Q : OUT  std_logic_vector(OUT_WIDTH-1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DATA_I : std_logic_vector(13 downto 0) := (others => '0');
   signal DATA_Q : std_logic_vector(13 downto 0) := (others => '0');
   signal CLK_FB : std_logic := '0';
   signal RST : std_logic := '0';
   signal EN : std_logic := '0';

 	--Outputs
   signal DATA_RDY : std_logic;
   signal OUT_I : std_logic_vector(OUT_WIDTH-1 downto 0);
   signal OUT_Q : std_logic_vector(OUT_WIDTH-1 downto 0);

   -- Clock period definitions
   constant CLK_FB_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: window_fn
	generic map(
			IN_WIDTH => 14,
			OUT_WIDTH => OUT_WIDTH
	)
	PORT MAP (
          DATA_I => DATA_I,
          DATA_Q => DATA_Q,
          CLK_FB => CLK_FB,
          RST => RST,
          EN => EN,
          DATA_RDY => DATA_RDY,
          OUT_I => OUT_I,
          OUT_Q => OUT_Q
        );

   -- Clock process definitions
   CLK_FB_process :process
   begin
		CLK_FB <= '0';
		wait for CLK_FB_period/2;
		CLK_FB <= '1';
		wait for CLK_FB_period/2;
   end process;
 
 
 	process(CLK_FB)
	begin
		if rising_edge(CLK_FB) and RST='1' and EN='1' then
			DATA_I <= ( 0 => '1', others => '0');
			DATA_Q <= ( 0 => '1', others => '0');
		end if;
	end process;

	f_output : process(CLK_FB)
		file data_file_i : TEXT open write_mode is "window_fn_out.txt";
		variable data_line_i : line;
		variable s: ieee.numeric_std.signed(OUT_WIDTH-1 downto 0);
		variable i: integer;
	begin
		if rising_edge(CLK_FB) and RST='1' and EN='1' then
			s(OUT_WIDTH-1 downto 0) := ieee.numeric_std.signed(OUT_I);
			i := TO_INTEGER(s);
			write(data_line_i, i);
			writeline(data_file_i, data_line_i);
		end if;
	end process;

   -- Stimulus process
   stim_proc: process
   begin
		RST <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		RST <= '1';
      wait for CLK_FB_period*10;
		EN <= '1';
		wait for CLK_FB_period*2050;
		EN <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
