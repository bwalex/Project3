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

entity macctest is
    Port (
		CLK_FB	: in  STD_LOGIC;
		RST : in  STD_LOGIC;
		result : OUT SIGNED (15 downto 0)
	);
end macctest;

architecture Behavioral of macctest is
type ANGLE_STATES is (RST_STATE, SAMPLE, PROD_1, PROD_2, OUTP );

-- Thoughts:
--  - trimming precision to 8 MSB from 14 is no good, since
--    all lower q. levels will be 0.
--  - need to keep all 14 bits of precision until past the
--    multiplication process... or at least 12 or so?
--  - what is the change in multiplier DSP slice consumption?
--    will that require more DSP slices, for 14 bit mult?
--    -> seems possible to do 18x18 with one slice.
--    http://www.xilinx.com/support/documentation/user_guides/ug073.pdf
signal STATE : ANGLE_STATES;
signal Ii : SIGNED (7 downto 0);
signal Qi : SIGNED (7 downto 0);
signal I_d1 : SIGNED (7 downto 0);
signal Q_d1 : SIGNED (7 downto 0);
signal Y : SIGNED (47 downto 0); -- XXX: or 7 might need to be 15 downto 0
signal X : SIGNED (47 downto 0); -- XXX: or 7 might need to be 15 downto 0
signal PHIi : std_logic_vector (7 downto 0);
signal LUT_Ai : std_logic_vector (9 downto 0);
signal DEBUG1i : std_logic_vector (7 downto 0);
signal DEBUG2i : std_logic_vector (7 downto 0);
signal resulti : std_logic_vector (15 downto 0);
signal LUT_ENi : std_logic;
signal DRDYi : std_logic;
signal X_A : SIGNED(17 downto 0);
signal X_B : SIGNED(17 downto 0);
signal Y_A : SIGNED(17 downto 0);
signal Y_B : SIGNED(17 downto 0);
signal RST_MACC : std_logic := '0';
component MACC
   PORT (
      CLK              : in std_logic;   
      RST              : in std_logic;   
      A_IN             : in SIGNED(17 downto 0);   
      B_IN             : in SIGNED(17 downto 0);   
      ADD_SUB          : in std_logic;   
      PROD_OUT         : out SIGNED(47 downto 0));   
end component;

component XMACC
	port (
	clk: IN std_logic;
	ce: IN std_logic;
	sclr: IN std_logic;
	subtract: IN std_logic;
	a: IN signed(17 downto 0);
	b: IN signed(17 downto 0);
	s: OUT signed(47 downto 0));
end component;

begin

	maccX : XMACC
		PORT MAP (
			CLK => CLK_FB,
			CE => RST,
			SCLR => RST_MACC,
			subtract => '0',
			A => X_A,
			B => X_B,
			S => X
		);

	maccY : XMACC
		PORT MAP (
			CLK => CLK_FB,
			CE => RST,
			SCLR => RST_MACC,
			subtract => '1',
			A => Y_A,
			B => Y_B,
			S => Y
		);

--	maccX : MACC
--		PORT MAP (
--			CLK => CLK_FB,
--			RST => RST_MACC,
--			A_IN => X_A,
--			B_IN => X_B,
--			ADD_SUB => '0',
--			PROD_OUT => X
--		);
--
--	maccY : MACC
--		PORT MAP (
--			CLK => CLK_FB,
--			RST => RST_MACC,
--			A_IN => Y_A,
--			B_IN => Y_B,
--			ADD_SUB => '1',
--			PROD_OUT => Y
--		);
	-- 1) ( trim precision of I and Q down to 8 or so and normalize. )
	-- 2) calculate the 4 product terms and accumulate
	-- 3) trim precision of y and x down to 1QN (5 bit) each
	-- 4) find the atan2 by applying the y and x as address to LUT_A
	-- 5) read the angle from LUT_D



