library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SpartanInterface is
	port (
		-- Interface to Spartan:
		RST		: in	std_logic;
		CLK_FB		: in	std_logic;
		AS_DS		: in	std_logic;
		EMPTY		: in	std_logic;
		BUSY		: in	std_logic;
		RE_WE	: out	std_logic;
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
		FIFO_FULL		: in std_logic;
		
		-- Misc interface:
		EN_PERIPH		: out std_logic
	);

end SpartanInterface;


architecture Behavioral of SpartanInterface is
type IFACE_STATES is (RST_STATE, IDLE, RD_WAIT, IF_READ, D_READ, D_WRITE, WAIT_DATA, WAIT_END, ADDR_DEC);
signal IF_STATE : IFACE_STATES;
signal blink_red : std_logic;
signal blink_green : std_logic;
--signal write_performed : std_logic := '0';
signal data_reg : std_logic_vector(31 downto 0);
signal is_addr : std_logic;
-- Address in.
signal ADDRESSi : std_logic_vector (31 downto 0);
--signal data_reg_out : std_logic_vector(31 downto 0) := "11011110101011011100000011111111";
signal data_out_reg : std_logic_vector(31 downto 0);
--signal fifo_buffer : std_logic_vector(31 downto 0);
signal tmp_reg : std_logic_vector(31 downto 0);

signal req_count : unsigned(15 downto 0);

-- Delayed versions of busy and empty.
signal EMPTYd1 : std_logic;
signal BUSYd1 : std_logic;

signal D_WRITE_WR : std_logic;
signal D_WRITE_WRd1 : std_logic;

--signal FIFO_INi : std_logic_vector(31 downto 0);
--signal FIFO_OUTi : std_logic_vector(31 downto 0);

signal FIFO_RD_ENi : std_logic := '0';
--signal FIFO_WR_ENi : std_logic := '0';

-- Internal signals wired to Spartan Interface RD_WR and RE_WE
signal RD_WRi : std_logic;
signal RE_WEi : std_logic;

-- Write in address.
signal ADDRESS_WR : std_logic;

-- Data is in buffer waiting to be processed.
signal DATA_RDY : std_logic;

-- Write data into input register.
signal DATAIN_WR : std_logic;
--signal DATAIN_FIFO : std_logic;

begin

-- Delayed versions of empty and busy
process (CLK_FB, RST)
begin
	if RST='1' then
		EMPTYd1 <= '1';
		BUSYd1 <= '1';
	elsif rising_edge(CLK_FB) then
		EMPTYd1 <= EMPTY;
		BUSYd1 <= BUSY;
	end if;
end process;	




-- Control for writing address.
ADDRESS_WR <= '1' when (IF_STATE=IF_READ and is_addr='1') or (IF_STATE=WAIT_DATA and is_addr='1') else '0'; 

-- Write new address.
process (CLK_FB, RST)
begin
	if RST='1' then
		ADDRESSi <= (others => '0');
	elsif rising_edge(CLK_FB) then
		if ADDRESS_WR='1' then
			ADDRESSi <= data_reg;
		end if;
	end if;
end process;
		

-- Delayed and undelayed versions of register write signal
D_WRITE_WR <= '1' when IF_STATE=D_WRITE and DATA_RDY='0' and EMPTYd1='0' else '0';
process (CLK_FB, RST)
begin
	if RST='1' then
		D_WRITE_WRd1 <= '0';
	elsif rising_edge(CLK_FB) then
		D_WRITE_WRd1 <= D_WRITE_WR;
	end if;
end process;	

-- Incoming data signal
DATAIN_WR <= '1' when IF_STATE=RD_WAIT or (D_WRITE_WRd1='1') else '0'; --

-- When data is incoming, store the data itself (ADIO)
-- and whether it's an address or not
process (CLK_FB, RST)
begin 
	if RST='1' then
		is_addr <= '0';
		data_reg <= (others => '0');
		tmp_reg <= (others => '0');
	elsif rising_edge(CLK_FB) then
		if DATAIN_WR='1' then
			data_reg <= ADIO;
			is_addr <= AS_DS;
			if (D_WRITE_WRd1='1') then
				tmp_reg <= ADIO;
			end if;
		end if;
	end if;
end process;

--
-- FIFO in interface 
--DATAIN_FIFO <= '1' when IF_STATE=D_READ else '0';	
--
--process (CLK_FB, RST)
--begin
--	if RST='1' then
--		fifo_buffer <= (others => '0');
--	elsif rising_edge(CLK_FB) then
--		if DATAIN_FIFO='1' then
--			fifo_buffer <= FIFO_IN;
--		end if;
--	end if;
--end process;



