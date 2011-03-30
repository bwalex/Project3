--------------------------------------------------------------------------------
-- Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 12.1
--  \   \         Application : sch2hdl
--  /   /         Filename : Main.vhf
-- /___/   /\     Timestamp : 02/09/2011 14:39:21
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -sympath C:/Users/alex/Documents/ieee802154/ipcore_dir -intstyle ise -family virtex4 -flat -suppress -vhdl C:/Users/alex/Documents/ieee802154/Main.vhf -w C:/Users/alex/Documents/ieee802154/Main.sch
--Design Name: Main
--Device: virtex4
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Main is
   port ( adc1_d      : in    std_logic_vector (13 downto 0); 
          adc2_d      : in    std_logic_vector (13 downto 0); 
          as_dsl      : in    std_logic; 
          BUSY        : in    std_logic; 
          clka        : in    std_logic; 
          clkb        : in    std_logic; 
          CLK1_FB     : in    std_logic; 
          EMPTY       : in    std_logic; 
          RESETl      : in    std_logic; 
          rstl        : in    std_logic; 
          CLK14       : out   std_logic; 
          CONFIG_DONE : out   std_logic; 
          green2      : out   std_logic; 
          rdl_wr      : out   std_logic; 
          red1        : out   std_logic; 
          renl_wenl   : out   std_logic; 
          ADIO        : inout std_logic_vector (31 downto 0));
end Main;

