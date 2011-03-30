library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ieee802154_symbol_decoder is
	Port (
		DRDY_IN: in STD_LOGIC;
		CHIP : in STD_LOGIC;
		CLK_FB : in STD_LOGIC;
		CLK_CHIP : in STD_LOGIC;
		RST : in STD_LOGIC;
		SRST : in STD_LOGIC;

		SYMBOL : OUT STD_LOGIC_VECTOR(3 downto 0);
		SYMBOL_CORR : OUT STD_LOGIC_VECTOR(5 downto 0);
		DRDY_OUT : out STD_LOGIC
	);
end ieee802154_symbol_decoder;

architecture Behavioral of ieee802154_symbol_decoder is
type SYM_STATES is (RST_STATE, SYNCING, SYNCED, DECODING, DECISION, STOPPED);
type CORR_STRUCTURE is ARRAY (0 to 15) of UNSIGNED(5 downto 0); -- 6 bits wide, 16 entries deep

signal STATE : SYM_STATES;
signal CORR : CORR_STRUCTURE;

signal SHREG : STD_LOGIC_VECTOR(31 downto 0);
signal CSEQ_0 : STD_LOGIC_VECTOR(30 downto 0) := "1100000011101111010111001101100"; -- as usual, note bit ordering!

signal counter : unsigned(7 downto 0);
signal counter2 : unsigned(7 downto 0);
signal zerocount : signed(4 downto 0);
signal SYMBOLi : std_logic_vector(3 downto 0);
signal LUT_Ai : std_logic_vector(4 downto 0);
signal LUT_Di : std_logic_vector(0 to 15); -- note bit ordering!!!!!!!!

signal sermax_en : std_logic;
signal sermax_in : unsigned(5 downto 0);
signal sermax_max : unsigned(5 downto 0);
signal sermax_idx : unsigned(3 downto 0);

signal DRDYi : std_logic := '0';

signal GO : std_logic := '0';


-- v2.0 signals
signal CHIPi : std_logic;
signal CHIP_RDY : std_logic;
signal SYNC1 : std_logic;
signal SYNC2 : std_logic;
signal NEWDATA : std_logic;




component ieee802154_chip_seq_rom -- chipping sequence LUT
	port (
				clka: IN std_logic;
				addra: IN std_logic_VECTOR(4 downto 0);
				douta: OUT std_logic_VECTOR(15 downto 0)
	);
end component;

COMPONENT sermax
    generic(
			A_WIDTH: 	positive:=sermax_in'length;
			IDX_WIDTH:	positive:=sermax_idx'length
	);
	PORT(
		CLK : IN std_logic;
		EN : IN std_logic;
		A : in  unsigned(A_WIDTH-1 downto 0);
		MAX_VAL:		out unsigned(A_WIDTH-1 downto 0);
		MAX_IDX:		out unsigned(IDX_WIDTH-1 downto 0)
	);
END COMPONENT;




begin


	cs_lut_1 : ieee802154_chip_seq_rom
			PORT MAP (
				clka => CLK_FB,
				addra => LUT_Ai,
				douta => LUT_Di
			);
			
			
	sermax_1: sermax
	PORT MAP(
		CLK => CLK_FB,
		EN => sermax_en,
		A => sermax_in,
		MAX_VAL => sermax_max,
		MAX_IDX => sermax_idx
	);

--http://www.xilinx.com/itp/3_1i/data/fise/xst/chap02/xst02007.htm
--
--		/*
--		 * According to the 802.15.4-2003 standard:
--		 * The 4 LSBs (b0, b1, b2, b3) of each octet shall
--		 * map into one data symbol, and the 4 MSBs
--		 * b4, b5, b6, b7) of each octet shall map into the
--		 * next data symbol.
--		 */




