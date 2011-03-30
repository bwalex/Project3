library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity fft_spectrum is
	GENERIC (
		WIDTH: 	positive:=22
	);
	port (
		-- Interface to ADCs:
		DATA_I	: in  STD_LOGIC_VECTOR (13 downto 0);
		DATA_Q	: in  STD_LOGIC_VECTOR (13 downto 0);
		CLK_FB	: in  STD_LOGIC;
		RST		: in  STD_LOGIC;
		EN			: in	STD_LOGIC;

		-- misc
		DATA_RDY : out STD_LOGIC;
		OUT_I	: out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
	);
end fft_spectrum;

architecture Behavioral of fft_spectrum is
	COMPONENT window_fn
    generic(
			IN_WIDTH: 	positive:=14;
			OUT_WIDTH:	positive:=22;
			WINDOW_WIDTH:	positive:=11; -- 2048
			WINDOW_DEPTH:	positive:=8
	);
	PORT(
		DATA_I : IN std_logic_vector(13 downto 0);
		DATA_Q : IN std_logic_vector(13 downto 0);
		CLK_FB : IN std_logic;
		RST : IN std_logic;
		EN : IN std_logic;          
		DATA_RDY : OUT std_logic;
		OUT_I : OUT std_logic_vector(WIDTH-1 downto 0);
		OUT_Q : OUT std_logic_vector(WIDTH-1 downto 0)
		);
	END COMPONENT;

	COMPONENT fft_controller
	GENERIC (
		WIDTH: 	positive:=22
	);
	PORT(
		DATA_I : IN std_logic_vector(WIDTH-1 downto 0);
		DATA_Q : IN std_logic_vector(WIDTH-1 downto 0);
		CLK_FB : IN std_logic;
		RST : IN std_logic;
		EN : IN std_logic;          
		DATA_RDY : OUT std_logic;
		BUSY : OUT std_logic;
		OUT_I : OUT std_logic_vector(WIDTH-1 downto 0);
		OUT_Q : OUT std_logic_vector(WIDTH-1 downto 0);
		XN_IDX : OUT std_logic_vector(10 downto 0)
		);
	END COMPONENT;

	COMPONENT mag_cordic
		port (
		x_in: IN std_logic_VECTOR(WIDTH-1 downto 0);
		y_in: IN std_logic_VECTOR(WIDTH-1 downto 0);
		nd: IN std_logic;
		x_out: OUT std_logic_VECTOR(WIDTH-1 downto 0);
		rdy: OUT std_logic;
		clk: IN std_logic;
		sclr: IN std_logic);
	end COMPONENT;

	signal DATA_I_WDW : std_logic_vector(WIDTH-1 downto 0);
	signal DATA_Q_WDW : std_logic_vector(WIDTH-1 downto 0);

	signal UNLOAD : std_logic;

	signal DATA_I_XFORM : std_logic_vector(WIDTH-1 downto 0);
	signal DATA_Q_XFORM : std_logic_vector(WIDTH-1 downto 0);

	signal ENd1 : std_logic := '0';
	signal ENd2 : std_logic := '0';
begin
	Inst_window_fn: window_fn
generic map(
			IN_WIDTH => 14,
			OUT_WIDTH => WIDTH
	)
	PORT MAP(
		DATA_I => DATA_I,
		DATA_Q => DATA_Q,
		CLK_FB => CLK_FB,
		RST => RST,
		EN => ENd2,
		OUT_I => DATA_I_WDW,
		OUT_Q => DATA_Q_WDW
	);

	Inst_fft_controller: fft_controller
	generic map(
			WIDTH => WIDTH
	)
	PORT MAP(
		DATA_I => DATA_I_WDW,
		DATA_Q => DATA_Q_WDW,
		CLK_FB => CLK_FB,
		RST => RST,
		EN => EN,
		DATA_RDY => UNLOAD,
		OUT_I => DATA_I_XFORM,
		OUT_Q => DATA_Q_XFORM
	);

	Inst_mag_cordic : mag_cordic PORT MAP (
		x_in => DATA_I_XFORM,
		y_in => DATA_Q_XFORM,
		nd => UNLOAD,
		x_out => OUT_I,
		rdy => DATA_RDY,
		clk => CLK_FB,
		sclr => '0'
	);

	process (CLK_FB)
	begin
		ENd2 <= ENd1;
		ENd1 <= EN;
	end process;

end Behavioral;

