-- Vhdl instantiation template created from schematic D:\Documents and Settings\Administrator\Desktop\Project3\if\Main.sch - Fri Oct 08 15:13:39 2010
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module.
-- 2) To use this template to instantiate this component, cut-and-paste and then edit.
--

   COMPONENT Main
   PORT( clkb	:	IN	STD_LOGIC; 
          as_dsl	:	IN	STD_LOGIC; 
          EMPTY	:	IN	STD_LOGIC; 
          BUSY	:	IN	STD_LOGIC; 
          renl_wenl	:	OUT	STD_LOGIC; 
          rdl_wr	:	OUT	STD_LOGIC; 
          green2	:	OUT	STD_LOGIC; 
          rxled	:	OUT	STD_LOGIC; 
          ADIO	:	INOUT	STD_LOGIC_VECTOR (31 DOWNTO 0));
   END COMPONENT;

   UUT: Main PORT MAP(
		clkb => , 
		as_dsl => , 
		EMPTY => , 
		BUSY => , 
		renl_wenl => , 
		rdl_wr => , 
		green2 => , 
		rxled => , 
		ADIO => 
   );
