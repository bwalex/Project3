----------------------------------------------------------------------------------
-- Author: 			 Alex Hornung
-- 
-- Create Date:    15:20:03 10/18/2010 
-- Design Name: 	 ADC Block
-- Module Name:    ADC - Behavioral 
-- Project Name:   ZigBee Dynamic Spectrum Management
-- Target Devices: Virtex4 xtremeDSP Board
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADC is
	port (
		-- Interface to ADCs:
		ADC1_D		: in  STD_LOGIC_VECTOR (13 downto 0);
		--ADC1_DRY	: in  STD_LOGIC;
		--ADC1_OVR	: in  STD_LOGIC;
		CLK_FB	: in  STD_LOGIC;

		-- misc
		CONFIG_DONE : out std_logic;
		RST			: in   STD_LOGIC;
		LED1			: out std_logic;

		-- Interface to other blocks (FIFO/interface block):
		DATA_OUT		: out  STD_LOGIC_VECTOR (31 downto 0);
		DATA_OUT_EN : out  STD_LOGIC;
		FULL			: in   STD_LOGIC;
		ENABLE		: in   STD_LOGIC;

		-- Interface to FFT
		XN_RE			: out  std_logic_vector (15 downto 0);
		XN_IM			: out  std_logic_vector (15 downto 0);

		XK_RE			: in   std_logic_vector (15 downto 0);
		XK_IM			: in   std_logic_vector (15 downto 0);

		FFT_START	: out  std_logic;
		FFT_UNLOAD	: out  std_logic;
		FFT_FWDINV	: out  std_logic;
		FFT_FWDINV_WR	: out  std_logic;

		FFT_DONE		: in   std_logic;
		FFT_DV		: in   std_logic;
		FFT_RFD		: in   std_logic;
		FFT_EXP		: in   std_logic_vector (4 downto 0);
		XN_IDX		: in   std_logic_vector (10 downto 0);
		XK_IDX		: in   std_logic_vector (10 downto 0)

	);
end ADC;


architecture Behavioral of ADC is
signal enabled : std_logic := '0';
signal DATAi   : std_logic_vector (31 downto 0);
signal DATAii  : std_logic_vector (31 downto 0);
signal WR_ENi  : std_logic;
signal count   : unsigned (15 downto 0) := (others => '0');
signal ledi		: std_logic;

signal nidx_reg : std_logic_vector (10 downto 0);
signal kidx_reg : std_logic_vector (10 downto 0);
signal ready	: std_logic;
signal valid	: std_logic;
signal starti	: std_logic;
signal done		: std_logic;
signal unloadi : std_logic;
signal exp		: std_logic_vector (4 downto 0);
type FFT_STATES is (RST_STATE, IDLE, START, FILL, WAIT_XFORM, WAIT_UNLOAD, UNLOAD, WAIT_DONE, DONE_DONE);
signal FFT_STATE : FFT_STATES;
signal FFT_STATEd1 : FFT_STATES;

begin
-- module configured
CONFIG_DONE <= '0';

process (CLK_FB, RST)
begin
	if RST = '0' then
		enabled <= '0';
	elsif rising_edge(CLK_FB) then
		enabled <= ENABLE;
	end if;
end process;

process (CLK_FB, RST)
begin
	if RST = '0' then
		nidx_reg <= (others => '0');
		kidx_reg <= (others => '0');
		ready <= '0';
		valid <= '0';
		done <= '0';
	elsif rising_edge(CLK_FB) then
		nidx_reg <= XN_IDX;
		kidx_reg <= XK_IDX;
		ready <= FFT_RFD;
		valid <= FFT_DV;
		done <= FFT_DONE;
	end if;
end process;



-- Light led when ADC block is enabled
LED1 <= not enabled;

--re-enable the following if the internal light is to be used
--LED1 <= ledi;


process (CLK_FB, RST)
begin
	if RST = '0' then
	elsif rising_edge(CLK_FB) then
		if FULL = '1' then
			--WR_ENi <= '0';
		elsif enabled = '1' then
			DATAi(13 downto 0) <= ADC1_D;
			if (DATAi(13) = '1') then
				DATAi(31 downto 14) <= (others => '1');
			else 
				DATAi(31 downto 14) <= (others => '0');
			end if;
			--WR_ENi <= '1';
		elsif enabled = '0' then
			--WR_ENi <= '0';
		end if;
	end if;
end process;



--DATA_OUT <= DATAi;
DATA_OUT_EN <= WR_ENi;

-- Delayed versions of empty and busy
process (CLK_FB, RST)
begin
	if RST='0' then
		FFT_STATEd1 <= IDLE;
	elsif rising_edge(CLK_FB) then
		FFT_STATEd1 <= FFT_STATE;
	end if;
end process;

-- Main state machine
process (CLK_FB, RST)
begin
	if RST='0' then
		FFT_STATE <= RST_STATE;
	elsif rising_edge(CLK_FB) then
		case FFT_STATE is
			when RST_STATE =>
				starti <= '0';
				unloadi <= '0';
				FFT_STATE <= IDLE;
				--ledi <= '1';

			when IDLE =>
				if enabled = '1' then
					FFT_STATE <= START;
					starti <= '1';
				end if;

			when START =>
				starti <= '0';
				if ready = '0' then
					FFT_STATE <= START;
				else
					FFT_STATE <= FILL;
				end if;

			when FILL =>
				if ready ='0' then
					FFT_STATE <= WAIT_XFORM;
				else
					FFT_STATE <= FILL;
				end if;

			when WAIT_XFORM =>
				if done = '0' then
					FFT_STATE <= WAIT_XFORM;
				else
					unloadi <= '1';
					FFT_STATE <= WAIT_UNLOAD;
					--ledi <= '0';
				end if;
			
			when WAIT_UNLOAD =>
					unloadi <= '0';
				if valid = '0' then
					FFT_STATE <= WAIT_UNLOAD;
				else
					exp <= FFT_EXP;
					WR_ENi <= '1';
					DATAii(15 downto 0) <= XK_RE;
					DATAii(31 downto 16) <= XK_IM;
					FFT_STATE <= UNLOAD;
				end if;

			when UNLOAD =>
				if (valid = '1') then
					WR_ENi <= '1';
					DATAii(15 downto 0) <= XK_RE;
					DATAii(31 downto 16) <= XK_IM;
					FFT_STATE <= UNLOAD;
					--ledi <= '0';
				else
					WR_ENi <= '0';
					FFT_STATE <= WAIT_DONE;
				end if;

			when WAIT_DONE =>
				WR_ENi <= '1';
				DATAii(4 downto 0) <= exp;
				DATAii(31 downto 5) <= (others => '0');
				FFT_STATE <= DONE_DONE;

			when DONE_DONE =>
				WR_ENi <= '0';
				FFT_STATE <= DONE_DONE;

			when others =>
				FFT_STATE <= RST_STATE;
		end case;
	end if;
end process;


DATA_OUT <= DATAii;

FFT_UNLOAD <= unloadi;
FFT_START <= starti;

FFT_FWDINV <= '1';
FFT_FWDINV_WR <= '1';
XN_RE	<= DATAi(15 downto 0);
XN_IM <= (others => '0');


end Behavioral;

