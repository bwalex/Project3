----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:18:42 01/04/2011 
-- Design Name: 
-- Module Name:    ieee802154_decimate_normalize - Behavioral 
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ieee802154_decimate_normalize is
    Port (
		I_in : in  SIGNED(13 downto 0);
		Q_in : in  SIGNED (13 downto 0);
		I_out : out  SIGNED(7 downto 0); -- at 14 MS/s
		Q_out : out  SIGNED (7 downto 0); -- at 14 MS/s
		DRDY : out std_logic;
		CLK_FB	: in  STD_LOGIC; -- 210 MHz clock
		RST : in  STD_LOGIC
	);
end ieee802154_decimate_normalize;

architecture Behavioral of ieee802154_decimate_normalize is

begin


end Behavioral;

