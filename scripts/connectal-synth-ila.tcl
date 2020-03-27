source "board.tcl"
source "$connectaldir/scripts/connectal-synth-ip.tcl"

# for monitoring the slave connection to the portal
connectal_synth_ip ila 6.2 ila_connectal_1 [list CONFIG.C_PROBE12_WIDTH {16} CONFIG.C_PROBE11_WIDTH {16} CONFIG.C_PROBE10_WIDTH {32} CONFIG.C_PROBE7_WIDTH {32} CONFIG.C_PROBE4_WIDTH {32} CONFIG.C_PROBE1_WIDTH {32} CONFIG.C_DATA_DEPTH {4096} CONFIG.C_NUM_OF_PROBES {14} CONFIG.C_EN_STRG_QUAL {1} CONFIG.C_PROBE7_MU_CNT {2} CONFIG.C_PROBE6_MU_CNT {2} CONFIG.C_PROBE5_MU_CNT {2} CONFIG.C_PROBE4_MU_CNT {2} CONFIG.C_PROBE3_MU_CNT {2} CONFIG.C_PROBE2_MU_CNT {2} CONFIG.C_PROBE1_MU_CNT {2} CONFIG.C_PROBE0_MU_CNT {2} CONFIG.ALL_PROBE_SAME_MU_CNT {2}]

# for monitoring the memory master connection from the portal, including 19 bit aruser and awuser for AwsF1
connectal_synth_ip ila 6.2 ila_connectal_2 [list \
    CONFIG.ALL_PROBE_SAME_MU_CNT {2} \
    CONFIG.C_DATA_DEPTH {4096} \
    CONFIG.C_EN_STRG_QUAL {1} \
    CONFIG.C_NUM_OF_PROBES {25} \
    CONFIG.C_PROBE0_MU_CNT {2} \
    CONFIG.C_PROBE1_MU_CNT {2} \
    CONFIG.C_PROBE1_WIDTH {64} \
    CONFIG.C_PROBE2_MU_CNT {2} \
    CONFIG.C_PROBE3_MU_CNT {2} \
    CONFIG.C_PROBE4_MU_CNT {2} \
    CONFIG.C_PROBE4_WIDTH {64} \
    CONFIG.C_PROBE5_MU_CNT {2} \
    CONFIG.C_PROBE6_MU_CNT {2} \
    CONFIG.C_PROBE7_MU_CNT {2} \
    CONFIG.C_PROBE7_WIDTH {512} \
    CONFIG.C_PROBE10_WIDTH {512} \
    CONFIG.C_PROBE12_WIDTH {64} \
    CONFIG.C_PROBE13_WIDTH {19} \
    CONFIG.C_PROBE14_WIDTH {19} \
    CONFIG.C_PROBE15_WIDTH {8} \
    CONFIG.C_PROBE16_WIDTH {8} \
    CONFIG.C_PROBE17_WIDTH {3} \
    CONFIG.C_PROBE18_WIDTH {3} \
    CONFIG.C_PROBE19_WIDTH {16} \
    CONFIG.C_PROBE20_WIDTH {16} \
    CONFIG.C_PROBE21_WIDTH {16} \
    CONFIG.C_PROBE22_WIDTH {2} \
    CONFIG.C_PROBE23_WIDTH {1} \
    CONFIG.C_PROBE24_WIDTH {1} \
    ]
