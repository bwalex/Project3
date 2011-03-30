library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity ieee802154_angle is
    generic(
			IQ_WIDTH : integer := 8;
			DELAY: integer := 7;
			MULTIPLICAND_WIDTH : integer := 18;
			XY_WIDTH : integer := 36 -- XXX: must match the normal fp mult for simulation (36 vs hardware: 48)
	);
    Port (
		I : in  SIGNED(IQ_WIDTH-1 downto 0);
		Q : in  SIGNED (IQ_WIDTH-1 downto 0);
		PHI : out  STD_LOGIC_VECTOR (7 downto 0);
		DRDY : out std_logic;
		CLK_FB	: in  STD_LOGIC;
		RST : in  STD_LOGIC
	);
end ieee802154_angle;

architecture Behavioral of ieee802154_angle is
type ANGLE_STATES is (RST_STATE, SAMPLE, PROD_1, PROD_2, OUTP );


type DELAY_STRUCTURE is ARRAY (1 to DELAY) of SIGNED(IQ_WIDTH-1 downto 0);


-- Thoughts:
--  - trimming precision to 8 MSB from 14 is no good, since
--    all lower q. levels will be 0.
--  - need to keep all 14 bits of precision until past the
--    multiplication process... or at least 12 or so?
signal STATE : ANGLE_STATES;
signal Ii : SIGNED (IQ_WIDTH-1 downto 0) := (others => '0');
signal Qi : SIGNED (IQ_WIDTH-1 downto 0) := (others => '0');



signal I_dn: DELAY_STRUCTURE;
signal Q_dn: DELAY_STRUCTURE;


signal Y : SIGNED (XY_WIDTH-1 downto 0);
signal X : SIGNED (XY_WIDTH-1 downto 0);
signal PHIi : std_logic_vector (7 downto 0);
signal LUT_Ai : std_logic_vector (9 downto 0);
signal LUT_Di :  STD_LOGIC_VECTOR (7 downto 0);
signal LUT_ENi : std_logic;
signal DRDYi : std_logic;
signal MACC_OP : std_logic;
signal X_A : SIGNED(MULTIPLICAND_WIDTH-1 downto 0);
signal X_B : SIGNED(MULTIPLICAND_WIDTH-1 downto 0);
signal Y_A : SIGNED(MULTIPLICAND_WIDTH-1 downto 0);
signal Y_B : SIGNED(MULTIPLICAND_WIDTH-1 downto 0);

signal RST_MACC : std_logic := '0';
signal MACC_EN : std_logic := '0';
signal one : SIGNED(2 downto 0) := "001";




component atan2lut
	port (
				clka: IN std_logic;
				addra: IN std_logic_VECTOR(9 downto 0);
				douta: OUT std_logic_VECTOR(7 downto 0)
	);
end component;


