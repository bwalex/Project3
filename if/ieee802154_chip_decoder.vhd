----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:33:24 01/10/2011 
-- Design Name: 
-- Module Name:    ieee802154_chip_decoder - Behavioral 
-- Project Name: 
-- Target Devices: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ieee802154_chip_decoder is
	Port (
		PHI: in STD_LOGIC_VECTOR (7 downto 0);
		DRDY_IN: in STD_LOGIC;
		CHIP : out STD_LOGIC;
		CLK_FB : in STD_LOGIC;
		RST : in STD_LOGIC;
		DRDY : out std_logic
	);
end ieee802154_chip_decoder;

architecture Behavioral of ieee802154_chip_decoder is
signal PHIi : SIGNED (7 downto 0);
signal DRDYi : std_logic;
signal CHIPi : STD_LOGIC;
signal SUM : SIGNED (9 downto 0);
signal SUMo : SIGNED (9 downto 0);
signal count : unsigned(4 downto 0);
begin

process (CLK_FB, RST)
begin
	if RST='0' then
		PHIi <= (others => 0);
	elsif rising_edge(CLK_FB) then
		if DRDY_IN = '1' then
			PHIi <= PHI;
		end if;
	end if;
end process;


process (CLK_FB, RST)
begin
	if RST='0' then
		STATE <= RST_STATE;
	elsif rising_edge(CLK_FB) then
		case STATE is
			when RST_STATE =>
				if DRDY_IN = '1' then
					DRDYi <= '0';
					STATE <= WORK;
				end if;

			when WORK =>
				if count=1 then
					-- Output
					if (SUM > 7) then
						CHIPi <= 0;
					elsif (SUM < -7) then
						CHIPi <= 1;
					else
						CHIPi <= NOT CHIPi;
					end if;
					SUM <= PHIi;
					STATE <= RST_STATE;
					DRDYi <= '1';
					count <= 7;
				else
					SUM <= SUM + PHIi;
					count <= count - 1;
					DRDYi <= '0';
				end if;

			when others =>
				STATE <= RST_STATE;
		end case;
	end if;
end process;

DRDY <= DRDYi;
CHIP <= CHIPi;

end Behavioral;

