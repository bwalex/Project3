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
        <signal name="CONFIG_DONE" />
        <signal name="RESETl" />
        <signal name="adc1_d(13:0)" />
        <signal name="XLXN_5" />
        <signal name="XLXN_6(31:0)" />
        <signal name="XLXN_7" />
        <signal name="XLXN_13" />
        <signal name="red1" />
        <signal name="XLXN_14" />
        <signal name="XLXN_15" />
        <signal name="XLXN_16" />
        <signal name="XLXN_17" />
        <signal name="XLXN_18(15:0)" />
        <signal name="XLXN_20" />
        <signal name="XLXN_21" />
        <signal name="XLXN_22(15:0)" />
        <signal name="XLXN_23(15:0)" />
        <signal name="XLXN_24(15:0)" />
        <signal name="XLXN_25(10:0)" />
        <signal name="XLXN_26(10:0)" />
        <signal name="XLXN_27(4:0)" />
        <signal name="XLXN_28" />
        <signal name="XLXN_29" />
        <signal name="XLXN_30" />
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
        <port polarity="Output" name="CONFIG_DONE" />
        <port polarity="Input" name="RESETl" />
        <port polarity="Input" name="adc1_d(13:0)" />
        <port polarity="Output" name="red1" />
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
            <timestamp>2010-10-19T13:6:17</timestamp>
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
        <blockdef name="ADC">
            <timestamp>2010-10-21T14:42:22</timestamp>
            <line x2="0" y1="96" y2="96" x1="64" />
            <line x2="0" y1="160" y2="160" x1="64" />
            <line x2="0" y1="224" y2="224" x1="64" />
            <rect width="64" x="0" y="276" height="24" />
            <line x2="0" y1="288" y2="288" x1="64" />
            <rect width="64" x="0" y="340" height="24" />
            <line x2="0" y1="352" y2="352" x1="64" />
            <rect width="64" x="0" y="404" height="24" />
            <line x2="0" y1="416" y2="416" x1="64" />
            <rect width="64" x="0" y="468" height="24" />
            <line x2="0" y1="480" y2="480" x1="64" />
            <rect width="64" x="0" y="532" height="24" />
            <line x2="0" y1="544" y2="544" x1="64" />
            <line x2="480" y1="96" y2="96" x1="416" />
            <line x2="480" y1="160" y2="160" x1="416" />
            <line x2="480" y1="224" y2="224" x1="416" />
            <line x2="480" y1="288" y2="288" x1="416" />
            <rect width="64" x="416" y="340" height="24" />
            <line x2="480" y1="352" y2="352" x1="416" />
            <rect width="64" x="416" y="404" height="24" />
            <line x2="480" y1="416" y2="416" x1="416" />
            <line x2="480" y1="32" y2="32" x1="416" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="480" y1="-288" y2="-288" x1="416" />
            <line x2="480" y1="-160" y2="-160" x1="416" />
            <rect width="64" x="416" y="-44" height="24" />
            <line x2="480" y1="-32" y2="-32" x1="416" />
            <rect width="352" x="64" y="-320" height="896" />
        </blockdef>
        <blockdef name="fft1">
            <timestamp>2010-10-21T14:9:53</timestamp>
            <rect width="512" x="32" y="32" height="3072" />
            <line x2="32" y1="80" y2="80" style="linewidth:W" x1="0" />
            <line x2="32" y1="528" y2="528" style="linewidth:W" x1="0" />
            <line x2="32" y1="976" y2="976" x1="0" />
            <line x2="32" y1="1008" y2="1008" x1="0" />
            <line x2="32" y1="1200" y2="1200" x1="0" />
            <line x2="32" y1="1648" y2="1648" x1="0" />
            <line x2="32" y1="3056" y2="3056" x1="0" />
            <line x2="544" y1="80" y2="80" style="linewidth:W" x1="576" />
            <line x2="544" y1="528" y2="528" style="linewidth:W" x1="576" />
            <line x2="544" y1="976" y2="976" style="linewidth:W" x1="576" />
            <line x2="544" y1="1008" y2="1008" style="linewidth:W" x1="576" />
            <line x2="544" y1="1040" y2="1040" x1="576" />
            <line x2="544" y1="1072" y2="1072" x1="576" />
            <line x2="544" y1="1104" y2="1104" x1="576" />
            <line x2="544" y1="1136" y2="1136" x1="576" />
            <line x2="544" y1="1168" y2="1168" x1="576" />
            <line x2="544" y1="1264" y2="1264" style="linewidth:W" x1="576" />
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
            <blockpin signalname="XLXN_13" name="EN_PERIPH" />
        </block>
        <block symbolname="fifo" name="XLXI_2">
            <blockpin signalname="XLXN_6(31:0)" name="din(31:0)" />
            <blockpin signalname="XLXN_5" name="wr_en" />
            <blockpin signalname="CLK1_FB" name="wr_clk" />
            <blockpin signalname="XLXN_3" name="rd_en" />
            <blockpin signalname="clkb" name="rd_clk" />
            <blockpin signalname="dout(31:0)" name="dout(31:0)" />
            <blockpin signalname="XLXN_7" name="full" />
            <blockpin name="overflow" />
            <blockpin signalname="XLXN_1" name="empty" />
            <blockpin name="valid" />
        </block>
        <block symbolname="ADC" name="XLXI_3">
            <blockpin signalname="CLK1_FB" name="CLK_FB" />
            <blockpin signalname="RESETl" name="RST" />
            <blockpin signalname="XLXN_7" name="FULL" />
            <blockpin signalname="XLXN_13" name="ENABLE" />
            <blockpin signalname="adc1_d(13:0)" name="ADC1_D(13:0)" />
            <blockpin signalname="CONFIG_DONE" name="CONFIG_DONE" />
            <blockpin signalname="red1" name="LED1" />
            <blockpin signalname="XLXN_5" name="DATA_OUT_EN" />
            <blockpin signalname="XLXN_6(31:0)" name="DATA_OUT(31:0)" />
            <blockpin signalname="XLXN_28" name="FFT_DONE" />
            <blockpin signalname="XLXN_29" name="FFT_DV" />
            <blockpin signalname="XLXN_30" name="FFT_RFD" />
            <blockpin signalname="XLXN_23(15:0)" name="XK_RE(15:0)" />
            <blockpin signalname="XLXN_24(15:0)" name="XK_IM(15:0)" />
            <blockpin signalname="XLXN_27(4:0)" name="FFT_EXP(4:0)" />
            <blockpin signalname="XLXN_25(10:0)" name="XN_IDX(10:0)" />
            <blockpin signalname="XLXN_26(10:0)" name="XK_IDX(10:0)" />
            <blockpin signalname="XLXN_14" name="FFT_START" />
            <blockpin signalname="XLXN_15" name="FFT_UNLOAD" />
            <blockpin signalname="XLXN_16" name="FFT_FWDINV" />
            <blockpin signalname="XLXN_17" name="FFT_FWDINV_WR" />
            <blockpin signalname="XLXN_22(15:0)" name="XN_RE(15:0)" />
            <blockpin signalname="XLXN_18(15:0)" name="XN_IM(15:0)" />
        </block>
        <block symbolname="fft1" name="XLXI_4">
            <blockpin signalname="XLXN_22(15:0)" name="xn_re(15:0)" />
            <blockpin signalname="XLXN_18(15:0)" name="xn_im(15:0)" />
            <blockpin signalname="XLXN_14" name="start" />
            <blockpin signalname="XLXN_15" name="unload" />
            <blockpin signalname="XLXN_16" name="fwd_inv" />
            <blockpin signalname="XLXN_17" name="fwd_inv_we" />
            <blockpin signalname="CLK1_FB" name="clk" />
            <blockpin signalname="XLXN_23(15:0)" name="xk_re(15:0)" />
            <blockpin signalname="XLXN_24(15:0)" name="xk_im(15:0)" />
            <blockpin signalname="XLXN_25(10:0)" name="xn_index(10:0)" />
            <blockpin signalname="XLXN_26(10:0)" name="xk_index(10:0)" />
            <blockpin signalname="XLXN_30" name="rfd" />
            <blockpin name="busy" />
            <blockpin signalname="XLXN_29" name="dv" />
            <blockpin name="edone" />
            <blockpin signalname="XLXN_28" name="done" />
            <blockpin signalname="XLXN_27(4:0)" name="blk_exp(4:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="5440" height="3520">
        <branch name="as_dsl">
            <wire x2="1312" y1="1248" y2="1248" x1="1296" />
            <wire x2="1328" y1="1248" y2="1248" x1="1312" />
        </branch>
        <iomarker fontsize="28" x="1296" y="1248" name="as_dsl" orien="R180" />
        <branch name="EMPTY">
            <wire x2="1312" y1="1328" y2="1328" x1="1296" />
            <wire x2="1328" y1="1328" y2="1328" x1="1312" />
        </branch>
        <iomarker fontsize="28" x="1296" y="1328" name="EMPTY" orien="R180" />
        <branch name="BUSY">
            <wire x2="1312" y1="1408" y2="1408" x1="1296" />
            <wire x2="1328" y1="1408" y2="1408" x1="1312" />
        </branch>
        <iomarker fontsize="28" x="1296" y="1408" name="BUSY" orien="R180" />
        <branch name="renl_wenl">
            <wire x2="1728" y1="1168" y2="1168" x1="1712" />
            <wire x2="1744" y1="1168" y2="1168" x1="1728" />
        </branch>
        <iomarker fontsize="28" x="1744" y="1168" name="renl_wenl" orien="R0" />
        <branch name="rdl_wr">
            <wire x2="1728" y1="1232" y2="1232" x1="1712" />
            <wire x2="1744" y1="1232" y2="1232" x1="1728" />
        </branch>
        <iomarker fontsize="28" x="1744" y="1232" name="rdl_wr" orien="R0" />
        <branch name="green2">
            <wire x2="1760" y1="1296" y2="1296" x1="1712" />
            <wire x2="1776" y1="1296" y2="1296" x1="1760" />
        </branch>
        <branch name="ADIO(31:0)">
            <wire x2="1728" y1="1424" y2="1424" x1="1712" />
            <wire x2="1744" y1="1424" y2="1424" x1="1728" />
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
            <wire x2="1136" y1="1744" y2="1744" x1="1120" />
            <wire x2="1328" y1="1744" y2="1744" x1="1136" />
        </branch>
        <iomarker fontsize="28" x="1120" y="1744" name="rstl" orien="R180" />
        <branch name="clkb">
            <attrtext style="alignment:SOFT-TCENTER" attrname="Name" x="1424" y="2048" type="branch" />
            <wire x2="1424" y1="2048" y2="2048" x1="1168" />
            <wire x2="2320" y1="2032" y2="2032" x1="1424" />
            <wire x2="1424" y1="2032" y2="2048" x1="1424" />
        </branch>
        <branch name="CLK1_FB">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="526" y="2192" type="branch" />
            <wire x2="526" y1="2192" y2="2192" x1="400" />
            <wire x2="656" y1="2192" y2="2192" x1="526" />
            <wire x2="672" y1="2192" y2="2192" x1="656" />
        </branch>
        <instance x="672" y="2480" name="XLXI_3" orien="R0">
        </instance>
        <branch name="CLK1_FB">
            <attrtext style="alignment:SOFT-TCENTER" attrname="Name" x="1376" y="1952" type="branch" />
            <wire x2="1376" y1="1952" y2="1952" x1="1152" />
            <wire x2="2320" y1="1936" y2="1936" x1="1376" />
            <wire x2="1376" y1="1936" y2="1952" x1="1376" />
        </branch>
        <branch name="CONFIG_DONE">
            <wire x2="1184" y1="2192" y2="2192" x1="1152" />
        </branch>
        <iomarker fontsize="28" x="1184" y="2192" name="CONFIG_DONE" orien="R0" />
        <branch name="RESETl">
            <wire x2="656" y1="2256" y2="2256" x1="368" />
            <wire x2="672" y1="2256" y2="2256" x1="656" />
        </branch>
        <branch name="adc1_d(13:0)">
            <wire x2="656" y1="2448" y2="2448" x1="448" />
            <wire x2="672" y1="2448" y2="2448" x1="656" />
        </branch>
        <iomarker fontsize="28" x="368" y="2256" name="RESETl" orien="R180" />
        <iomarker fontsize="28" x="400" y="2192" name="CLK1_FB" orien="R180" />
        <iomarker fontsize="28" x="448" y="2448" name="adc1_d(13:0)" orien="R180" />
        <branch name="XLXN_6(31:0)">
            <wire x2="1744" y1="2448" y2="2448" x1="1152" />
            <wire x2="1744" y1="1840" y2="2448" x1="1744" />
            <wire x2="2320" y1="1840" y2="1840" x1="1744" />
        </branch>
        <branch name="XLXN_7">
            <wire x2="624" y1="2320" y2="2624" x1="624" />
            <wire x2="2976" y1="2624" y2="2624" x1="624" />
            <wire x2="672" y1="2320" y2="2320" x1="624" />
            <wire x2="2976" y1="1968" y2="1968" x1="2896" />
            <wire x2="2976" y1="1968" y2="2624" x1="2976" />
        </branch>
        <branch name="XLXN_5">
            <wire x2="1728" y1="2320" y2="2320" x1="1152" />
            <wire x2="1728" y1="1904" y2="2320" x1="1728" />
            <wire x2="2320" y1="1904" y2="1904" x1="1728" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="2016" y1="1488" y2="1488" x1="1712" />
            <wire x2="2016" y1="1488" y2="2000" x1="2016" />
            <wire x2="2320" y1="2000" y2="2000" x1="2016" />
        </branch>
        <instance x="2320" y="1760" name="XLXI_2" orien="R0">
        </instance>
        <branch name="XLXN_13">
            <wire x2="672" y1="2384" y2="2384" x1="592" />
            <wire x2="592" y1="2384" y2="2608" x1="592" />
            <wire x2="1808" y1="2608" y2="2608" x1="592" />
            <wire x2="1808" y1="1808" y2="1808" x1="1712" />
            <wire x2="1808" y1="1808" y2="2608" x1="1808" />
        </branch>
        <branch name="red1">
            <wire x2="1184" y1="2512" y2="2512" x1="1152" />
        </branch>
        <iomarker fontsize="28" x="1184" y="2512" name="red1" orien="R0" />
        <branch name="CLK1_FB">
            <attrtext style="alignment:SOFT-TCENTER" attrname="Name" x="3072" y="3328" type="branch" />
            <wire x2="3072" y1="3328" y2="3328" x1="2832" />
            <wire x2="3536" y1="3312" y2="3312" x1="3072" />
            <wire x2="3072" y1="3312" y2="3328" x1="3072" />
        </branch>
        <branch name="XLXN_14">
            <wire x2="2288" y1="2576" y2="2576" x1="1152" />
            <wire x2="2288" y1="1232" y2="2576" x1="2288" />
            <wire x2="3536" y1="1232" y2="1232" x1="2288" />
        </branch>
        <branch name="XLXN_15">
            <wire x2="2272" y1="2640" y2="2640" x1="1152" />
            <wire x2="2272" y1="1264" y2="2640" x1="2272" />
            <wire x2="3536" y1="1264" y2="1264" x1="2272" />
        </branch>
        <branch name="XLXN_16">
            <wire x2="2256" y1="2704" y2="2704" x1="1152" />
            <wire x2="2256" y1="1456" y2="2704" x1="2256" />
            <wire x2="3536" y1="1456" y2="1456" x1="2256" />
        </branch>
        <branch name="XLXN_17">
            <wire x2="2960" y1="2768" y2="2768" x1="1152" />
            <wire x2="2960" y1="1904" y2="2768" x1="2960" />
            <wire x2="3536" y1="1904" y2="1904" x1="2960" />
        </branch>
        <branch name="XLXN_18(15:0)">
            <wire x2="2304" y1="2896" y2="2896" x1="1152" />
            <wire x2="2304" y1="784" y2="2896" x1="2304" />
            <wire x2="3536" y1="784" y2="784" x1="2304" />
        </branch>
        <instance x="3536" y="256" name="XLXI_4" orien="R0">
        </instance>
        <branch name="XLXN_22(15:0)">
            <wire x2="2240" y1="2832" y2="2832" x1="1152" />
            <wire x2="2240" y1="336" y2="2832" x1="2240" />
            <wire x2="3536" y1="336" y2="336" x1="2240" />
        </branch>
        <branch name="XLXN_23(15:0)">
            <wire x2="672" y1="2768" y2="2768" x1="624" />
            <wire x2="624" y1="2768" y2="3424" x1="624" />
            <wire x2="4192" y1="3424" y2="3424" x1="624" />
            <wire x2="4192" y1="336" y2="336" x1="4112" />
            <wire x2="4192" y1="336" y2="3424" x1="4192" />
        </branch>
        <branch name="XLXN_24(15:0)">
            <wire x2="608" y1="208" y2="2832" x1="608" />
            <wire x2="672" y1="2832" y2="2832" x1="608" />
            <wire x2="4176" y1="208" y2="208" x1="608" />
            <wire x2="4176" y1="208" y2="784" x1="4176" />
            <wire x2="4176" y1="784" y2="784" x1="4112" />
        </branch>
        <branch name="XLXN_25(10:0)">
            <wire x2="672" y1="2960" y2="2960" x1="592" />
            <wire x2="592" y1="2960" y2="3408" x1="592" />
            <wire x2="4176" y1="3408" y2="3408" x1="592" />
            <wire x2="4176" y1="1232" y2="1232" x1="4112" />
            <wire x2="4176" y1="1232" y2="3408" x1="4176" />
        </branch>
        <branch name="XLXN_26(10:0)">
            <wire x2="672" y1="3024" y2="3024" x1="608" />
            <wire x2="608" y1="3024" y2="3392" x1="608" />
            <wire x2="4160" y1="3392" y2="3392" x1="608" />
            <wire x2="4160" y1="1264" y2="1264" x1="4112" />
            <wire x2="4160" y1="1264" y2="3392" x1="4160" />
        </branch>
        <branch name="XLXN_27(4:0)">
            <wire x2="672" y1="2896" y2="2896" x1="656" />
            <wire x2="656" y1="2896" y2="3376" x1="656" />
            <wire x2="4144" y1="3376" y2="3376" x1="656" />
            <wire x2="4144" y1="1520" y2="1520" x1="4112" />
            <wire x2="4144" y1="1520" y2="3376" x1="4144" />
        </branch>
        <branch name="XLXN_28">
            <wire x2="672" y1="2576" y2="2576" x1="640" />
            <wire x2="640" y1="2576" y2="3488" x1="640" />
            <wire x2="4272" y1="3488" y2="3488" x1="640" />
            <wire x2="4272" y1="1424" y2="1424" x1="4112" />
            <wire x2="4272" y1="1424" y2="3488" x1="4272" />
        </branch>
        <branch name="XLXN_29">
            <wire x2="672" y1="2640" y2="2640" x1="512" />
            <wire x2="512" y1="2640" y2="3440" x1="512" />
            <wire x2="4256" y1="3440" y2="3440" x1="512" />
            <wire x2="4256" y1="1360" y2="1360" x1="4112" />
            <wire x2="4256" y1="1360" y2="3440" x1="4256" />
        </branch>
        <branch name="XLXN_30">
            <wire x2="672" y1="2704" y2="2704" x1="528" />
            <wire x2="528" y1="2704" y2="3456" x1="528" />
            <wire x2="4240" y1="3456" y2="3456" x1="528" />
            <wire x2="4240" y1="1296" y2="1296" x1="4112" />
            <wire x2="4240" y1="1296" y2="3456" x1="4240" />
        </branch>
    </sheet>
</drawing>