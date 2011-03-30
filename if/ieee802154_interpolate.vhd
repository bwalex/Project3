library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- this module does S&H, not proper interpolation!
entity ieee802154_interpolate is
    generic(
			WIDTH: 	positive:=14
	);
    Port (
		I_in : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		Q_in : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		I_out : out  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		Q_out : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		DRDY : out std_logic;
		CLK_FB	: in  STD_LOGIC; -- 210 MHz clock
		RST : in  STD_LOGIC
	);
end ieee802154_interpolate;

architecture Behavioral of ieee802154_interpolate is
type INTERP_STATES is (RST_STATE, S1, S2 );
signal STATE : INTERP_STATES;
signal I_out_i : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal Q_out_i : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal DRDYi : STD_LOGIC;
begin

process (CLK_FB, RST)
begin
	if RST='0' then
		STATE <= RST_STATE;
	elsif rising_edge(CLK_FB) then
		case STATE is
			when RST_STATE =>
				DRDYi <= '0';
				STATE <= S1;
			when S1 =>
				-- Sample
				DRDYi <= '1';
				STATE <= S2;
				I_out_i <= I_in;
				Q_out_i <= Q_in;

			when S2 =>
				-- Hold
				DRDYi <= '1';
				STATE <= S1;

			when others =>
				STATE <= RST_STATE;
		end case;
	end if;
end process;

I_out <= I_out_i;
Q_out <= Q_out_i;

end Behavioral;

