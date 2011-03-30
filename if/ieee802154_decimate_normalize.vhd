library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity ieee802154_decimate_normalize is
    generic(
			IN_WIDTH: 	positive:=14;
			OUT_WIDTH:	positive:=8
	);
    Port (
		I_in : in  STD_LOGIC_VECTOR(IN_WIDTH-1 downto 0);
		Q_in : in  STD_LOGIC_VECTOR (IN_WIDTH-1 downto 0);
		I_out : out  STD_LOGIC_VECTOR (OUT_WIDTH-1 downto 0); -- at 14 MS/s
		Q_out : out  STD_LOGIC_VECTOR (OUT_WIDTH-1 downto 0); -- at 14 MS/s
		DRDY : out std_logic;
		CLK_14 : in STD_LOGIC;
		RST : in  STD_LOGIC
	);
end ieee802154_decimate_normalize;

architecture Behavioral of ieee802154_decimate_normalize is
signal I_OUT_i : STD_LOGIC_VECTOR(OUT_WIDTH-1 downto 0);
signal Q_OUT_i : STD_LOGIC_VECTOR(OUT_WIDTH-1 downto 0);
begin

process (CLK_14, RST)
begin
	if RST='0' then
		I_OUT_i <= (others => '0');
		Q_OUT_i <= (others => '0');
	elsif rising_edge(CLK_14) then
		I_OUT_i <= I_in(IN_WIDTH-1 downto IN_WIDTH-OUT_WIDTH);
		Q_OUT_i <= Q_in(IN_WIDTH-1 downto IN_WIDTH-OUT_WIDTH);
	end if;
end process;

I_out <= I_OUT_i;
Q_out <= Q_OUT_i;

end Behavioral;

