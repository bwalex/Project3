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
		ENABLE		: in   STD_LOGIC
	);
end ADC;


architecture Behavioral of ADC is
signal enabled : std_logic := '0';
signal DATAi   : std_logic_vector (31 downto 0);
signal WR_ENi  : std_logic;

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

-- Light led when ADC block is enabled
LED1 <= not enabled;


process (CLK_FB, RST)
begin
	if RST = '0' then
	elsif rising_edge(CLK_FB) then
		if FULL = '1' then
			WR_ENi <= '0';
		elsif enabled = '1' then
			DATAi(13 downto 0) <= ADC1_D;
			DATAi(31 downto 14) <= (others => '0');
			WR_ENi <= '1';
		elsif enabled = '0' then
			WR_ENi <= '0';
		end if;
	end if;
end process;

DATA_OUT <= DATAi;
DATA_OUT_EN <= WR_ENi;

end Behavioral;

