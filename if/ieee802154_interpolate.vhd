----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:09 01/13/2011 
-- Design Name: 
-- Module Name:    ieee802154_interpolate - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This is a simple S&H to increase the rate from 105 to 210 MS/s
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ieee802154_interpolate is
    Port (
		I_in : in  SIGNED(13 downto 0);
		Q_in : in  SIGNED (13 downto 0);
		I_out : out  SIGNED(13 downto 0);
		Q_out : out  SIGNED (13 downto 0);
		DRDY : out std_logic;
		CLK_FB	: in  STD_LOGIC; -- 210 MHz clock
		RST : in  STD_LOGIC
	);
end ieee802154_interpolate;

architecture Behavioral of ieee802154_interpolate is
type INTERP_STATES is (RST_STATE, S1, S2 );
signal STATE : INTERP_STATES;
signal I_out_i : SIGNED(13 downto 0);
signal Q_out_i : SIGNED(13 downto 0);
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
		end case;
	end if;
end process;

I_out <= I_out_i;
Q_out <= Q_out_i;

end Behavioral;

