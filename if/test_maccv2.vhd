LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY test_maccv2 IS
END test_maccv2;
 
ARCHITECTURE behavior OF test_maccv2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MACCv2
    PORT(
         CLK : IN  std_logic;
         A : IN  std_logic_vector(17 downto 0);
         B : IN  std_logic_vector(17 downto 0);
         EN : IN  std_logic;
         Oper_Load : IN  std_logic;
         Oper_AddSub : IN  std_logic;
         RES : OUT  std_logic_vector(47 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal A : std_logic_vector(17 downto 0) := (others => '0');
   signal B : std_logic_vector(17 downto 0) := (others => '0');
   signal EN : std_logic := '0';
   signal Oper_Load : std_logic := '0';
   signal Oper_AddSub : std_logic := '0';

 	--Outputs
   signal RES : std_logic_vector(47 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MACCv2 PORT MAP (
          CLK => CLK,
          A => A,
          B => B,
          EN => EN,
          Oper_Load => Oper_Load,
          Oper_AddSub => Oper_AddSub,
          RES => RES
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
