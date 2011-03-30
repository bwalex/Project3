LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_chip_decoder IS
END test_chip_decoder;
 
ARCHITECTURE behavior OF test_chip_decoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal PHI : signed(7 downto 0) := (others => '0');
   signal DRDY_IN : std_logic := '0';
   signal CLK_FB : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal CHIP : std_logic;
   signal DRDY : std_logic;

	signal CLK_CHIP: std_logic := '0';
   -- Clock period definitions
   constant CLK_FB_period : time := 71.42 ns;
	constant CLK_CHIP_period : time := 500 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ieee802154_chip_decoder PORT MAP (
          PHI => PHI,
          DRDY_IN => DRDY_IN,
          CHIP => CHIP,
          CLK_FB => CLK_FB,
          RST => RST,
          DRDY => DRDY
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
      wait for 100 ns;	

      wait for CLK_FB_period*10;

		PHI <= "00110000";
		DRDY_IN <= '1';
		RST <= '1';
		wait for CLK_CHIP_period*5;
		PHI <= (others => '0');
		wait for CLK_CHIP_period*6;
		PHI <= "10110000";
      wait;
   end process;

END;
