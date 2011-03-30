LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_sermax IS
END test_sermax;
 
ARCHITECTURE behavior OF test_sermax IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sermax
    PORT(
         CLK : IN  std_logic;
         EN : IN  std_logic;
         A : IN  unsigned(5 downto 0);
         MAX_VAL : OUT  unsigned(5 downto 0);
         MAX_IDX : OUT  unsigned(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal EN : std_logic := '0';
   signal A : unsigned(5 downto 0) := (others => '0');

 	--Outputs
   signal MAX_VAL : unsigned(5 downto 0);
   signal MAX_IDX : unsigned(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sermax PORT MAP (
          CLK => CLK,
          EN => EN,
          A => A,
          MAX_VAL => MAX_VAL,
          MAX_IDX => MAX_IDX
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
		EN <= '1';
		A <= TO_UNSIGNED(15, A'length); -- idx 0
		wait for CLK_period;
		A <= TO_UNSIGNED(2, A'length); -- idx 1
		wait for CLK_period;
		A <= TO_UNSIGNED(3, A'length); -- idx 2
		wait for CLK_period;
		A <= TO_UNSIGNED(3, A'length); -- idx 3
		wait for CLK_period;
		A <= TO_UNSIGNED(15, A'length); -- idx 4
		wait for CLK_period;
		A <= TO_UNSIGNED(2, A'length); -- idx 5
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 6
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 7
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 8
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 9
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 10
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 11
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 12
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 13
		wait for CLK_period;
		A <= TO_UNSIGNED(5, A'length); -- idx 14
		wait for CLK_period;
		A <= TO_UNSIGNED(31, A'length); -- idx 15
		wait for CLK_period;
		EN <= '0';
		wait for CLK_period;
      wait;
   end process;

END;
