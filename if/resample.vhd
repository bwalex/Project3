library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity resample is
    generic(
			IN_WIDTH: 	positive:=14;
			OUT_WIDTH:	positive:=8
	);
	port (
		-- Interface to ADCs:
		I_IN	: in  STD_LOGIC_VECTOR (IN_WIDTH-1 downto 0);
		Q_IN	: in  STD_LOGIC_VECTOR (IN_WIDTH-1 downto 0);
		CLK_H	: in  STD_LOGIC;
		CLK_L : in	STD_LOGIC;
		RST	: in  STD_LOGIC;

		-- misc
		DATA_RDY : out STD_LOGIC;
		I_OUT	: out STD_LOGIC_VECTOR (OUT_WIDTH-1 downto 0);
		Q_OUT : out STD_LOGIC_VECTOR (OUT_WIDTH-1 downto 0)
	);
end resample;

architecture Behavioral of resample is
	COMPONENT ieee802154_interpolate
    generic(
		WIDTH: 	positive:=IN_WIDTH
		);
	PORT(
		I_in : IN std_logic_vector(IN_WIDTH-1 downto 0);
		Q_in : IN std_logic_vector(IN_WIDTH-1 downto 0);
		CLK_FB : IN std_logic;
		RST : IN std_logic;          
		I_out : OUT std_logic_vector(IN_WIDTH-1 downto 0);
		Q_out : OUT std_logic_vector(IN_WIDTH-1 downto 0);
		DRDY : OUT std_logic
		);
	END COMPONENT;

	COMPONENT ieee802154_decimate_normalize
    generic(
		IN_WIDTH: 	positive:=IN_WIDTH;
		OUT_WIDTH:	positive:=OUT_WIDTH
		);
	PORT(
		I_in : IN std_logic_vector(IN_WIDTH-1 downto 0);
		Q_in : IN std_logic_vector(IN_WIDTH-1 downto 0);
		CLK_14 : IN std_logic;
		RST : IN std_logic;          
		I_out : OUT std_logic_vector(OUT_WIDTH-1 downto 0);
		Q_out : OUT std_logic_vector(OUT_WIDTH-1 downto 0);
		DRDY : OUT std_logic
		);
	END COMPONENT;

	signal I_int : std_logic_vector(IN_WIDTH-1 downto 0);
	signal Q_int : std_logic_vector(IN_WIDTH-1 downto 0);
begin
	Inst_ieee802154_interpolate: ieee802154_interpolate
	generic MAP (
		WIDTH => IN_WIDTH
	)
	PORT MAP(
		I_in => I_IN,
		Q_in => Q_IN,
		I_out => I_int,
		Q_out => Q_int,
		CLK_FB => CLK_H,
		RST => RST
	);

	Inst_ieee802154_decimate_normalize: ieee802154_decimate_normalize
	generic MAP (
		IN_WIDTH => IN_WIDTH,
		OUT_WIDTH => OUT_WIDTH
	)
	PORT MAP(
		I_in => I_int,
		Q_in => Q_int,
		I_out => I_OUT,
		Q_out => Q_OUT,
		DRDY => DATA_RDY,
		CLK_14 => CLK_L,
		RST => RST
	);
end Behavioral;

