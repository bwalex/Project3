


----------------------------------------------------------------------------------
-- Author: 			 Alex Hornung
-- 
-- Create Date:    10:49:10 10/07/2010 
-- Design Name: 	 USB PC Interface Block
-- Module Name:    SpartanInterface - Behavioral 
-- Project Name:   ZigBee Dynamic Spectrum Management
-- Target Devices: Virtex4 xtremeDSP Board
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision:
-- Revision 0.02 - First working prototype
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity SpartanInterface is
	port (
		-- Interface to Spartan:
		CLK		: in	std_logic;
		AS_DS		: in	std_logic;
		EMPTY		: in	std_logic;
		BUSY		: in	std_logic;
		REN_WEN	: out	std_logic;
		RD_WR		: out	std_logic;
		ADIO		: inout	std_logic_vector (31 downto 0);

		-- Misc:
		TXLED		: out std_logic;
		RXLED		: out std_logic;

		-- Interface to FIFO (read):
		FIFO_IN			: in std_logic_vector (31 downto 0);
		FIFO_RD_EN		: out std_logic;
		FIFO_EMPTY		: in std_logic;
		
		-- Interface to FIFO (write):
		FIFO_OUT			: out std_logic_vector (31 downto 0);
		FIFO_WR_EN		: out std_logic;
		FIFO_FULL		: in std_logic
		
	);

end SpartanInterface;


architecture Behavioral of SpartanInterface is
type IFACE_STATES is (IDLE, RD_WAIT, RD_DATA, RD_REG, WR_REG, WAIT_DATACHK, WAIT_ENDTRANS, ADDR_DEC);
signal IF_STATE : IFACE_STATES := IDLE;
signal blink_red : std_logic;
signal blink_green : std_logic;
signal write_performed : std_logic := '0';
signal data_reg : std_logic_vector(31 downto 0);
signal is_addr : std_logic;
-- Address in.
signal ADDRESSi : std_logic_vector (31 downto 0);
signal data_reg_out : std_logic_vector(31 downto 0) := "11011110101011011100000011111111";
signal data_out_reg : std_logic_vector(31 downto 0);
signal fifo_buffer : std_logic_vector(31 downto 0);
-- Delayed versions of busy and empty.
signal EMPTYd1 : std_logic;
signal BUSYd1 : std_logic;

signal WR_REG_WR : std_logic;
signal WR_REG_WRd1 : std_logic;

--signal FIFO_INi : std_logic_vector(31 downto 0);
--signal FIFO_OUTi : std_logic_vector(31 downto 0);

signal FIFO_RD_ENi : std_logic := '0';
signal FIFO_WR_ENi : std_logic := '0';

-- Internal signals wired to Spartan Interface RD_WR and REN_WEN
signal RD_WRi : std_logic;
signal REN_WENi : std_logic;

-- Write in address.
signal ADDRESS_WR : std_logic;

-- Data is in buffer waiting to be processed.
signal DATA_RDY : std_logic;

-- Write data into input register.
signal DATAIN_WR : std_logic;
signal DATAIN_FIFO : std_logic;

begin

-- Delayed versions of empty and busy
process (CLK)
begin
	if rising_edge(CLK) then
		EMPTYd1 <= EMPTY;
		BUSYd1 <= BUSY;
	end if;
end process;	




-- Control for writing address.
ADDRESS_WR <= '1' when (IF_STATE=RD_DATA and is_addr='1') or (IF_STATE=WAIT_DATACHK and is_addr='1') else '0'; 

-- Write new address.
process (CLK)
begin
	if rising_edge(CLK) then
		if ADDRESS_WR='1' then
			ADDRESSi <= data_reg;
		end if;
	end if;
end process;
		

-- Delayed and undelayed versions of register write signal
WR_REG_WR <= '1' when IF_STATE=WR_REG and DATA_RDY='0' and EMPTYd1='0' else '0';
process (CLK)
begin
	if rising_edge(CLK) then
		WR_REG_WRd1 <= WR_REG_WR;
	end if;
end process;	

-- Incoming data signal
DATAIN_WR <= '1' when IF_STATE=RD_WAIT or (WR_REG_WRd1='1') else '0'; --