-- Main state machine
process (CLK_FB, RST)
begin
	if RST='1' then
		IF_STATE <= RST_STATE;
		RD_WRi <= '1';
		RE_WEi <= '1';
		DATA_RDY <= '0';
	elsif rising_edge(CLK_FB) then
		case IF_STATE is
			when RST_STATE =>
				IF_STATE <= IDLE;

			when IDLE =>
				--RXLED <= '1';
				if EMPTYd1 = '0' then
					-- If RE_WE and RD_WR are low, then data will be driven
					-- onto the data bus from the interface FPGA on the next
					-- clock edge.
					RD_WRi <= '0';
					RE_WEi <= '0';
					IF_STATE <= RD_WAIT;
				end if;

			when RD_WAIT =>
				RD_WRi <= '1';
				RE_WEi <= '1';
				IF_STATE <= IF_READ;
				--blink_red <= AS_DS;

			when IF_READ =>
				RD_WRi <= '1';
				RE_WEi <= '1';
				--blink_red <= is_addr;
				if is_addr = '1' then
					IF_STATE <= ADDR_DEC;
				else
					IF_STATE <= D_WRITE;
					DATA_RDY <= '1';
				end if;

			when ADDR_DEC =>
				--blink_green <= ADDRESSi(31);
				if ADDRESSi(31)='0' then
					IF_STATE <= D_WRITE;
					--blink_green <= not blink_green;
				else
					IF_STATE <= D_READ;
					req_count <= unsigned(ADDRESSi(15 downto 0));
					--blink_green <= '0';
					--DATA_RDY <= '0';
					FIFO_RD_ENi <= '1';
				end if;

			-- Check to see if data has already been read.
			-- If it hasn't, read from Spartan.	
			when D_WRITE =>
				if DATA_RDY='0' then
					if EMPTYd1='0' then
						RD_WRi <= '0';
						RE_WEi <= '0';
						IF_STATE <= WAIT_DATA;
					end if;
				else
					--FIFO_WR_ENi <= '1';
					DATA_RDY <= '0';
					IF_STATE <= WAIT_DATA;
				end if;

			-- Read from register.
			when D_READ =>
				RD_WRi <= '1';
				RE_WEi <= '0';
				if (req_count = 1 or BUSYd1 = '1') then
					--blink_green <= '1';
					FIFO_RD_ENi <= '0';
					IF_STATE <= WAIT_DATA;
				else
					req_count <= req_count - 1;
					IF_STATE <= D_READ;
					FIFO_RD_ENi <= '1';
				end if;

			-- Check to see if there's still data to be processed.
			-- If there is, determine the nature of the data.	
			when WAIT_DATA =>
				RD_WRi <= '1';
				RE_WEi <= '1';
				if DATA_RDY='1' then
					if is_addr='1' then
						IF_STATE <= ADDR_DEC;
						DATA_RDY <= '0';
					else
						--blink_red <= not blink_red;
						IF_STATE <= D_WRITE;
					end if;
				else
					--FIFO_WR_ENi <= '0';
					IF_STATE <= WAIT_END;
				end if;

			when WAIT_END =>
				IF_STATE <= IDLE;
				RD_WRi <= '1';
				RE_WEi <= '1';

			when others =>
				IF_STATE <= RST_STATE;
				RD_WRi <= '1';
				RE_WEi <= '1';
				DATA_RDY <= '0';
		end case;
	end if;
end process;

process (CLK_FB, RST)
begin
	if RST='1' then
		data_out_reg <= (others => '0');
	elsif rising_edge(CLK_FB) then
		blink_green <= FIFO_EMPTY;
		if FIFO_EMPTY='0' then
			-- use first-word fall-through
			data_out_reg <= FIFO_IN;--fifo_buffer;
		else
			data_out_reg <= (others => '1');
		end if;
	end if;
end process;

ADIO <= data_out_reg when RD_WRi='1' else (others => 'Z');

EN_PERIPH <= tmp_reg(0);

-- Wire internal signals to external ones
RD_WR <= RD_WRi;
RE_WE <= RE_WEi;
rxled <= blink_red;
txled <= blink_green;

FIFO_RD_EN <= FIFO_RD_ENi;
--FIFO_WR_EN <= FIFO_WR_ENi;

FIFO_OUT <= data_reg;

end Behavioral;