process (CLK_FB, RST)
variable first_bit_x : natural;
variable first_bit_y : natural;
begin
	if RST='0' then
		RST_MACC <= '1';
		STATE <= RST_STATE;
	elsif rising_edge(CLK_FB) then
		case STATE is
			when RST_STATE =>
				DRDYi <= '0';
				STATE <= SAMPLE;
				RST_MACC <= '1';




			when SAMPLE =>
				RST_MACC <= '0';
				DRDYi <= '0';
				I_d1 <= Ii;
				Q_d1 <= Qi;

				Ii <= I;
				Qi <= Q;
				
				
				-- VHDL sign extension: http://www.velocityreviews.com/forums/t376513-sign-extension.html
				X_A <= resize(I, X_A'length);
				X_B <= resize(Ii, X_B'length);
				Y_A <= resize(I, Y_A'length);
				Y_B <= resize(Qi, Y_B'length);
				STATE <= PROD_1;





			when PROD_1 =>
				--Y <= Ii * Q_d1;
				--X <= Ii * I_d1;
				------Y <= Ii * Q_d1 - I_d1 * Qi;
				------X <= Ii * I_d1 + Qi * Q_d1;
				X_A <= resize(Qi, X_A'length);
				X_B <= resize(Q_d1, X_B'length);
				Y_A <= resize(I_d1, Y_A'length);
				Y_B <= resize(Qi, Y_B'length);
				STATE <= PROD_2;


			when PROD_2 =>
				--Y <= Y - I_d1 * Qi;
				--X <= X + Qi * Q_d1;
				LUT_ENi <= '1';
				DEBUG2i <= std_logic_vector(Ii);

				-- new XXX: issue is likely due to X not being filled up till bit 17 with sign bit. possibly in 16?

				for i in X'high downto 0 loop
					if X(X'high) = '0' then
						if X(i) = '1' then
							-- we do +1 in both cases because we *NEED* one sign bit!
							first_bit_x := i+1;
							exit;
						end if;
					else
						if X(i) = '0' then
							-- we do +1 in both cases because we *NEED* one sign bit!
							first_bit_x := i+1;
							exit;
						end if;
					end if;
				end loop;

				for i in Y'high downto 0 loop
					if Y(Y'high) = '0' then
						if Y(i) = '1' then
							-- we do +1 in both cases because we *NEED* one sign bit!
							first_bit_y := i+1;
							exit;
						end if;
					else
						if Y(i) = '0' then
							-- we do +1 in both cases because we *NEED* one sign bit!
							first_bit_y := i+1;
							exit;
						end if;
					end if;
				end loop;

				
				if (first_bit_x > first_bit_y) then
					first_bit_y := first_bit_x;
				else
					first_bit_x := first_bit_y;
				end if;
				
				if (first_bit_x-4 < 0) then
					first_bit_x := 4;
				end if;
			
				if (first_bit_y-15 < 0) then
					first_bit_y := 15;
				end if;

				DEBUG3i <= std_logic_vector(X(first_bit_y downto first_bit_y-15));
				--DEBUG1i <= std_logic_vector(X(first_bit_x downto first_bit_x-7));
				LUT_Ai(9 downto 5) <= std_logic_vector(Y(first_bit_x downto first_bit_x-4));--Y(...8 downto 4);
				LUT_Ai(4 downto 0) <= std_logic_vector(X(first_bit_x downto first_bit_x-4));--Y(...8 downto 4);
				
				--LUT_Ai(9 downto 5) <= std_logic_vector(Y(14 downto 10));--Y(...8 downto 4); -- was: 17 downto 13
				--LUT_Ai(4 downto 0) <= std_logic_vector(X(14 downto 10));--X(...8 downto 4); -- was: 17 downto 13
				STATE <= OUTP;
				 
			when OUTP =>
				DRDYi <= '1';
				PHIi <= LUT_D;
				LUT_ENi <= '0';
				STATE <= SAMPLE;
				RST_MACC <= '1';
			
			when others =>
				STATE <= RST_STATE;
				RST_MACC <= '1';
		end case;
	end if;
end process;

result <= resulti;

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