architecture BEHAVIORAL of Main is
   attribute BOX_TYPE   : string ;
   signal CLK56                       : std_logic;
   signal clk64                       : std_logic;
   signal CLK210                      : std_logic;
   signal dout                        : std_logic_vector (31 downto 0);
   signal DRDY_CD                     : std_logic;
   signal DRDY_SD                     : std_logic;
   signal RESETh                      : std_logic;
   signal XLXN_1                      : std_logic;
   signal XLXN_3                      : std_logic;
   signal XLXN_7                      : std_logic;
   signal XLXN_56                     : std_logic_vector (13 downto 0);
   signal XLXN_57                     : std_logic_vector (13 downto 0);
   signal XLXN_74                     : std_logic;
   signal XLXN_75                     : std_logic;
   signal XLXN_76                     : std_logic_vector (31 downto 0);
   signal XLXN_83                     : std_logic_vector (7 downto 0);
   signal XLXN_95                     : std_logic_vector (7 downto 0);
   signal XLXN_98                     : std_logic_vector (15 downto 0);
   signal XLXN_102                    : std_logic_vector (7 downto 0);
   signal XLXN_103                    : std_logic;
   signal XLXN_106                    : std_logic;
   signal XLXN_109                    : std_logic_vector (7 downto 0);
   signal CLK14_DUMMY                 : std_logic;
   signal XLXI_1_FIFO_FULL_openSignal : std_logic;
   signal XLXI_14_in2_openSignal      : std_logic_vector (7 downto 0);
   component SpartanInterface
      port ( RST        : in    std_logic; 
             CLK        : in    std_logic; 
             AS_DS      : in    std_logic; 
             EMPTY      : in    std_logic; 
             BUSY       : in    std_logic; 
             FIFO_EMPTY : in    std_logic; 
             FIFO_FULL  : in    std_logic; 
             FIFO_IN    : in    std_logic_vector (31 downto 0); 
             ADIO       : inout std_logic_vector (31 downto 0); 
             REN_WEN    : out   std_logic; 
             RD_WR      : out   std_logic; 
             TXLED      : out   std_logic; 
             RXLED      : out   std_logic; 
             FIFO_RD_EN : out   std_logic; 
             FIFO_WR_EN : out   std_logic; 
             FIFO_OUT   : out   std_logic_vector (31 downto 0); 
             EN_PERIPH  : out   std_logic);
   end component;
   
   component fifo
      port ( din      : in    std_logic_vector (31 downto 0); 
             wr_en    : in    std_logic; 
             wr_clk   : in    std_logic; 
             rd_en    : in    std_logic; 
             rd_clk   : in    std_logic; 
             dout     : out   std_logic_vector (31 downto 0); 
             full     : out   std_logic; 
             overflow : out   std_logic; 
             empty    : out   std_logic; 
             valid    : out   std_logic);
   end component;
   
   component clock210
      port ( CLKIN_IN   : in    std_logic; 
             RST_IN     : in    std_logic; 
             LOCKED_OUT : out   std_logic; 
             CLK2X_OUT  : out   std_logic; 
             CLKDV_OUT  : out   std_logic; 
             CLK0_OUT   : out   std_logic; 
             CLKFX_OUT  : out   std_logic);
   end component;
   
   component ieee802154_interpolate
      port ( CLK_FB : in    std_logic; 
             RST    : in    std_logic; 
             I_in   : in    std_logic_vector (13 downto 0); 
             Q_in   : in    std_logic_vector (13 downto 0); 
             DRDY   : out   std_logic; 
             I_out  : out   std_logic_vector (13 downto 0); 
             Q_out  : out   std_logic_vector (13 downto 0));
   end component;
   
   component ieee802154_decimate_normalize
      port ( CLK_FB : in    std_logic; 
             CLK_14 : in    std_logic; 
             RST    : in    std_logic; 
             I_in   : in    std_logic_vector (13 downto 0); 
             Q_in   : in    std_logic_vector (13 downto 0); 
             DRDY   : out   std_logic; 
             I_out  : out   std_logic_vector (7 downto 0); 
             Q_out  : out   std_logic_vector (7 downto 0));
   end component;
   
   component generic_logger
      port ( CLK_FB : in    std_logic; 
             RST    : in    std_logic; 
             EN     : in    std_logic; 
             FULL   : in    std_logic; 
             in1    : in    std_logic_vector (7 downto 0); 
             in2    : in    std_logic_vector (7 downto 0); 
             WR_EN  : out   std_logic; 
             LED1   : out   std_logic; 
             DOUT   : out   std_logic_vector (31 downto 0); 
             in3    : in    std_logic_vector (15 downto 0));
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component ieee802154_angle
      port ( CLK_FB : in    std_logic; 
             RST    : in    std_logic; 
             I      : in    std_logic_vector (7 downto 0); 
             Q      : in    std_logic_vector (7 downto 0); 
             DRDY   : out   std_logic; 
             PHI    : out   std_logic_vector (7 downto 0); 
             DEBUG1 : out   std_logic_vector (7 downto 0); 
             DEBUG2 : out   std_logic_vector (7 downto 0); 
             DEBUG3 : out   std_logic_vector (15 downto 0));
   end component;
   
   component ieee802154_chip_decoder
      port ( DRDY_IN : in    std_logic; 
             CLK_FB  : in    std_logic; 
             RST     : in    std_logic; 
             PHI     : in    std_logic_vector (7 downto 0); 
             CHIP    : out   std_logic; 
             DRDY    : out   std_logic; 
             DEBUG1  : out   std_logic_vector (7 downto 0));
   end component;
   
   component ieee802154_symbol_decoder
      port ( DRDY_IN  : in    std_logic; 
             CHIP     : in    std_logic; 
             CLK_FB   : in    std_logic; 
             RST      : in    std_logic; 
             DRDY_OUT : out   std_logic; 
             DEBUG1   : out   std_logic_vector (7 downto 0); 
             SYMBOL   : out   std_logic_vector (3 downto 0));
   end component;
   
   component clock64
      port ( RST_IN          : in    std_logic; 
             CLKIN_IN        : in    std_logic; 
             LOCKED_OUT      : out   std_logic; 
             CLKFX_OUT       : out   std_logic; 
             CLKIN_IBUFG_OUT : out   std_logic; 
             CLK0_OUT        : out   std_logic; 
             CLKFX_OUT1      : out   std_logic);
   end component;
   
