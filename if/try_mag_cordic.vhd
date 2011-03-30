LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY try_mag_cordic IS
END try_mag_cordic;
 
ARCHITECTURE behavior OF try_mag_cordic IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mag_cordic
    PORT(
         x_in : IN  std_logic_vector(15 downto 0);
         y_in : IN  std_logic_vector(15 downto 0);
         nd : IN  std_logic;
         x_out : OUT  std_logic_vector(15 downto 0);
         rdy : OUT  std_logic;
         clk : IN  std_logic;
         sclr : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x_in : std_logic_vector(15 downto 0) := (others => '0');
   signal y_in : std_logic_vector(15 downto 0) := (others => '0');
   signal nd : std_logic := '0';
   signal clk : std_logic := '0';
   signal sclr : std_logic := '0';
	signal rst : std_logic;

 	--Outputs
   signal x_out : std_logic_vector(15 downto 0);
   signal rdy : std_logic;



	type CORDIC_STATES is (RST_STATE, IDLE, ACTIVE, WAIT_DONE, DONE_DONE);
	signal CORDIC_STATE : CORDIC_STATES;


   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mag_cordic PORT MAP (
          x_in => x_in,
          y_in => y_in,
          nd => nd,
          x_out => x_out,
          rdy => rdy,
          clk => clk,
          sclr => sclr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	process(CLK, RST)
	begin
		if RST = '0' then
			CORDIC_STATE <= RST_STATE;
		elsif rising_edge(CLK) then
			case CORDIC_STATE is
				when RST_STATE =>
					ND <= '0';
					SCLR <= '1';
					CORDIC_STATE <= IDLE;
				when IDLE =>
					ND <= '0';
					SCLR <= '0';
					CORDIC_STATE <= ACTIVE;
				when ACTIVE =>
					ND <= '1';
					X_IN(15 downto 3) <= (others => '0');
					Y_IN(15 downto 3) <= (others => '0');
					X_IN(2 downto 0) <= "101";
					Y_IN(2 downto 0) <= "100";
					CORDIC_STATE <= WAIT_DONE;
				when WAIT_DONE =>
					ND <= '1';
					X_IN(15 downto 3) <= (others => '0');
					Y_IN(15 downto 3) <= (others => '0');
					X_IN(2 downto 0) <= "110";
					Y_IN(2 downto 0) <= "100";
					CORDIC_STATe <= DONE_DONE;
				when DONE_DONE =>
					ND <= '0';
				when others =>
					CORDIC_STATE <= RST_STATE;
			end case;
		end if;
	end process;

   -- Stimulus process
   stim_proc: process
   begin
		RST <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      wait for clk_period*10;
		RST <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
