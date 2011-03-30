library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sermax is
    generic(
			A_WIDTH: 	positive:=6;
			IDX_WIDTH:	positive:=4
	);
   port(   
			CLK:			in  std_logic;
			EN:			in  std_logic;
			A:				in  unsigned(A_WIDTH-1 downto 0);

         MAX_VAL:		out unsigned(A_WIDTH-1 downto 0);
			MAX_IDX:		out unsigned(IDX_WIDTH-1 downto 0)
    );
end sermax;

architecture Behavioral of sermax is
begin

    process (clk)
		  variable max : unsigned(A_WIDTH-1 downto 0):=(others=>'0');
		  variable idx: unsigned(IDX_WIDTH-1 downto 0);
		  variable count: unsigned(IDX_WIDTH-1 downto 0);
    begin
        if rising_edge(clk) then
				if (EN = '1') then
					if A > max then
						idx := count;
						max := A;
					end if;
					count := count + 1;
					MAX_VAL <= max;
					MAX_IDX <= idx;
				else
					count := (others => '0');
					max := (others => '0');
					idx := (others => '0');
				end if;
        end if;
    end process;
end architecture;