-- When data is incoming, store the data itself (ADIO)
-- and whether it's an address or not
process (CLK)
begin 
	if rising_edge(CLK) then
		if DATAIN_WR='1' then
			data_reg <= ADIO;
			is_addr <= AS_DS;
		end if;
	end if;
end process;

--
-- FIFO in interface 
DATAIN_FIFO <= '1' when IF_STATE=RD_REG else '0';	

process (CLK)
begin 
	if rising_edge(CLK) then
		if DATAIN_FIFO='1' then
			fifo_buffer <= FIFO_IN;
		end if;
	end if;
end process;



-- Main state machine
process (CLK)
begin
	if rising_edge(CLK) then
		case IF_STATE is
			when IDLE =>
				--RXLED <= '1';
				if EMPTYd1 = '0' then
					-- If REN_WEN and RD_WR are low, then data will be driven
					-- onto the data bus from the interface FPGA on the next
					-- clock edge.
					RD_WRi <= '0';
					REN_WENi <= '0';
					IF_STATE <= RD_WAIT;
				end if;

			when RD_WAIT =>
				RD_WRi <= '1';
				REN_WENi <= '1';
				IF_STATE <= RD_DATA;
				--blink_red <= AS_DS;

			when RD_DATA =>
				RD_WRi <= '1';
				REN_WENi <= '1';
				--blink_red <= is_addr;
				if is_addr = '1' then
					IF_STATE <= ADDR_DEC;
				else
					IF_STATE <= WR_REG;
					DATA_RDY <= '1';
				end if;

			when ADDR_DEC =>
				--blink_red <= ADDRESSi(31);
				if ADDRESSi(31)='0' then
					IF_STATE <= WR_REG;
				else
					IF_STATE <= RD_REG;
					FIFO_RD_ENi <= '1';
				end if;

			-- Check to see if data has already been read.
			-- If it hasn't, read from Spartan.	
			when WR_REG =>
				if DATA_RDY='0' then
					if EMPTYd1='0' then
						RD_WRi <= '0';
						REN_WENi <= '0';
						IF_STATE <= WAIT_DATACHK;
					end if;
				else
					blink_red <= not blink_red;
					FIFO_WR_ENi <= '1';
					DATA_RDY <= '0';
					IF_STATE <= WAIT_DATACHK;
				end if;

			-- Read from register.		
			when RD_REG =>
				RD_WRi <= '1';
				REN_WENi <= '0';
				FIFO_RD_ENi <= '0';
				IF_STATE <= WAIT_DATACHK;

			-- Check to see if there's still data to be processed.
			-- If there is, determine the nature of the data.	
			when WAIT_DATACHK =>
				RD_WRi <= '1';
				REN_WENi <= '1';
				if DATA_RDY='1' then
					if is_addr='1' then
						IF_STATE <= ADDR_DEC;
						DATA_RDY <= '0';
					else
						IF_STATE <= WR_REG;
					end if;
				else
					FIFO_WR_ENi <= '0';
					IF_STATE <= WAIT_ENDTRANS;
				end if;

			when WAIT_ENDTRANS =>
				IF_STATE <= IDLE;
				RD_WRi <= '1';
				REN_WENi <= '1';

			when others =>
				IF_STATE <= IDLE;
		end case;
	end if;
end process;

process (CLK)
begin
	if rising_edge(CLK) then
		blink_green <= FIFO_EMPTY;
		if FIFO_EMPTY='0' then
			-- use first-word fall-through
			data_out_reg <= FIFO_IN;--fifo_buffer;
		else
			data_out_reg <= data_reg_out;
		end if;
	end if;
end process;

ADIO <= data_out_reg when RD_WRi='1' else (others => 'Z');
--ADIO <= data_reg_out when RD_WRi='1' else (others => 'Z');

-- Wire internal signals to external ones
RD_WR <= RD_WRi;
REN_WEN <= REN_WENi;
rxled <= blink_red;
txled <= blink_green;

FIFO_RD_EN <= FIFO_RD_ENi;
FIFO_WR_EN <= FIFO_WR_ENi;

FIFO_OUT <= data_reg;

end Behavioral;

