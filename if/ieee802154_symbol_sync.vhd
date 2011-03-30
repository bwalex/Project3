----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:16 02/01/2011 
-- Design Name: 
-- Module Name:    ieee802154_symbol_sync - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;


entity ieee802154_symbol_sync is
end ieee802154_symbol_sync;

architecture Behavioral of ieee802154_symbol_sync is
type SYM_STATES is (RST_STATE, SYNCING);
type CORR_STRUCTURE is ARRAY (0 to 15) of SIGNED(5 downto 0); -- 6 bits wide, 16 entries deep

signal STATE : SYM_STATES;
signal CORR : CORR_STRUCTURE;
begin

--http://www.xilinx.com/itp/3_1i/data/fise/xst/chap02/xst02007.htm
--
--		/*
--		 * According to the 802.15.4-2003 standard:
--		 * The 4 LSBs (b0, b1, b2, b3) of each octet shall
--		 * map into one data symbol, and the 4 MSBs
--		 * b4, b5, b6, b7) of each octet shall map into the
--		 * next data symbol.
--		 */

process(CLK_FB, RST)
begin
	if RST='0' then
		RST_MACC <= '1';
		DRDYi <= '0';
		STATE <= RST_STATE;
		counter <= (others => '0');

	elsif rising_edge(CLK_FB) then
		case STATE is
			when RST_STATE =>
			when others =>
		end case;
	end if;
end process;


end Behavioral;

