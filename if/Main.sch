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
        <signal name="red1" />
        <signal name="ADIO(31:0)" />
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="din(31:0)" />
        <signal name="dout(31:0)" />
        <signal name="clkb" />
        <signal name="rstl" />
        <port polarity="Input" name="as_dsl" />
        <port polarity="Input" name="EMPTY" />
        <port polarity="Input" name="BUSY" />
        <port polarity="Output" name="renl_wenl" />
        <port polarity="Output" name="rdl_wr" />
        <port polarity="Output" name="green2" />
        <port polarity="Output" name="red1" />
        <port polarity="BiDirectional" name="ADIO(31:0)" />
        <port polarity="Input" name="clkb" />
        <port polarity="Input" name="rstl" />
        <blockdef name="SpartanInterface">
            <timestamp>2010-10-18T13:8:18</timestamp>
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
            <rect width="256" x="64" y="-320" height="640" />
        </blockdef>
        <blockdef name="fifo">
            <timestamp>2010-10-14T12:38:41</timestamp>
            <rect width="512" x="32" y="32" height="736" />
            <line x2="32" y1="80" y2="80" style="linewidth:W" x1="0" />
            <line x2="32" y1="144" y2="144" x1="0" />
            <line x2="32" y1="240" y2="240" x1="0" />
            <line x2="32" y1="336" y2="336" x1="0" />
            <line x2="544" y1="80" y2="80" style="linewidth:W" x1="576" />
            <line x2="544" y1="208" y2="208" x1="576" />
            <line x2="544" y1="336" y2="336" x1="576" />
            <line x2="544" y1="432" y2="432" x1="576" />
            <line x2="544" y1="528" y2="528" x1="576" />
        </blockdef>
        <block symbolname="SpartanInterface" name="XLXI_1">
            <blockpin signalname="clkb" name="CLK" />
            <blockpin signalname="as_dsl" name="AS_DS" />
            <blockpin signalname="EMPTY" name="EMPTY" />
            <blockpin signalname="BUSY" name="BUSY" />
            <blockpin signalname="XLXN_1" name="FIFO_EMPTY" />
            <blockpin signalname="XLXN_2" name="FIFO_FULL" />
            <blockpin signalname="dout(31:0)" name="FIFO_IN(31:0)" />
            <blockpin signalname="ADIO(31:0)" name="ADIO(31:0)" />
            <blockpin signalname="renl_wenl" name="REN_WEN" />
            <blockpin signalname="rdl_wr" name="RD_WR" />
            <blockpin signalname="green2" name="TXLED" />
            <blockpin signalname="red1" name="RXLED" />
            <blockpin signalname="XLXN_3" name="FIFO_RD_EN" />
            <blockpin signalname="XLXN_4" name="FIFO_WR_EN" />
            <blockpin signalname="din(31:0)" name="FIFO_OUT(31:0)" />
            <blockpin signalname="rstl" name="RST" />
        </block>
        <block symbolname="fifo" name="XLXI_2">
            <blockpin signalname="din(31:0)" name="din(31:0)" />
            <blockpin signalname="XLXN_4" name="wr_en" />
            <blockpin signalname="XLXN_3" name="rd_en" />
            <blockpin signalname="clkb" name="clk" />
            <blockpin signalname="dout(31:0)" name="dout(31:0)" />
            <blockpin signalname="XLXN_2" name="full" />
            <blockpin name="overflow" />
            <blockpin signalname="XLXN_1" name="empty" />
            <blockpin name="valid" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
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
        <branch name="red1">
            <wire x2="1776" y1="1360" y2="1360" x1="1712" />
        </branch>
        <branch name="ADIO(31:0)">
            <wire x2="1744" y1="1424" y2="1424" x1="1712" />
        </branch>
        <iomarker fontsize="28" x="1744" y="1424" name="ADIO(31:0)" orien="R0" />
        <instance x="1328" y="1456" name="XLXI_1" orien="R0">
        </instance>
        <iomarker fontsize="28" x="1776" y="1296" name="green2" orien="R0" />
        <iomarker fontsize="28" x="1776" y="1360" name="red1" orien="R0" />
        <branch name="XLXN_3">
            <wire x2="1792" y1="1488" y2="1488" x1="1712" />
            <wire x2="1792" y1="1488" y2="2016" x1="1792" />
            <wire x2="1888" y1="2016" y2="2016" x1="1792" />
        </branch>
        <branch name="XLXN_4">
            <wire x2="1808" y1="1552" y2="1552" x1="1712" />
            <wire x2="1808" y1="1552" y2="1920" x1="1808" />
            <wire x2="1888" y1="1920" y2="1920" x1="1808" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1328" y1="1552" y2="1552" x1="1296" />
            <wire x2="1296" y1="1552" y2="1792" x1="1296" />
            <wire x2="2512" y1="1792" y2="1792" x1="1296" />
            <wire x2="2512" y1="1792" y2="1984" x1="2512" />
            <wire x2="2512" y1="1984" y2="1984" x1="2464" />
        </branch>
        <branch name="XLXN_1">
            <wire x2="1264" y1="1488" y2="1776" x1="1264" />
            <wire x2="2496" y1="1776" y2="1776" x1="1264" />
            <wire x2="2496" y1="1776" y2="2208" x1="2496" />
            <wire x2="1328" y1="1488" y2="1488" x1="1264" />
            <wire x2="2496" y1="2208" y2="2208" x1="2464" />
        </branch>
        <instance x="1888" y="1776" name="XLXI_2" orien="R0">
        </instance>
        <branch name="din(31:0)">
            <wire x2="1776" y1="1680" y2="1680" x1="1712" />
            <wire x2="1776" y1="1680" y2="1856" x1="1776" />
            <wire x2="1888" y1="1856" y2="1856" x1="1776" />
        </branch>
        <branch name="dout(31:0)">
            <wire x2="1328" y1="1680" y2="1680" x1="1280" />
            <wire x2="1280" y1="1680" y2="1728" x1="1280" />
            <wire x2="2528" y1="1728" y2="1728" x1="1280" />
            <wire x2="2528" y1="1728" y2="1856" x1="2528" />
            <wire x2="2528" y1="1856" y2="1856" x1="2464" />
        </branch>
        <branch name="clkb">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="885" y="1168" type="branch" />
            <wire x2="885" y1="1168" y2="1168" x1="480" />
            <wire x2="1328" y1="1168" y2="1168" x1="885" />
        </branch>
        <branch name="clkb">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="1584" y="2112" type="branch" />
            <wire x2="1584" y1="2112" y2="2112" x1="1328" />
            <wire x2="1888" y1="2112" y2="2112" x1="1584" />
        </branch>
        <iomarker fontsize="28" x="480" y="1168" name="clkb" orien="R180" />
        <branch name="rstl">
            <wire x2="1312" y1="1744" y2="1744" x1="1120" />
            <wire x2="1328" y1="1744" y2="1744" x1="1312" />
        </branch>
        <iomarker fontsize="28" x="1120" y="1744" name="rstl" orien="R180" />
    </sheet>
</drawing>