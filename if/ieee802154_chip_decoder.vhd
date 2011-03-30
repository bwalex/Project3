library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ieee802154_chip_decoder is
    generic(
			DELAY: integer := 7;
			PHI_WIDTH : integer := 8;
			PHI_THRESH : integer := 112 -- 'DELAY' in the format of PHI
	);
	Port (
		PHI: in SIGNED (PHI_WIDTH-1 downto 0);
		DRDY_IN: in STD_LOGIC;
		CHIP : out STD_LOGIC;
		CLK_FB : in STD_LOGIC;
		RST : in STD_LOGIC;
		DRDY : out std_logic
	);
end ieee802154_chip_decoder;

architecture Behavioral of ieee802154_chip_decoder is
type DECODE_STATES is (RST_STATE, WORK );
signal STATE : DECODE_STATES;

signal DRDYi : std_logic;
signal CHIPi : STD_LOGIC;
signal SUM : SIGNED (PHI_WIDTH+DELAY downto 0);
signal count : unsigned(5 downto 0); -- XXX: might need adjustments (at least for DELAY > 31)

begin

process (CLK_FB, RST)
begin
	if RST='0' then
		STATE <= RST_STATE;
	elsif rising_edge(CLK_FB) then
		case STATE is
			when RST_STATE =>
				if DRDY_IN = '1' then
					count <= TO_UNSIGNED(DELAY, count'length);-- was DELAY-1
					DRDYi <= '0';
					STATE <= WORK;
					SUM <= (others => '0');
				end if;

			--http://www.synthworks.com/papers/vhdl_math_tricks_mapld_2003.pdf
			when WORK =>
				if DRDY_IN = '0' then
					STATE <= RST_STATE;
				else
					if count=1 then
						-- Output
						-- XXX: not 7 but rather 7 in the same format as PHI
						-- 0b01110000 -> 112
						if (SUM > TO_SIGNED(PHI_THRESH, SUM'length)) then--signed'("01110000")) then
							CHIPi <= '0';
						elsif (SUM < -TO_SIGNED(PHI_THRESH, SUM'length)) then---signed'("01110000")) then
							CHIPi <= '1';
						else
							CHIPi <= NOT CHIPi;
						end if;
						SUM <= resize(PHI, SUM'length);
						--STATE <= RST_STATE;
						DRDYi <= '1';
						count <= TO_UNSIGNED(DELAY, count'length);-- was DELAY-1; -- NOTE: 'count' depends on sample to chip ratio
					else
						SUM <= SUM + PHI;
						count <= count - 1;
						DRDYi <= '0';
					end if;
				end if;

			when others =>
				STATE <= RST_STATE;
		end case;
	end if;
end process;

DRDY <= DRDYi;
CHIP <= CHIPi;

end Behavioral;

