<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="virtex4" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="as_dsl" />
        <signal name="EMPTY" />
        <signal name="BUSY" />
        <signal name="renl_wenl" />
        <signal name="rdl_wr" />
        <signal name="green2" />
        <signal name="ADIO(31:0)" />
        <signal name="XLXN_1" />
        <signal name="XLXN_3" />
        <signal name="dout(31:0)" />
        <signal name="clkb" />
        <signal name="rstl" />
        <signal name="CLK1_FB" />
        <signal name="XLXN_7" />
        <signal name="CLK210" />
        <signal name="adc1_d(13:0)" />
        <signal name="adc2_d(13:0)" />
        <signal name="XLXN_56(13:0)" />
        <signal name="XLXN_57(13:0)" />
        <signal name="CLK14" />
        <signal name="CLK56" />
        <signal name="RESETl" />
        <signal name="red1" />
        <signal name="XLXN_74" />
        <signal name="XLXN_75" />
        <signal name="XLXN_76(31:0)" />
        <signal name="CONFIG_DONE" />
        <signal name="RESETh" />
        <signal name="XLXN_83(7:0)" />
        <signal name="XLXN_95(7:0)" />
        <signal name="XLXN_98(15:0)" />
        <signal name="XLXN_102(7:0)" />
        <signal name="XLXN_103" />
        <signal name="DRDY_CD" />
        <signal name="XLXN_106" />
        <signal name="DRDY_SD" />
        <signal name="XLXN_109(7:0)" />
        <signal name="clka" />
        <signal name="clk64" />
        <port polarity="Input" name="as_dsl" />
        <port polarity="Input" name="EMPTY" />
        <port polarity="Input" name="BUSY" />
        <port polarity="Output" name="renl_wenl" />
        <port polarity="Output" name="rdl_wr" />
        <port polarity="Output" name="green2" />
        <port polarity="BiDirectional" name="ADIO(31:0)" />
        <port polarity="Input" name="clkb" />
        <port polarity="Input" name="rstl" />
        <port polarity="Input" name="CLK1_FB" />
        <port polarity="Input" name="adc1_d(13:0)" />
        <port polarity="Input" name="adc2_d(13:0)" />
        <port polarity="Output" name="CLK14" />
        <port polarity="Input" name="RESETl" />
        <port polarity="Output" name="red1" />
        <port polarity="Output" name="CONFIG_DONE" />
        <port polarity="Input" name="clka" />
        <blockdef name="SpartanInterface">
            <timestamp>2010-10-19T11:2:55</timestamp>
            <line x2="384" y1="352" y2="352" x1="320" />
            <line x2="0" y1="288" y2="288" x1="64" />
            <rect width="64" x="0" y="212" height="24" />
            <line x2="0" y1="224" y2="224" x1="64" />
            <rect width="64" x="320" y="212" height="24" />
            <line x2="384" y1="224" y2="224" x1="320" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="96" y2="96" x1="64" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="384" y1="96" y2="96" x1="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-208" y2="-208" x1="64" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="-48" y2="-48" x1="64" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-320" height="704" />
        </blockdef>
        <blockdef name="fifo">
            <timestamp>2011-2-9T12:17:8</timestamp>
            <rect width="512" x="32" y="32" height="736" />
            <line x2="32" y1="80" y2="80" style="linewidth:W" x1="0" />
            <line x2="32" y1="144" y2="144" x1="0" />
            <line x2="32" y1="176" y2="176" x1="0" />
            <line x2="32" y1="240" y2="240" x1="0" />
            <line x2="32" y1="272" y2="272" x1="0" />
            <line x2="544" y1="80" y2="80" style="linewidth:W" x1="576" />
            <line x2="544" y1="208" y2="208" x1="576" />
            <line x2="544" y1="336" y2="336" x1="576" />
            <line x2="544" y1="432" y2="432" x1="576" />
            <line x2="544" y1="528" y2="528" x1="576" />
        </blockdef>
        <blockdef name="clock210">
            <timestamp>2011-2-9T11:18:13</timestamp>
            <line x2="464" y1="96" y2="96" x1="400" />
            <line x2="464" y1="32" y2="32" x1="400" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="464" y1="-224" y2="-224" x1="400" />
            <line x2="464" y1="-160" y2="-160" x1="400" />
            <line x2="464" y1="-32" y2="-32" x1="400" />
            <rect width="336" x="64" y="-256" height="448" />
        </blockdef>
        <blockdef name="ieee802154_interpolate">
            <timestamp>2011-1-19T14:6:56</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <rect width="64" x="320" y="-140" height="24" />
            <line x2="384" y1="-128" y2="-128" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="ieee802154_decimate_normalize">
            <timestamp>2011-1-19T14:7:49</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="generic_logger">
            <timestamp>2011-1-25T11:37:16</timestamp>
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <line x2="384" y1="-192" y2="-192" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-384" height="448" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="ieee802154_angle">
            <timestamp>2011-2-9T12:24:4</timestamp>
            <rect width="64" x="320" y="148" height="24" />
            <line x2="384" y1="160" y2="160" x1="320" />
            <rect width="64" x="320" y="20" height="24" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <rect width="64" x="320" y="84" height="24" />
            <line x2="384" y1="96" y2="96" x1="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <rect width="64" x="320" y="-140" height="24" />
            <line x2="384" y1="-128" y2="-128" x1="320" />
            <rect width="256" x="64" y="-320" height="512" />
        </blockdef>
        <blockdef name="ieee802154_chip_decoder">
            <timestamp>2011-2-9T12:50:40</timestamp>
            <rect width="64" x="320" y="20" height="24" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-256" height="320" />
        </blockdef>
        <blockdef name="ieee802154_symbol_decoder">
            <timestamp>2011-2-9T13:31:49</timestamp>
            <rect width="64" x="320" y="212" height="24" />
            <line x2="384" y1="224" y2="224" x1="320" />
            <rect width="64" x="320" y="148" height="24" />
            <line x2="384" y1="160" y2="160" x1="320" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="256" x="64" y="-256" height="512" />
        </blockdef>
        <blockdef name="clock64">
            <timestamp>2011-2-9T14:34:28</timestamp>
            <line x2="464" y1="32" y2="32" x1="400" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="464" y1="-224" y2="-224" x1="400" />
            <line x2="464" y1="-160" y2="-160" x1="400" />
            <line x2="464" y1="-96" y2="-96" x1="400" />
            <line x2="464" y1="-32" y2="-32" x1="400" />
            <rect width="336" x="64" y="-256" height="320" />
        </blockdef>
        <block symbolname="SpartanInterface" name="XLXI_1">
            <blockpin signalname="rstl" name="RST" />
            <blockpin signalname="clkb" name="CLK" />
            <blockpin signalname="as_dsl" name="AS_DS" />
            <blockpin signalname="EMPTY" name="EMPTY" />
            <blockpin signalname="BUSY" name="BUSY" />
            <blockpin signalname="XLXN_1" name="FIFO_EMPTY" />
            <blockpin name="FIFO_FULL" />
            <blockpin signalname="dout(31:0)" name="FIFO_IN(31:0)" />
            <blockpin signalname="ADIO(31:0)" name="ADIO(31:0)" />
            <blockpin signalname="renl_wenl" name="REN_WEN" />
            <blockpin signalname="rdl_wr" name="RD_WR" />
            <blockpin signalname="green2" name="TXLED" />
            <blockpin name="RXLED" />
            <blockpin signalname="XLXN_3" name="FIFO_RD_EN" />
            <blockpin name="FIFO_WR_EN" />
            <blockpin name="FIFO_OUT(31:0)" />
            <blockpin signalname="XLXN_74" name="EN_PERIPH" />
        </block>
        <block symbolname="fifo" name="XLXI_2">
            <blockpin signalname="XLXN_76(31:0)" name="din(31:0)" />
            <blockpin signalname="XLXN_75" name="wr_en" />
            <blockpin signalname="DRDY_SD" name="wr_clk" />
            <blockpin signalname="XLXN_3" name="rd_en" />
            <blockpin signalname="clkb" name="rd_clk" />
            <blockpin signalname="dout(31:0)" name="dout(31:0)" />
            <blockpin signalname="XLXN_7" name="full" />
            <blockpin name="overflow" />
            <blockpin signalname="XLXN_1" name="empty" />
            <blockpin name="valid" />
        </block>
        <block symbolname="clock210" name="XLXI_7">
            <blockpin signalname="CLK1_FB" name="CLKIN_IN" />
            <blockpin signalname="RESETh" name="RST_IN" />
            <blockpin name="LOCKED_OUT" />
            <blockpin signalname="CLK210" name="CLK2X_OUT" />
            <blockpin signalname="CLK14" name="CLKDV_OUT" />
            <blockpin name="CLK0_OUT" />
            <blockpin signalname="CLK56" name="CLKFX_OUT" />
        </block>
        <block symbolname="ieee802154_interpolate" name="XLXI_9">
            <blockpin signalname="CLK210" name="CLK_FB" />
            <blockpin signalname="RESETl" name="RST" />
            <blockpin signalname="adc1_d(13:0)" name="I_in(13:0)" />
            <blockpin signalname="adc2_d(13:0)" name="Q_in(13:0)" />
            <blockpin name="DRDY" />
            <blockpin signalname="XLXN_56(13:0)" name="I_out(13:0)" />
            <blockpin signalname="XLXN_57(13:0)" name="Q_out(13:0)" />
        </block>
        <block symbolname="ieee802154_decimate_normalize" name="XLXI_10">
            <blockpin signalname="CLK1_FB" name="CLK_FB" />
            <blockpin signalname="CLK14" name="CLK_14" />
            <blockpin signalname="RESETl" name="RST" />
            <blockpin signalname="XLXN_56(13:0)" name="I_in(13:0)" />
            <blockpin signalname="XLXN_57(13:0)" name="Q_in(13:0)" />
            <blockpin signalname="CONFIG_DONE" name="DRDY" />
            <blockpin signalname="XLXN_95(7:0)" name="I_out(7:0)" />
            <blockpin signalname="XLXN_83(7:0)" name="Q_out(7:0)" />
        </block>
        <block symbolname="generic_logger" name="XLXI_14">
            <blockpin signalname="DRDY_SD" name="CLK_FB" />
            <blockpin signalname="RESETl" name="RST" />
            <blockpin signalname="XLXN_74" name="EN" />
            <blockpin signalname="XLXN_7" name="FULL" />
            <blockpin signalname="XLXN_109(7:0)" name="in1(7:0)" />
            <blockpin name="in2(7:0)" />
            <blockpin signalname="XLXN_75" name="WR_EN" />
            <blockpin signalname="red1" name="LED1" />
            <blockpin signalname="XLXN_76(31:0)" name="DOUT(31:0)" />
            <blockpin signalname="XLXN_98(15:0)" name="in3(15:0)" />
        </block>
        <block symbolname="inv" name="XLXI_15">
            <blockpin signalname="RESETl" name="I" />
            <blockpin signalname="RESETh" name="O" />
        </block>
        <block symbolname="ieee802154_angle" name="XLXI_16">
            <blockpin signalname="CLK56" name="CLK_FB" />
            <blockpin signalname="RESETl" name="RST" />
            <blockpin signalname="XLXN_95(7:0)" name="I(7:0)" />
            <blockpin signalname="XLXN_83(7:0)" name="Q(7:0)" />
            <blockpin signalname="XLXN_103" name="DRDY" />
            <blockpin signalname="XLXN_102(7:0)" name="PHI(7:0)" />
            <blockpin name="DEBUG1(7:0)" />
            <blockpin name="DEBUG2(7:0)" />
            <blockpin signalname="XLXN_98(15:0)" name="DEBUG3(15:0)" />
        </block>
        <block symbolname="ieee802154_chip_decoder" name="XLXI_17">
            <blockpin signalname="XLXN_103" name="DRDY_IN" />
            <blockpin signalname="CLK14" name="CLK_FB" />
            <blockpin signalname="RESETl" name="RST" />
            <blockpin signalname="XLXN_102(7:0)" name="PHI(7:0)" />
            <blockpin signalname="XLXN_106" name="CHIP" />
            <blockpin signalname="DRDY_CD" name="DRDY" />
            <blockpin name="DEBUG1(7:0)" />
        </block>
        <block symbolname="ieee802154_symbol_decoder" name="XLXI_18">
            <blockpin signalname="DRDY_CD" name="DRDY_IN" />
            <blockpin signalname="XLXN_106" name="CHIP" />
            <blockpin signalname="clk64" name="CLK_FB" />
            <blockpin signalname="RESETl" name="RST" />
            <blockpin signalname="DRDY_SD" name="DRDY_OUT" />
            <blockpin signalname="XLXN_109(7:0)" name="DEBUG1(7:0)" />
            <blockpin name="SYMBOL(3:0)" />
        </block>
        <block symbolname="clock64" name="XLXI_19">
            <blockpin signalname="RESETh" name="RST_IN" />
            <blockpin signalname="clka" name="CLKIN_IN" />
            <blockpin name="LOCKED_OUT" />
            <blockpin name="CLKFX_OUT" />
            <blockpin name="CLKIN_IBUFG_OUT" />
            <blockpin name="CLK0_OUT" />
            <blockpin signalname="clk64" name="CLKFX_OUT1" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="5382" height="7609">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <branch name="as_dsl">
            <wire x2="1328" y1="1248" y2="1248" x1="1296" />
        </branch>
        <iomarker fontsize="28" x="1296" y="1248" name="as_dsl" orien="R180" />
        <branch name="EMPTY">
            <wire x2="1328" y1="1328" y2="1328" x1="1296" />
        </branch>
        <iomarker fontsize="28" x="1296" y="1328" name="EMPTY" orien="R180" />
        <branch name="BUSY">
            <wire x2="1328" y1="1408" y2="1408" x1="1296" />
        </branch>
        <iomarker fontsize="28" x="1296" y="1408" name="BUSY" orien="R180" />
        <branch name="renl_wenl">
            <wire x2="1744" y1="1168" y2="1168" x1="1712" />
        </branch>
        <iomarker fontsize="28" x="1744" y="1168" name="renl_wenl" orien="R0" />
        <branch name="rdl_wr">
            <wire x2="1744" y1="1232" y2="1232" x1="1712" />
        </branch>
        <iomarker fontsize="28" x="1744" y="1232" name="rdl_wr" orien="R0" />
        <branch name="green2">
            <wire x2="1776" y1="1296" y2="1296" x1="1712" />
        </branch>
        <branch name="ADIO(31:0)">
            <wire x2="1744" y1="1424" y2="1424" x1="1712" />
        </branch>
        <iomarker fontsize="28" x="1744" y="1424" name="ADIO(31:0)" orien="R0" />
        <instance x="1328" y="1456" name="XLXI_1" orien="R0">
        </instance>
        <iomarker fontsize="28" x="1776" y="1296" name="green2" orien="R0" />
        <branch name="XLXN_1">
            <wire x2="1136" y1="1072" y2="1488" x1="1136" />
            <wire x2="1328" y1="1488" y2="1488" x1="1136" />
            <wire x2="2944" y1="1072" y2="1072" x1="1136" />
            <wire x2="2944" y1="1072" y2="2192" x1="2944" />
            <wire x2="2944" y1="2192" y2="2192" x1="2896" />
        </branch>
        <branch name="dout(31:0)">
            <wire x2="1104" y1="1056" y2="1680" x1="1104" />
            <wire x2="1328" y1="1680" y2="1680" x1="1104" />
            <wire x2="2960" y1="1056" y2="1056" x1="1104" />
            <wire x2="2960" y1="1056" y2="1840" x1="2960" />
            <wire x2="2960" y1="1840" y2="1840" x1="2896" />
        </branch>
        <branch name="clkb">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="885" y="1168" type="branch" />
            <wire x2="885" y1="1168" y2="1168" x1="480" />
            <wire x2="1328" y1="1168" y2="1168" x1="885" />
        </branch>
        <iomarker fontsize="28" x="480" y="1168" name="clkb" orien="R180" />
        <branch name="rstl">
            <wire x2="1328" y1="1744" y2="1744" x1="1120" />
        </branch>
        <iomarker fontsize="28" x="1120" y="1744" name="rstl" orien="R180" />
        <branch name="CLK1_FB">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="526" y="2192" type="branch" />
            <wire x2="526" y1="2192" y2="2192" x1="400" />
            <wire x2="672" y1="2192" y2="2192" x1="526" />
        </branch>
        <iomarker fontsize="28" x="400" y="2192" name="CLK1_FB" orien="R180" />
        <branch name="XLXN_3">
            <wire x2="2016" y1="1488" y2="1488" x1="1712" />
            <wire x2="2016" y1="1488" y2="2000" x1="2016" />
            <wire x2="2320" y1="2000" y2="2000" x1="2016" />
        </branch>
        <instance x="2320" y="1760" name="XLXI_2" orien="R0">
        </instance>
        <branch name="CLK1_FB">
            <attrtext style="alignment:SOFT-TCENTER" attrname="Name" x="480" y="3888" type="branch" />
            <wire x2="480" y1="3888" y2="3888" x1="256" />
            <wire x2="608" y1="3872" y2="3872" x1="480" />
            <wire x2="480" y1="3872" y2="3888" x1="480" />
        </branch>
        <instance x="624" y="4448" name="XLXI_7" orien="R0">
        </instance>
        <branch name="CLK1_FB">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="480" y="4416" type="branch" />
            <wire x2="480" y1="4416" y2="4416" x1="320" />
            <wire x2="624" y1="4416" y2="4416" x1="480" />
        </branch>
        <branch name="CLK210">
            <attrtext style="alignment:SOFT-TVCENTER" attrname="Name" x="1280" y="4368" type="branch" />
            <wire x2="1280" y1="4288" y2="4288" x1="1088" />
            <wire x2="1280" y1="4288" y2="4368" x1="1280" />
            <wire x2="1280" y1="4368" y2="4592" x1="1280" />
            <wire x2="1488" y1="4592" y2="4592" x1="1280" />
        </branch>
        <branch name="XLXN_7">
            <wire x2="624" y1="2320" y2="2624" x1="624" />
            <wire x2="2976" y1="2624" y2="2624" x1="624" />
            <wire x2="672" y1="2320" y2="2320" x1="624" />
            <wire x2="976" y1="2320" y2="2320" x1="672" />
            <wire x2="976" y1="2224" y2="2320" x1="976" />
            <wire x2="1296" y1="2224" y2="2224" x1="976" />
            <wire x2="2976" y1="1968" y2="1968" x1="2896" />
            <wire x2="2976" y1="1968" y2="2624" x1="2976" />
        </branch>
        <instance x="624" y="3120" name="XLXI_9" orien="R0">
        </instance>
        <instance x="1408" y="3184" name="XLXI_10" orien="R0">
        </instance>
        <branch name="CLK210">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="528" y="2896" type="branch" />
            <wire x2="528" y1="2896" y2="2896" x1="416" />
            <wire x2="624" y1="2896" y2="2896" x1="528" />
        </branch>
        <branch name="adc1_d(13:0)">
            <wire x2="624" y1="3024" y2="3024" x1="256" />
        </branch>
        <iomarker fontsize="28" x="256" y="3024" name="adc1_d(13:0)" orien="R180" />
        <branch name="adc2_d(13:0)">
            <wire x2="624" y1="3088" y2="3088" x1="320" />
        </branch>
        <iomarker fontsize="28" x="320" y="3088" name="adc2_d(13:0)" orien="R180" />
        <branch name="XLXN_56(13:0)">
            <wire x2="1200" y1="2992" y2="2992" x1="1008" />
            <wire x2="1200" y1="2992" y2="3088" x1="1200" />
            <wire x2="1408" y1="3088" y2="3088" x1="1200" />
        </branch>
        <branch name="XLXN_57(13:0)">
            <wire x2="1184" y1="3088" y2="3088" x1="1008" />
            <wire x2="1184" y1="3088" y2="3152" x1="1184" />
            <wire x2="1408" y1="3152" y2="3152" x1="1184" />
        </branch>
        <branch name="CLK1_FB">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1360" y="2896" type="branch" />
            <wire x2="1360" y1="2896" y2="2896" x1="1264" />
            <wire x2="1408" y1="2896" y2="2896" x1="1360" />
        </branch>
        <branch name="CLK56">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2128" y="2896" type="branch" />
            <wire x2="2128" y1="2896" y2="2896" x1="2048" />
            <wire x2="2192" y1="2896" y2="2896" x1="2128" />
            <wire x2="2304" y1="2896" y2="2896" x1="2192" />
        </branch>
        <iomarker fontsize="28" x="368" y="2256" name="RESETl" orien="R180" />
        <branch name="RESETl">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="526" y="2256" type="branch" />
            <wire x2="526" y1="2256" y2="2256" x1="368" />
            <wire x2="672" y1="2256" y2="2256" x1="526" />
        </branch>
        <branch name="RESETl">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="544" y="2960" type="branch" />
            <wire x2="544" y1="2960" y2="2960" x1="432" />
            <wire x2="624" y1="2960" y2="2960" x1="544" />
        </branch>
        <branch name="RESETl">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1392" y="3024" type="branch" />
            <wire x2="1392" y1="3024" y2="3024" x1="1312" />
            <wire x2="1408" y1="3024" y2="3024" x1="1392" />
        </branch>
        <branch name="RESETl">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2144" y="2960" type="branch" />
            <wire x2="2144" y1="2960" y2="2960" x1="2032" />
            <wire x2="2192" y1="2960" y2="2960" x1="2144" />
            <wire x2="2304" y1="2960" y2="2960" x1="2192" />
        </branch>
        <branch name="clkb">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2256" y="2032" type="branch" />
            <wire x2="2256" y1="2032" y2="2032" x1="2192" />
            <wire x2="2320" y1="2032" y2="2032" x1="2256" />
        </branch>
        <instance x="1296" y="2384" name="XLXI_14" orien="R0">
        </instance>
        <branch name="red1">
            <wire x2="1696" y1="2192" y2="2192" x1="1680" />
            <wire x2="1776" y1="2192" y2="2192" x1="1696" />
        </branch>
        <iomarker fontsize="28" x="1776" y="2192" name="red1" orien="R0" />
        <branch name="XLXN_74">
            <wire x2="1216" y1="1936" y2="2160" x1="1216" />
            <wire x2="1296" y1="2160" y2="2160" x1="1216" />
            <wire x2="1792" y1="1936" y2="1936" x1="1216" />
            <wire x2="1792" y1="1808" y2="1808" x1="1712" />
            <wire x2="1792" y1="1808" y2="1936" x1="1792" />
        </branch>
        <branch name="XLXN_75">
            <wire x2="2000" y1="2032" y2="2032" x1="1680" />
            <wire x2="2000" y1="1904" y2="2032" x1="2000" />
            <wire x2="2320" y1="1904" y2="1904" x1="2000" />
        </branch>
        <branch name="XLXN_76(31:0)">
            <wire x2="1984" y1="2352" y2="2352" x1="1680" />
            <wire x2="1984" y1="1840" y2="2352" x1="1984" />
            <wire x2="2320" y1="1840" y2="1840" x1="1984" />
        </branch>
        <branch name="DRDY_SD">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1088" y="2032" type="branch" />
            <wire x2="1088" y1="2032" y2="2032" x1="912" />
            <wire x2="1296" y1="2032" y2="2032" x1="1088" />
        </branch>
        <branch name="RESETl">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1088" y="2096" type="branch" />
            <wire x2="1088" y1="2096" y2="2096" x1="928" />
            <wire x2="1296" y1="2096" y2="2096" x1="1088" />
        </branch>
        <branch name="DRDY_SD">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2256" y="1936" type="branch" />
            <wire x2="2256" y1="1936" y2="1936" x1="2128" />
            <wire x2="2320" y1="1936" y2="1936" x1="2256" />
        </branch>
        <iomarker fontsize="28" x="2336" y="1376" name="CONFIG_DONE" orien="R0" />
        <branch name="CONFIG_DONE">
            <wire x2="1824" y1="2896" y2="2896" x1="1792" />
            <wire x2="1824" y1="2896" y2="2944" x1="1824" />
            <wire x2="2112" y1="2944" y2="2944" x1="1824" />
            <wire x2="2112" y1="1376" y2="2944" x1="2112" />
            <wire x2="2128" y1="1376" y2="1376" x1="2112" />
            <wire x2="2336" y1="1376" y2="1376" x1="2128" />
        </branch>
        <branch name="CLK14">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1360" y="2960" type="branch" />
            <wire x2="1360" y1="2960" y2="2960" x1="1264" />
            <wire x2="1408" y1="2960" y2="2960" x1="1360" />
        </branch>
        <instance x="336" y="4256" name="XLXI_15" orien="R0" />
        <branch name="RESETl">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="288" y="4224" type="branch" />
            <wire x2="288" y1="4224" y2="4224" x1="208" />
            <wire x2="336" y1="4224" y2="4224" x1="288" />
        </branch>
        <branch name="RESETh">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="592" y="4224" type="branch" />
            <wire x2="592" y1="4224" y2="4224" x1="560" />
            <wire x2="624" y1="4224" y2="4224" x1="592" />
        </branch>
        <branch name="CLK14">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1104" y="4480" type="branch" />
            <wire x2="1104" y1="4480" y2="4480" x1="1088" />
            <wire x2="1216" y1="4480" y2="4480" x1="1104" />
        </branch>
        <branch name="XLXN_83(7:0)">
            <wire x2="1808" y1="3152" y2="3152" x1="1792" />
            <wire x2="1984" y1="3152" y2="3152" x1="1808" />
            <wire x2="1984" y1="3088" y2="3152" x1="1984" />
            <wire x2="2192" y1="3088" y2="3088" x1="1984" />
            <wire x2="2304" y1="3088" y2="3088" x1="2192" />
        </branch>
        <branch name="CLK56">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1136" y="4544" type="branch" />
            <wire x2="1136" y1="4544" y2="4544" x1="1088" />
            <wire x2="1216" y1="4544" y2="4544" x1="1136" />
        </branch>
        <instance x="2304" y="3184" name="XLXI_16" orien="R0">
        </instance>
        <branch name="XLXN_95(7:0)">
            <wire x2="1808" y1="3024" y2="3024" x1="1792" />
            <wire x2="1920" y1="3024" y2="3024" x1="1808" />
            <wire x2="1936" y1="3024" y2="3024" x1="1920" />
            <wire x2="2192" y1="3024" y2="3024" x1="1936" />
            <wire x2="2208" y1="3024" y2="3024" x1="2192" />
            <wire x2="2304" y1="3024" y2="3024" x1="2208" />
        </branch>
        <branch name="XLXN_98(15:0)">
            <wire x2="1248" y1="2416" y2="2576" x1="1248" />
            <wire x2="2720" y1="2576" y2="2576" x1="1248" />
            <wire x2="2720" y1="2576" y2="3344" x1="2720" />
            <wire x2="1280" y1="2416" y2="2416" x1="1248" />
            <wire x2="1296" y1="2416" y2="2416" x1="1280" />
            <wire x2="2720" y1="3344" y2="3344" x1="2688" />
        </branch>
        <instance x="2944" y="3120" name="XLXI_17" orien="R0">
        </instance>
        <branch name="CLK14">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2928" y="2960" type="branch" />
            <wire x2="2928" y1="2960" y2="2960" x1="2864" />
            <wire x2="2944" y1="2960" y2="2960" x1="2928" />
        </branch>
        <branch name="RESETl">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="2928" y="3024" type="branch" />
            <wire x2="2928" y1="3024" y2="3024" x1="2864" />
            <wire x2="2944" y1="3024" y2="3024" x1="2928" />
        </branch>
        <branch name="XLXN_102(7:0)">
            <wire x2="2816" y1="3056" y2="3056" x1="2688" />
            <wire x2="2816" y1="3056" y2="3088" x1="2816" />
            <wire x2="2944" y1="3088" y2="3088" x1="2816" />
        </branch>
        <branch name="XLXN_103">
            <wire x2="2944" y1="2896" y2="2896" x1="2688" />
        </branch>
        <branch name="DRDY_CD">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="3488" y="3088" type="branch" />
            <wire x2="3488" y1="3088" y2="3088" x1="3328" />
            <wire x2="3584" y1="3088" y2="3088" x1="3488" />
            <wire x2="3744" y1="2928" y2="2928" x1="3584" />
            <wire x2="3584" y1="2928" y2="3088" x1="3584" />
        </branch>
        <instance x="3744" y="3152" name="XLXI_18" orien="R0">
        </instance>
        <branch name="XLXN_106">
            <wire x2="3536" y1="2896" y2="2896" x1="3328" />
            <wire x2="3536" y1="2896" y2="2992" x1="3536" />
            <wire x2="3744" y1="2992" y2="2992" x1="3536" />
        </branch>
        <branch name="RESETl">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="3712" y="3120" type="branch" />
            <wire x2="3712" y1="3120" y2="3120" x1="3616" />
            <wire x2="3744" y1="3120" y2="3120" x1="3712" />
        </branch>
        <branch name="DRDY_SD">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="4240" y="3184" type="branch" />
            <wire x2="4240" y1="3184" y2="3184" x1="4128" />
            <wire x2="4448" y1="3184" y2="3184" x1="4240" />
        </branch>
        <branch name="XLXN_109(7:0)">
            <wire x2="1296" y1="2288" y2="2288" x1="1216" />
            <wire x2="1216" y1="2288" y2="2704" x1="1216" />
            <wire x2="4192" y1="2704" y2="2704" x1="1216" />
            <wire x2="4192" y1="2704" y2="3312" x1="4192" />
            <wire x2="4192" y1="3312" y2="3312" x1="4128" />
        </branch>
        <instance x="656" y="5056" name="XLXI_19" orien="R0">
        </instance>
        <branch name="RESETh">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="528" y="4832" type="branch" />
            <wire x2="528" y1="4832" y2="4832" x1="400" />
            <wire x2="656" y1="4832" y2="4832" x1="528" />
        </branch>
        <branch name="clka">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="528" y="5024" type="branch" />
            <wire x2="528" y1="5024" y2="5024" x1="432" />
            <wire x2="656" y1="5024" y2="5024" x1="528" />
        </branch>
        <iomarker fontsize="28" x="432" y="5024" name="clka" orien="R180" />
        <branch name="clk64">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1200" y="5088" type="branch" />
            <wire x2="1200" y1="5088" y2="5088" x1="1120" />
            <wire x2="1264" y1="5088" y2="5088" x1="1200" />
            <wire x2="1264" y1="5088" y2="5104" x1="1264" />
        </branch>
        <branch name="clk64">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="3728" y="3056" type="branch" />
            <wire x2="3728" y1="3056" y2="3056" x1="3632" />
            <wire x2="3744" y1="3056" y2="3056" x1="3728" />
        </branch>
    </sheet>
</drawing>