component MACCv2
    generic(A_WIDTH:        positive:=X_A'length;
            B_WIDTH:        positive:=X_B'length;
            RES_WIDTH:      positive:=X'length);
    port(   CLK:            in  std_logic;
            A:              in  signed(A_WIDTH-1 downto 0);
            B:              in  signed(B_WIDTH-1 downto 0);

				EN:				 in  std_logic;
            Oper_Load:      in  std_logic;
            Oper_AddSub:    in  std_logic;

            RES:             out signed(RES_WIDTH-1 downto 0)
    );
end component;


begin


	atan2lut_1 : atan2lut
			PORT MAP (
				clka => CLK_FB,
				addra => LUT_Ai,
				douta => LUT_Di
			);

	maccX : MACCv2
		generic MAP (
			A_WIDTH => X_A'length,
         B_WIDTH => X_B'length,
         RES_WIDTH => X'length
		)
		PORT MAP (   
				CLK => CLK_FB,
            A => X_A,
            B => X_B,

				EN => MACC_EN,
            Oper_Load => MACC_OP,
            Oper_AddSub => '0',  
            RES => X
		);

	maccY : MACCv2
		generic MAP (
			A_WIDTH => Y_A'length,
         B_WIDTH => Y_B'length,
         RES_WIDTH => Y'length
		)
		PORT MAP (
				CLK => CLK_FB,
            A => Y_A,
            B => Y_B,

				EN => MACC_EN,
            Oper_Load => MACC_OP,
            Oper_AddSub => '1',  
            RES => Y
		);
		
		
		


process (CLK_FB, RST)
variable first_bit_x : integer;
variable first_bit_y : integer;

variable Ys : SIGNED (XY_WIDTH-1 downto 0);
variable Xs : SIGNED (XY_WIDTH-1 downto 0);

begin
	if RST='0' then
		RST_MACC <= '1';
		DRDYi <= '0';
		STATE <= RST_STATE;
		
	elsif rising_edge(CLK_FB) then
		case STATE is
			when RST_STATE =>
				MACC_OP <= '0';
				DRDYi <= '0';
				STATE <= SAMPLE;
				RST_MACC <= '1';
				MACC_EN <= '0';



			when SAMPLE =>
				RST_MACC <= '0';
				MACC_EN <= '0';

				for i in 1 to DELAY loop
					if i = 1 then
						I_dn(1) <= Ii;
						Q_dn(1) <= Qi;
					else
						I_dn(i) <= I_dn(i-1);
						Q_dn(i) <= Q_dn(i-1);
					end if;
				end loop;
				Ii <= I;
				Qi <= Q;

				-- VHDL sign extension: http://www.velocityreviews.com/forums/t376513-sign-extension.html

				STATE <= PROD_1;



			when PROD_1 =>
				X_A <= resize(Ii, X_A'length);--resize(I, X_A'length);
				X_B <= resize(I_dn(DELAY), X_B'length);
				Y_A <= resize(Ii, Y_A'length);
				Y_B <= resize(Q_dn(DELAY), Y_B'length);
				MACC_EN <= '1'; -- enable MACC unit
				MACC_OP <= '0'; -- reset accumulator
				STATE <= PROD_2;



			when PROD_2 =>
				X_A <= resize(Qi, X_A'length);
				X_B <= resize(Q_dn(DELAY), X_B'length);
				Y_A <= resize(I_dn(DELAY), Y_A'length);
				Y_B <= resize(Qi, Y_B'length);
				MACC_OP <= '1'; -- use accumulator
				MACC_EN <= '1'; -- enable MACC unit

				LUT_ENi <= '1'; -- enable atan2 LUT ROM

				-- This retrieves the N most significant non-zero bits of both X and Y
				-- whle maintaing their relative magnitudes.
				Xs := X;
				Ys := Y;
				for i in X'range loop
					if i = 2 then -- 1 would be ok, too
						Ys := (others => '0');
						Xs := (others => '0');
						exit;
					end if;
					if Xs(X'high) = Xs(Xs'high-1) and Ys(Ys'high) = Ys(Ys'high-1) then
						for k in Xs'range loop
							if k = 0 then
								Xs(k) := '0';
								Ys(k) := '0';
							else
								Xs(k) := Xs(k-1);
								Ys(k) := Ys(k-1);
							end if;
						end loop;
					else
						exit; -- exit loop
					end if;
				end loop;




				LUT_Ai(9 downto 5) <= std_logic_vector(Ys(Ys'high downto Ys'high-4));
				LUT_Ai(4 downto 0) <= std_logic_vector(Xs(Xs'high downto Xs'high-4));
				STATE <= OUTP;



			when OUTP =>
				MACC_EN <= '0';
				DRDYi <= '1';
				PHIi <= LUT_Di;
				LUT_ENi <= '0';
				STATE <= SAMPLE;
				RST_MACC <= '1';
			
			when others =>
				MACC_EN <= '0';
				STATE <= RST_STATE;
				RST_MACC <= '1';
		end case;
	end if;
end process;


PHI <= PHIi;
DRDY <= DRDYi;


end Behavioral;



