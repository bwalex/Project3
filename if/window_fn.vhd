library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- NOTE: 1 clock cycle latency from ENable to OUTPUT/DATA_RDY

entity window_fn is
    generic(
			IN_WIDTH: 	positive:=14;
			OUT_WIDTH:	positive:=16;
			WINDOW_WIDTH:	positive:=11; -- 2048
			WINDOW_DEPTH:	positive:=8
	);
	port (
		-- Interface to ADCs:
		DATA_I	: in  STD_LOGIC_VECTOR (IN_WIDTH-1 downto 0);
		DATA_Q	: in  STD_LOGIC_VECTOR (IN_WIDTH-1 downto 0);
		CLK_FB	: in  STD_LOGIC;
		RST		: in  STD_LOGIC;
		EN			: in	STD_LOGIC;

		-- misc
		DATA_RDY : out STD_LOGIC;
		OUT_I	: out STD_LOGIC_VECTOR (OUT_WIDTH-1 downto 0);
		OUT_Q : out STD_LOGIC_VECTOR (OUT_WIDTH-1 downto 0)
	);
end window_fn;

architecture Behavioral of window_fn is
component window_rom
	port (
	clka: IN std_logic;
	addra: IN std_logic_VECTOR(WINDOW_WIDTH-1 downto 0);
	douta: OUT std_logic_VECTOR(WINDOW_DEPTH-1 downto 0));
end component;

-- needs to match FFT width (2^11 = 2048)
signal		LUT_Ai 		: std_logic_vector(WINDOW_WIDTH-1 downto 0);
signal		LUT_Di 		: std_logic_vector(WINDOW_DEPTH-1 downto 0);

signal		DATAi_I	: SIGNED (LUT_Di'length+DATA_I'length-1 downto 0);
signal		DATAi_Q	: SIGNED (LUT_Di'length+DATA_Q'length-1 downto 0);

type WINDOW_STATES is (RST_STATE, WORK);
signal WINDOW_STATE : WINDOW_STATES;

begin
	window_rom_1 : window_rom
		PORT MAP (
			clka => CLK_FB,
			addra => LUT_Ai,
			douta => LUT_Di
		);

process (CLK_FB, RST)
begin
	if RST = '0' then
		DATA_RDY <= '0';
		DATAi_I <= (others => '0');
		DATAi_Q <= (others => '0');
		WINDOW_STATE <= RST_STATE;
	elsif rising_edge(CLK_FB) then
		case WINDOW_STATE is
			when RST_STATE =>
				DATAi_I <= (others => '0');
				DATAi_Q <= (others => '0');
				DATA_RDY <= '0';
				LUT_Ai <= (others => '0');
				if EN = '1' then
					WINDOW_STATE <= WORK;
				end if;

			when WORK =>
				if EN = '1' then
					DATAi_I <= signed(DATA_I) * signed('0' & LUT_Di);
					DATAi_Q <= signed(DATA_Q) * signed('0' & LUT_Di);
					DATA_RDY <= '1';
					LUT_Ai <= std_logic_vector(unsigned(LUT_Ai) + unsigned'("01")); -- unsigned addition
				else
					DATA_RDY <= '0';
					WINDOW_STATE <= RST_STATE;
				end if;
		end case;
	end if;
end process;

OUT_I <= std_logic_vector(DATAi_I(DATAi_I'high downto DATAi_I'high-(OUT_WIDTH-1)));
OUT_Q <= std_logic_vector(DATAi_Q(DATAi_Q'high downto DATAi_Q'high-(OUT_WIDTH-1)));

end Behavioral;

