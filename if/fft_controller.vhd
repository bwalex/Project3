library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity fft_controller is
	GENERIC (
		WIDTH: 	positive:=22
	);
	port (
		-- Interface to ADCs:
		DATA_I	: in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		DATA_Q	: in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		CLK_FB	: in  STD_LOGIC;
		RST		: in  STD_LOGIC;
		EN			: in  STD_LOGIC;

		-- misc
		DATA_RDY : out STD_LOGIC;
		BUSY		: out STD_LOGIC;
		OUT_I	: out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		OUT_Q : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		
		-- debug
		XN_IDX		: out std_logic_vector (10 downto 0)
	);
end fft_controller;



architecture Behavioral of fft_controller is

component fft1
	port (
	clk: IN std_logic;
	start: IN std_logic;
	unload: IN std_logic;
	xn_re: IN std_logic_VECTOR(WIDTH-1 downto 0);
	xn_im: IN std_logic_VECTOR(WIDTH-1 downto 0);
	fwd_inv: IN std_logic;
	fwd_inv_we: IN std_logic;
	scale_sch: IN std_logic_VECTOR(11 downto 0);
	scale_sch_we: IN std_logic;
	rfd: OUT std_logic;
	xn_index: OUT std_logic_VECTOR(10 downto 0);
	busy: OUT std_logic;
	edone: OUT std_logic;
	done: OUT std_logic;
	dv: OUT std_logic;
	xk_index: OUT std_logic_VECTOR(10 downto 0);
	xk_re: OUT std_logic_VECTOR(WIDTH-1 downto 0);
	xk_im: OUT std_logic_VECTOR(WIDTH-1 downto 0)
	);
end component;

signal		XK_RE			: std_logic_vector (WIDTH-1 downto 0);
signal		XK_IM			: std_logic_vector (WIDTH-1 downto 0);

signal		FFT_START	: std_logic;
signal		FFT_UNLOAD	: std_logic;
signal		FFT_FWDINV	: std_logic;
signal		FFT_FWDINV_WR	: std_logic;

signal		FFT_scale_sch: std_logic_VECTOR(11 downto 0);
signal		FFT_scale_sch_we: std_logic;

signal		FFT_DONE		: std_logic;
signal		FFT_VALID	: std_logic;
signal		FFT_READY	: std_logic;
signal		FFT_EXP		: std_logic_vector (4 downto 0);
--signal		XN_IDX		: std_logic_vector (10 downto 0);
signal		XK_IDX		: std_logic_vector (10 downto 0);

type FFT_STATES is (RST_STATE, IDLE, START, FILL, WAIT_XFORM, WAIT_UNLOAD, UNLOAD, WAIT_DONE, DONE_DONE);
signal FFT_STATE : FFT_STATES;
signal FFT_STATEd1 : FFT_STATES;

signal		enabled	: std_logic;
signal		exp		: std_logic_vector (4 downto 0);


begin

fft : fft1
		port map (
			--PORT => NET
			clk => CLK_FB,
			start => FFT_START,
			unload => FFT_UNLOAD,
			xn_re => DATA_I,
			xn_im => DATA_Q,
			fwd_inv => FFT_FWDINV,
			fwd_inv_we => FFT_FWDINV_WR,
			scale_sch => fft_scale_sch,
			scale_sch_we => fft_scale_sch_we,
			rfd => FFT_READY,
			xn_index => XN_IDX,
			done => FFT_DONE,
			dv => FFT_VALID,
			xk_index => XK_IDX,
			xk_re => XK_RE,
			xk_im => XK_IM
		);



FFT_FWDINV <= '1';
FFT_FWDINV_WR <= '1';
FFT_scale_sch_we <= '0';
FFT_scale_sch <= "101010101010";


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
		BUSY <= '0';
		OUT_I <= (others => '0');
		OUT_Q <= (others => '0');
		DATA_RDY <= '0';
		FFT_STATE <= RST_STATE;
	elsif rising_edge(CLK_FB) then
		case FFT_STATE is
			when RST_STATE =>
				BUSY <= '0';
				FFT_START <= '0';
				FFT_UNLOAD <= '0';
				enabled <= '0';
				FFT_STATE <= IDLE;
				--ledi <= '1';

			when IDLE =>
				enabled <= EN;
				BUSY <= '0';
				if EN = '1' then
					BUSY <= '1';
					enabled <= '0';
					FFT_STATE <= FILL; -- XXX: was START
					FFT_START <= '1';
				end if;

--			when START =>
--				BUSY <= '1';
--				FFT_START <= '0';
--				if FFT_READY = '0' then
--					FFT_STATE <= START;
--				else
--					FFT_STATE <= FILL;
--				end if;

			when FILL =>
				BUSY <= '1';
				FFT_START <= '0';
				if FFT_READY ='0' then
					FFT_STATE <= WAIT_XFORM;
				else
					FFT_STATE <= FILL;
				end if;

			when WAIT_XFORM =>
				if FFT_DONE = '0' then
					FFT_STATE <= WAIT_XFORM;
				else
					FFT_UNLOAD <= '1';
					FFT_STATE <= WAIT_UNLOAD;
					--ledi <= '0';
				end if;
			
			when WAIT_UNLOAD =>
					FFT_UNLOAD <= '0';
				if FFT_VALID = '0' then
					FFT_STATE <= WAIT_UNLOAD;
				else
					exp <= FFT_EXP;
					DATA_RDY <= '1';
					OUT_I <= XK_RE;
					OUT_Q <= XK_IM;
					FFT_STATE <= UNLOAD;
				end if;

			when UNLOAD =>
				if (FFT_VALID = '1') then
					DATA_RDY <= '1';
					OUT_I <= XK_RE;
					OUT_Q <= XK_IM;
					FFT_STATE <= UNLOAD;
				else
					DATA_RDY <= '0';
					FFT_STATE <= WAIT_DONE;
				end if;

			when WAIT_DONE =>
				--WR_ENi <= '1';
				--DATAii(4 downto 0) <= exp;
				--DATAii(31 downto 5) <= (others => '0');
				FFT_STATE <= DONE_DONE;

			when DONE_DONE =>
				--WR_ENi <= '0';
				FFT_STATE <= RST_STATE;

			when others =>
				FFT_STATE <= RST_STATE;
		end case;
	end if;
end process;



end Behavioral;