begin
   CLK14 <= CLK14_DUMMY;
   XLXI_1 : SpartanInterface
      port map (AS_DS=>as_dsl,
                BUSY=>BUSY,
                CLK=>clkb,
                EMPTY=>EMPTY,
                FIFO_EMPTY=>XLXN_1,
                FIFO_FULL=>XLXI_1_FIFO_FULL_openSignal,
                FIFO_IN(31 downto 0)=>dout(31 downto 0),
                RST=>rstl,
                EN_PERIPH=>XLXN_74,
                FIFO_OUT=>open,
                FIFO_RD_EN=>XLXN_3,
                FIFO_WR_EN=>open,
                RD_WR=>rdl_wr,
                REN_WEN=>renl_wenl,
                RXLED=>open,
                TXLED=>green2,
                ADIO(31 downto 0)=>ADIO(31 downto 0));
   
   XLXI_2 : fifo
      port map (din(31 downto 0)=>XLXN_76(31 downto 0),
                rd_clk=>clkb,
                rd_en=>XLXN_3,
                wr_clk=>DRDY_SD,
                wr_en=>XLXN_75,
                dout(31 downto 0)=>dout(31 downto 0),
                empty=>XLXN_1,
                full=>XLXN_7,
                overflow=>open,
                valid=>open);
   
   XLXI_7 : clock210
      port map (CLKIN_IN=>CLK1_FB,
                RST_IN=>RESETh,
                CLKDV_OUT=>CLK14_DUMMY,
                CLKFX_OUT=>CLK56,
                CLK0_OUT=>open,
                CLK2X_OUT=>CLK210,
                LOCKED_OUT=>open);
   
   XLXI_9 : ieee802154_interpolate
      port map (CLK_FB=>CLK210,
                I_in(13 downto 0)=>adc1_d(13 downto 0),
                Q_in(13 downto 0)=>adc2_d(13 downto 0),
                RST=>RESETl,
                DRDY=>open,
                I_out(13 downto 0)=>XLXN_56(13 downto 0),
                Q_out(13 downto 0)=>XLXN_57(13 downto 0));
   
   XLXI_10 : ieee802154_decimate_normalize
      port map (CLK_FB=>CLK1_FB,
                CLK_14=>CLK14_DUMMY,
                I_in(13 downto 0)=>XLXN_56(13 downto 0),
                Q_in(13 downto 0)=>XLXN_57(13 downto 0),
                RST=>RESETl,
                DRDY=>CONFIG_DONE,
                I_out(7 downto 0)=>XLXN_95(7 downto 0),
                Q_out(7 downto 0)=>XLXN_83(7 downto 0));
   
   XLXI_14 : generic_logger
      port map (CLK_FB=>DRDY_SD,
                EN=>XLXN_74,
                FULL=>XLXN_7,
                in1(7 downto 0)=>XLXN_109(7 downto 0),
                in2(7 downto 0)=>XLXI_14_in2_openSignal(7 downto 0),
                in3(15 downto 0)=>XLXN_98(15 downto 0),
                RST=>RESETl,
                DOUT(31 downto 0)=>XLXN_76(31 downto 0),
                LED1=>red1,
                WR_EN=>XLXN_75);
   
   XLXI_15 : INV
      port map (I=>RESETl,
                O=>RESETh);
   
   XLXI_16 : ieee802154_angle
      port map (CLK_FB=>CLK56,
                I(7 downto 0)=>XLXN_95(7 downto 0),
                Q(7 downto 0)=>XLXN_83(7 downto 0),
                RST=>RESETl,
                DEBUG1=>open,
                DEBUG2=>open,
                DEBUG3(15 downto 0)=>XLXN_98(15 downto 0),
                DRDY=>XLXN_103,
                PHI(7 downto 0)=>XLXN_102(7 downto 0));
   
   XLXI_17 : ieee802154_chip_decoder
      port map (CLK_FB=>CLK14_DUMMY,
                DRDY_IN=>XLXN_103,
                PHI(7 downto 0)=>XLXN_102(7 downto 0),
                RST=>RESETl,
                CHIP=>XLXN_106,
                DEBUG1=>open,
                DRDY=>DRDY_CD);
   
   XLXI_18 : ieee802154_symbol_decoder
      port map (CHIP=>XLXN_106,
                CLK_FB=>clk64,
                DRDY_IN=>DRDY_CD,
                RST=>RESETl,
                DEBUG1(7 downto 0)=>XLXN_109(7 downto 0),
                DRDY_OUT=>DRDY_SD,
                SYMBOL=>open);
   
   XLXI_19 : clock64
      port map (CLKIN_IN=>clka,
                RST_IN=>RESETh,
                CLKFX_OUT=>open,
                CLKFX_OUT1=>clk64,
                CLKIN_IBUFG_OUT=>open,
                CLK0_OUT=>open,
                LOCKED_OUT=>open);
   
end BEHAVIORAL;


