----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:14:17 01/19/2011 
-- Design Name: 
-- Module Name:    generic_logger - Behavioral 
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

entity generic_logger is
	Port (
		in1 : in  STD_LOGIC_VECTOR (7 downto 0);
      in2 : in  STD_LOGIC_VECTOR (7 downto 0);
		in3 : in  STD_LOGIC_VECTOR (15 downto 0);
		CLK_FB : in STD_LOGIC;
		RST : in STD_LOGIC;
		EN : in STD_LOGIC;
		DOUT: OUT STD_LOGIC_VECTOR (31 downto 0);
		FULL			: in   STD_LOGIC;
		WR_EN: OUT STD_LOGIC;
		LED1: OUT STD_LOGIC
	);
end generic_logger;

architecture Behavioral of generic_logger is
signal DATAii  : std_logic_vector (31 downto 0);
signal WR_ENi  : std_logic;
signal enabled : std_logic := '0';
signal ledi : std_logic := '1';
begin

process (CLK_FB, RST)
begin
	if RST = '0' then
		enabled <= '0';
		ledi <= '1';
	elsif rising_edge(CLK_FB) then
		enabled <= EN;
		ledi <= not ledi;
	end if;
end process;

-- Light led when ADC block is enabled
-- XXX: red turns on now on enabling the crappy device
-- odds are that the clock is fucked up!
LED1 <= not enabled;
--LED1 <= ledi;

WR_EN <= WR_ENi;

process (CLK_FB, RST)
begin
	if RST = '0' then
	elsif rising_edge(CLK_FB) then
		if FULL = '1' then
			WR_ENi <= '0';
		elsif enabled = '1' then
			DATAii(31 downto 24) <= in1;
			DATAii(7 downto 0) <= in2;
			DATAii(23 downto 8) <= in3;
			WR_ENi <= '1';
		elsif enabled = '0' then
			WR_ENi <= '0';
		end if;
	end if;
end process;

DOUT <= DATAii;
end Behavioral;

