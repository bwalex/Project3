library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ieee802154_controller is
	Port (
		DRDY_IN: in STD_LOGIC;
		SYM : in STD_LOGIC_VECTOR(3 downto 0);
		CORR : in STD_LOGIC_VECTOR(5 downto 0);
		CLK_FB : in STD_LOGIC;
		CLK_SYM : in STD_LOGIC;
		RST : in STD_LOGIC;

		OCTET : out STD_LOGIC_VECTOR(7 downto 0);
		DATA_RDY : out STD_LOGIC;
		SRST_SYMDEC : out STD_LOGIC
	);
end ieee802154_controller;

architecture Behavioral of ieee802154_controller is
type CTRL_STATES is (RST_STATE, PREAMBLE_SFD_L, SFD_H, FRLEN_L, FRLEN_H, FRAME_L, FRAME_H, CKSUM);

signal STATE : CTRL_STATES;

signal SYMi		: STD_LOGIC_VECTOR(3 downto 0);
signal CORRi	: STD_LOGIC_VECTOR(5 downto 0);

signal SYNC1 : std_logic;
signal SYNC2 : std_logic;
signal NEWDATA : std_logic;
signal FRLEN : UNSIGNED(7 downto 0);
signal COUNT  : UNSIGNED(7 downto 0);
signal OCTETi : STD_LOGIC_VECTOR(7 downto 0);
begin






process(CLK_FB, RST)
begin
	if RST='0' then
		STATE <= RST_STATE;
		DATA_RDY <= '0';
		OCTET <= (others => '0');
		OCTETi <= (others => '0');
		FRLEN <= (others => '0');

	elsif rising_edge(CLK_FB) then
		case STATE is
			when RST_STATE =>
				DATA_RDY <= '0';
				STATE <= PREAMBLE_SFD_L;
				SRST_SYMDEC <= '1';

			-- we can verify the SFD 0xA7
			-- which is symbol 0x7 followed by symbol 0xA, since LSB goes first
			when PREAMBLE_SFD_L =>
				SRST_SYMDEC <= '0';
				if NEWDATA='1' then
					SYNC2 <= SYNC1; -- marks data as read.
					if SYMi = "0000" then
						STATE <= PREAMBLE_SFD_L;
					elsif SYMi = "0111" then -- symbol 0x7
						STATE <= SFD_H;
					else
						STATE <= RST_STATE;
					end if;
				end if;

			when SFD_H =>
				if NEWDATA = '1' then
					SYNC2 <= SYNC1; -- marks data as read.
					if SYMi = "1010" then -- symbol 0xA
						STATE <= FRLEN_L;
						FRLEN <= (others => '0');
					else
						STATE <= RST_STATE; -- reset
					end if;
				end if;

			when FRLEN_L =>
				if NEWDATA = '1' then
					SYNC2 <= SYNC1; -- marks data as read.
					FRLEN(3 downto 0) <= unsigned(SYMi);
					STATE <= FRLEN_H;
				end if;

			when FRLEN_H =>
				if NEWDATA = '1' then
					SYNC2 <= SYNC1; -- marks data as read.
					FRLEN(7) <= '0';
					FRLEN(6 downto 4) <= unsigned(SYMi(2 downto 0)); -- XXX: might be 3 downto 1??
					COUNT <= (others => '0');
					STATE <= FRAME_L;

					-- set up first octet with size
					OCTETi(7) <= '0';
					OCTETi(6 downto 4) <= SYMi(2 downto 0);
					OCTETi(3 downto 0) <= std_logic_vector(FRLEN(3 downto 0));
				end if;

--		/*
--		 * According to the 802.15.4-2003 standard:
--		 * The 4 LSBs (b0, b1, b2, b3) of each octet shall
--		 * map into one data symbol, and the 4 MSBs
--		 * b4, b5, b6, b7) of each octet shall map into the
--		 * next data symbol.
--		 */
			when FRAME_L =>
				if NEWDATA = '1' then
					SYNC2 <= SYNC1;
					OCTET <= OCTETi; --except if previous state was FRLEN?
					DATA_RDY <= '1';
					if COUNT < FRLEN then
						COUNT <= COUNT + 1;
						STATE <= FRAME_H;
						OCTETi(3 downto 0) <= SYMi;
					else
						STATE <= RST_STATE;
					end if;
				end if;

			when FRAME_H =>
				DATA_RDY <= '0';
				if NEWDATA = '1' then
					SYNC2 <= SYNC1;
					STATE <= FRAME_L;
					OCTETi(7 downto 4) <= SYMi;
				end if;

			when others =>
				STATE <= RST_STATE;
		end case;
	end if;
end process;




NEWDATA <= '0' when SYNC1=SYNC2 ELSE '1'; -- SYNC1 xor SYNC2
process (CLK_SYM, RST)
begin
	if RST = '0' then
		SYNC1 <= '0';
	elsif rising_edge(CLK_SYM) then
		--if DRDY_IN='1' then
			SYMi <= SYM;
			CORRi <= CORR;
			SYNC1 <= NOT SYNC1;
		--end if;
	end if;
end process;

end Behavioral;

