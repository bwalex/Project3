library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MACCv2 is
    generic(A_WIDTH:        positive:=18;
            B_WIDTH:        positive:=18;
            RES_WIDTH:      positive:=48);
    port(   CLK:            in  std_logic;
            A:              in  signed(A_WIDTH-1 downto 0);
            B:              in  signed(B_WIDTH-1 downto 0);

				EN:				 in  std_logic;
            Oper_Load:      in  std_logic;
            Oper_AddSub:    in  std_logic;

            RES:             out signed(RES_WIDTH-1 downto 0)
    );
end MACCv2;

architecture Behavioral of MACCv2 is

    constant P_WIDTH: integer:=A_WIDTH+B_WIDTH;

    signal oper_load0: std_logic:='0';
    signal oper_addsub0: std_logic:='0';

    signal oper_load1: std_logic:='0';
    signal oper_addsub1: std_logic:='0';

	 signal enable : std_logic := '0';
begin

    process (clk)
        variable acc: signed(RES_WIDTH-1 downto 0);
		  variable p1 : signed(P_WIDTH-1 downto 0):=(others=>'0');
		  variable res0: signed(RES_WIDTH-1 downto 0);
    begin
        if rising_edge(clk) then
				enable <= EN;
				if (EN = '1') then

					if (Oper_Load='1') then
						acc := res0;
						if (Oper_AddSub='1') then
							 res0 := acc-A*B;
						else
							 res0 := acc+A*B;
						end if;
					else
						acc := (others=>'0');
						res0 := A*B;
					end if;

					RES <= res0;
				end if;
        end if;


    end process;

	
end architecture;
