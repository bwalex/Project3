library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ieee802154_receiver is
    Port (
		I_in : in  STD_LOGIC_VECTOR(13 downto 0);
		Q_in : in  STD_LOGIC_VECTOR (13 downto 0);
		OCTET : OUT std_logic_vector(7 downto 0);
		DATA_RDY : OUT std_logic;
		CLK_210	: in  STD_LOGIC; -- 210 MHz clock
		CLK_56	: in  STD_LOGIC; -- 210 MHz clock
		CLK_64	: in  STD_LOGIC; -- 210 MHz clock
		CLK_14	: in	STD_LOGIC;
		RST : in  STD_LOGIC
	);
end ieee802154_receiver;

architecture Behavioral of ieee802154_receiver is

	COMPONENT resample
	PORT(
		I_IN : IN std_logic_vector(13 downto 0);
		Q_IN : IN std_logic_vector(13 downto 0);
		CLK_H : IN std_logic;
		CLK_L : IN std_logic;
		RST : IN std_logic;          
		DATA_RDY : OUT std_logic;
		I_OUT : OUT std_logic_vector(7 downto 0);
		Q_OUT : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT ieee802154_angle
	PORT(
		I : IN SIGNED(7 downto 0);
		Q : IN SIGNED(7 downto 0);
		CLK_FB : IN std_logic;
		RST : IN std_logic;          
		PHI : OUT std_logic_vector(7 downto 0);
		DRDY : OUT std_logic
		);
	END COMPONENT;

	COMPONENT ieee802154_chip_decoder
	PORT(
		PHI : IN SIGNED(7 downto 0);
		DRDY_IN : IN std_logic;
		CLK_FB : IN std_logic;
		RST : IN std_logic;          
		CHIP : OUT std_logic;
		DRDY : OUT std_logic
		);
	END COMPONENT;


	COMPONENT ieee802154_symbol_decoder
	PORT(
		DRDY_IN : IN std_logic;
		CHIP : IN std_logic;
		CLK_FB : IN std_logic;
		CLK_CHIP : IN std_logic;
		RST : IN std_logic;
		SRST : IN std_logic;          
		SYMBOL : OUT std_logic_vector(3 downto 0);
		SYMBOL_CORR : OUT std_logic_vector(5 downto 0);
		DRDY_OUT : OUT std_logic
		);
	END COMPONENT;

	COMPONENT ieee802154_controller
	PORT(
		DRDY_IN : IN std_logic;
		SYM : IN std_logic_vector(3 downto 0);
		CORR : IN std_logic_vector(5 downto 0);
		CLK_FB : IN std_logic;
		CLK_SYM : IN std_logic;
		RST : IN std_logic;          
		OCTET : OUT std_logic_vector(7 downto 0);
		DATA_RDY : OUT std_logic;
		SRST_SYMDEC : OUT std_logic
		);
	END COMPONENT;
	
	
	signal SRSTi : std_logic;
	signal Ires	 : std_logic_vector(7 downto 0);
	signal Qres	 : std_logic_vector(7 downto 0);
	signal PHIi	 : std_logic_vector(7 downto 0);
	signal DRDY_RES : std_logic;
	signal DRDY_ANGLE : std_logic;
	signal DRDY_CHIP : std_logic;
	signal DRDY_SYM : std_logic;
	signal CHIPi : std_logic;
	signal SYMi : std_logic_vector(3 downto 0);
	signal CORRi : std_logic_vector(5 downto 0);
begin
	Inst_resample: resample PORT MAP(
		I_IN => I_in,
		Q_IN => Q_in,
		CLK_H => CLK_210,
		CLK_L => CLK_14,
		RST => RST,
		DATA_RDY => DRDY_RES,
		I_OUT => Ires,
		Q_OUT => Qres
	);

	Inst_ieee802154_angle: ieee802154_angle PORT MAP(
		I => signed(Ires),
		Q => signed(Qres),
		PHI => PHIi,
		DRDY => DRDY_ANGLE,
		CLK_FB => CLK_56,
		RST => RST
	);

	Inst_ieee802154_chip_decoder: ieee802154_chip_decoder PORT MAP(
		PHI => signed(PHIi),
		DRDY_IN => DRDY_ANGLE,
		CHIP => CHIPi,
		CLK_FB => CLK_14,
		RST => RST,
		DRDY => DRDY_CHIP
	);

	Inst_ieee802154_symbol_decoder: ieee802154_symbol_decoder PORT MAP(
		DRDY_IN => DRDY_CHIP,
		CHIP => CHIPi,
		CLK_FB => CLK_64,
		CLK_CHIP => DRDY_CHIP,
		RST => RST,
		SRST => SRSTi,
		SYMBOL => SYMi,
		SYMBOL_CORR => CORRi,
		DRDY_OUT => DRDY_SYM
	);

	Inst_ieee802154_controller: ieee802154_controller PORT MAP(
		DRDY_IN => DRDY_SYM,
		SYM => SYMi,
		CORR => CORRi,
		CLK_FB => CLK_64,
		CLK_SYM => DRDY_SYM,
		RST => RST,
		OCTET => OCTET,
		DATA_RDY => DATA_RDY,
		SRST_SYMDEC => SRSTi
	);
end Behavioral;