process(CLK_FB, RST)
begin
	if RST='0' then
		STATE <= RST_STATE;
		DRDYi <= '0';
		counter <= (others => '0');
	elsif rising_edge(CLK_FB) then
		if SRST='1' then
			STATE <= RST_STATE;
			DRDYi <= '0';
		else
			case STATE is
				when RST_STATE =>
					if DRDY_IN='1' then
						GO <= '1';
						STATE <= SYNCING;
						counter <= TO_UNSIGNED(31, counter'length);
						--counter <= TO_UNSIGNED(30, counter'length);
						for i in CORR'range loop
							CORR(i) <= (others => '0');
						end loop;
						zerocount <= (others => '0');
						counter2 <= (others => '0');
						SHREG <= (others => '0');
					end if;
					GO <= '0';
					DRDYi <= '0';

				when SYNCING =>
					DRDYi <= '0';
					if NEWDATA='1' then -- this can only run every 2 MHz
						SYNC2 <= SYNC1; -- VERY IMPORTANT: marks data as read.
						--SHREG <= SHREG(30 downto 0) & CHIP;
						SHREG <= SHREG(30 downto 0) & CHIPi;

						counter2 <= (others => '0');
						
						-- Wait to have enough chips before continuing. The SHREG needs
						-- to be full to be able to start the sync process.
						if (counter > 0) then
							counter <= counter - 1;
						else
							-- This is the case once new data arrives AND we have had
							-- enough data during the previous chip period.
							--
							-- We calculate the correlation of the current content of
							-- SHREG and based on that we count the zeros and move on
							-- to the DECODING stage, eventually.
							-- This all happens for the previous 30 chips while the new
							-- chip arrives.
							if CORR(0) > 22 then
								if (zerocount = 3) then -- XXX: adjust zerocount
									LUT_Ai <= (others => '0');
									for i in CORR'range loop
										CORR(i) <= (others => '0');
									end loop;

									counter <= (others => '0');
									counter2 <= (others => '0');
									SYNC2 <= not SYNC1; -- mark as unread again... a bit of a hack
									STATE <= DECODING;

									zerocount <= (others => '0');
								else
									zerocount <= zerocount + 1;
									counter <= TO_UNSIGNED(31, counter'length);
									counter2 <= (others => '0');
									CORR(0) <= (others => '0');
								end if;
							else
								CORR(0) <= (others => '0');
								zerocount <= (others => '0');
							end if;
						end if;
					elsif counter = 0 then
						-- We have the minimum number of chips (32)
						-- Now we can start the correlation
						if counter2 < SHREG'high then
							if SHREG(to_integer(resize(counter2, 5))) = CSEQ_0(to_integer(resize(counter2, 5))) then
								CORR(0) <= CORR(0) + 1;
							end if;
							counter2 <= counter2 + 1;
						end if;
					end if;


				when DECODING =>
					DRDYi <= '0';
					if NEWDATA = '1' then
						SYNC2 <= SYNC1; -- VERY IMPORTANT: marks data as read.

						for i in CORR'range loop
							if LUT_Di(i) = CHIPi then
								CORR(i) <= CORR(i) + 1;
							end if;
						end loop;
						LUT_Ai <= std_logic_vector(unsigned(LUT_Ai) + unsigned'("01")); -- unsigned addition
						if counter = 31 then
							STATE <= DECISION;
							counter <= (others => '0');
						else
							counter <= counter + 1;
						end if;
					end if;


				when DECISION =>
					if counter <= 15 then
						-- We still need to push correlation counters into sermax
						sermax_in <= CORR(to_integer(resize(counter, 4)));
						sermax_en <= '1';
						counter <= counter + 1;
					elsif counter = 16 then
						-- we need to wait one clock cycle for sermax to finish
						counter <= counter + 1;
					else
						-- now we can get the decision; all correlation counters
						-- have been pushed in
						SYMBOLi <= std_logic_vector(sermax_idx);
						sermax_en <= '0';
						DRDYi <= '1';
						
						-- prepare for DECODING
						LUT_Ai <= (others => '0');
						for i in CORR'range loop
							CORR(i) <= (others => '0');
						end loop;

						counter <= (others => '0');
						counter2 <= (others => '0');
						STATE <= DECODING;
					end if;

				when others =>
					STATE <= RST_STATE;
			end case;
		end if;
	end if;
end process;

SYMBOL <= SYMBOLi;
SYMBOL_CORR <= std_logic_vector(sermax_max);
DRDY_OUT <= DRDYi;



-- v2.0 stuff
NEWDATA <= '0' when SYNC1=SYNC2 ELSE '1'; -- SYNC1 xor SYNC2
process (CLK_CHIP, RST)
begin
	if RST = '0' then
		CHIP_RDY <= '0';
		SYNC1 <= '0';
	elsif rising_edge(CLK_CHIP) then
		--if DRDY_IN='1' then
			CHIPi <= CHIP;
			CHIP_RDY <= '1';
			SYNC1 <= NOT SYNC1;
		--end if;
	end if;
end process;


end Behavioral;

