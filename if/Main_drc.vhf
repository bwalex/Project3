--------------------------------------------------------------------------------
-- Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 12.1
--  \   \         Application : sch2hdl
--  /   /         Filename : Main_drc.vhf
-- /___/   /\     Timestamp : 10/08/2010 15:12:27
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: D:\Xilinx\12.1\ISE_DS\ISE\bin\nt\unwrapped\sch2hdl.exe -intstyle ise -family virtex4 -flat -suppress -vhdl Main_drc.vhf -w "D:/Documents and Settings/Administrator/Desktop/Project3/if/Main.sch"
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
   port ( as_dsl    : in    std_logic; 
          BUSY      : in    std_logic; 
          clkb      : in    std_logic; 
          EMPTY     : in    std_logic; 
          green2    : out   std_logic; 
          rdl_wr    : out   std_logic; 
          renl_wenl : out   std_logic; 
          rxled     : out   std_logic; 
          ADIO      : inout std_logic_vector (31 downto 0));
   attribute LOC : string ;
   attribute LOC of clkb : signal is "A16";
   attribute LOC of rxled : signal is "D26";
end Main;

architecture BEHAVIORAL of Main is
   component SpartanInterface
      port ( CLK     : in    std_logic; 
             AS_DS   : in    std_logic; 
             EMPTY   : in    std_logic; 
             BUSY    : in    std_logic; 
             ADIO    : inout std_logic_vector (31 downto 0); 
             REN_WEN : out   std_logic; 
             RD_WR   : out   std_logic; 
             TXLED   : out   std_logic; 
             RXLED   : out   std_logic);
   end component;
   
begin
   XLXI_1 : SpartanInterface
      port map (AS_DS=>as_dsl,
                BUSY=>BUSY,
                CLK=>clkb,
                EMPTY=>EMPTY,
                RD_WR=>rdl_wr,
                REN_WEN=>renl_wenl,
                RXLED=>rxled,
                TXLED=>green2,
                ADIO(31 downto 0)=>ADIO(31 downto 0));
   
end BEHAVIORAL;


