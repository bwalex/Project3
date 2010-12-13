----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:32:40 12/13/2010 
-- Design Name: 
-- Module Name:    ieee802154_angle - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ieee802154_angle is
    Port (
		I : in  SIGNED(7 downto 0);
		Q : in  SIGNED (7 downto 0);
		PHI : out  STD_LOGIC_VECTOR (7 downto 0);
		LUT_A : out  STD_LOGIC_VECTOR (9 downto 0);
		LUT_D : in  STD_LOGIC_VECTOR (7 downto 0);
		DRDY : out std_logic;
		LUT_EN : out STD_LOGIC;
		CLK_FB	: in  STD_LOGIC;
		RST : in  STD_LOGIC
	);
end ieee802154_angle;

architecture Behavioral of ieee802154_angle is
type ANGLE_STATES is (RST_STATE, SAMPLE, PROD_1, PROD_2, OUTP );
signal STATE : ANGLE_STATES;
signal I_d1 : SIGNED (7 downto 0);
signal Q_d1 : SIGNED (7 downto 0);
signal Y : SIGNED (7 downto 0); -- XXX: might need to be 15 downto 0
signal X : SIGNED (7 downto 0); -- XXX: might need to be 15 downto 0
signal PHIi : std_logic_vector (7 downto 0);
signal LUT_Ai : std_logic_vector (9 downto 0);
signal LUT_ENi : std_logic;
signal DRDYi : std_logic;
begin
	-- 1) ( trim precision of I and Q down to 8 or so and normalize. )
	-- 2) calculate the 4 product terms and accumulate
	-- 3) trim precision of y and x down to 1QN (5 bit) each
	-- 4) find the atan2 by applying the y and x as address to LUT_A
	-- 5) read the angle from LUT_D



process (CLK_FB, RST)
begin
	if RST='0' then
		STATE <= RST_STATE;
	elsif rising_edge(CLK_FB) then
		case STATE is
			when RST_STATE =>
				DRDYi <= '0';
				STATE <= SAMPLE;				

			when SAMPLE =>
				DRDYi <= '0';
				I_d1 <= Ii;
				Q_d1 <= Qi;
				Ii <= I;
				Qi <= Q;
				STATE <= PROD_1;

			when PROD_1 =>
				Y <= Ii * Q_d1;
				X <= Ii * I_d1;
				STATE <= PROD_2;
			
			when PROD_2 =>
				Y <= Y - I_d1 * Qi;
				X <= X + Qi * Q_d1;
				LUT_ENi <= '1';
				LUT_Ai(9 downto 5) <= Y(7 downto 3);
				LUT_Ai(4 downto 0) <= X(7 downto 3);
				STATE <= OUTP;
				 
			when OUTP =>
				DRDYi <= '1';
				PHIi <= LUT_D;
				LUT_ENi <= '0';
				STATE <= SAMPLE;
			
			when others =>
				STATE <= RST_STATE;
		end case;
	end if;
end process;


PHI <= PHIi;
LUT_A <= LUT_Ai;
LUT_EN <= LUT_ENi;
DRDY <= DRDYi;

end Behavioral;
































































-- notes on trimming precision:
--	> >Regarding normalization; I basically read 14-bit complex samples off an 
--	> >ADC (14 bit real, 14 bit imag), so I was thinking I can just shift them 
--	> >so all the non-zero bits are behind the decimal point, which should be 
--	> >normalized (?).
--	> >Am I making some wrong assumption here? Is there anything wrong with 
--	> >just normalizing by shifting the hell out of it?
--	No, that's fine.  You need to count leading zeros and ones, not
--	just leading zeros, if the data is two's complement.  That's about it.
--	It's pretty straightforward that for a given number of bits in the result,
--	normalizing by a factor of two is no more than one bit worse than doing
--	a full divide.