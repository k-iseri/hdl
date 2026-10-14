###############################################################################
## Copyright (C) 2014-2024 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# create board design
source $ad_hdl_dir/projects/common/xilinx/adi_fir_filter_bd.tcl

# default ports

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr
create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 fixed_io

create_bd_port -dir O spi0_csn_2_o
create_bd_port -dir O spi0_csn_1_o
create_bd_port -dir O spi0_csn_0_o
create_bd_port -dir I spi0_csn_i
create_bd_port -dir I spi0_clk_i
create_bd_port -dir O spi0_clk_o
create_bd_port -dir I spi0_sdo_i
create_bd_port -dir O spi0_sdo_o
create_bd_port -dir I spi0_sdi_i

create_bd_port -dir I -from 17 -to 0 gpio_i
create_bd_port -dir O -from 17 -to 0 gpio_o
create_bd_port -dir O -from 17 -to 0 gpio_t



# instance: sys_ps7

ad_ip_instance processing_system7 sys_ps7

# ps7 settings

ad_ip_parameter sys_ps7 CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 1.8V}
ad_ip_parameter sys_ps7 CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V}
ad_ip_parameter sys_ps7 CONFIG.PCW_PACKAGE_NAME clg400
ad_ip_parameter sys_ps7 CONFIG.PCW_USE_S_AXI_HP1 1
ad_ip_parameter sys_ps7 CONFIG.PCW_USE_S_AXI_HP2 1
ad_ip_parameter sys_ps7 CONFIG.PCW_EN_CLK1_PORT 1
ad_ip_parameter sys_ps7 CONFIG.PCW_EN_RST1_PORT 1
ad_ip_parameter sys_ps7 CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ 100.0
ad_ip_parameter sys_ps7 CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ 200.0
ad_ip_parameter sys_ps7 CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_GPIO_EMIO_GPIO_IO 18
ad_ip_parameter sys_ps7 CONFIG.PCW_SPI1_PERIPHERAL_ENABLE 0
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C0_PERIPHERAL_ENABLE 0
ad_ip_parameter sys_ps7 CONFIG.PCW_UART1_PERIPHERAL_ENABLE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_UART1_UART1_IO {MIO 12 .. 13}
ad_ip_parameter sys_ps7 CONFIG.PCW_I2C1_PERIPHERAL_ENABLE 0
ad_ip_parameter sys_ps7 CONFIG.PCW_QSPI_PERIPHERAL_ENABLE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_SD0_PERIPHERAL_ENABLE 0
ad_ip_parameter sys_ps7 CONFIG.PCW_SPI0_PERIPHERAL_ENABLE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_SPI0_SPI0_IO EMIO
ad_ip_parameter sys_ps7 CONFIG.PCW_TTC0_PERIPHERAL_ENABLE 0
ad_ip_parameter sys_ps7 CONFIG.PCW_USE_FABRIC_INTERRUPT 1
ad_ip_parameter sys_ps7 CONFIG.PCW_USB0_PERIPHERAL_ENABLE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_GPIO_MIO_GPIO_ENABLE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_GPIO_MIO_GPIO_IO MIO
ad_ip_parameter sys_ps7 CONFIG.PCW_USB0_RESET_IO {MIO 52}
ad_ip_parameter sys_ps7 CONFIG.PCW_USB0_RESET_ENABLE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_IRQ_F2P_INTR 1
ad_ip_parameter sys_ps7 CONFIG.PCW_IRQ_F2P_MODE REVERSE
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_0_PULLUP {enabled}
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_9_PULLUP {enabled}
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_10_PULLUP {enabled}
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_11_PULLUP {enabled}
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_48_PULLUP {enabled}
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_49_PULLUP {disabled}
ad_ip_parameter sys_ps7 CONFIG.PCW_MIO_53_PULLUP {enabled}

# DDR MT41K256M16 HA-125 (32M, 16bit, 8banks)

ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125}
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {16 Bit}
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF 0
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL 1
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE 1
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 0.048
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 0.050
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 0.241
ad_ip_parameter sys_ps7 CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 0.240

ad_ip_instance xlconcat sys_concat_intc
ad_ip_parameter sys_concat_intc CONFIG.NUM_PORTS 16

ad_ip_instance proc_sys_reset sys_rstgen
ad_ip_parameter sys_rstgen CONFIG.C_EXT_RST_WIDTH 1

# system reset/clock definitions

# add external spi


ad_connect  sys_cpu_clk sys_ps7/FCLK_CLK0
ad_connect  sys_200m_clk sys_ps7/FCLK_CLK1
ad_connect  sys_cpu_reset sys_rstgen/peripheral_reset
ad_connect  sys_cpu_resetn sys_rstgen/peripheral_aresetn
ad_connect  sys_cpu_clk sys_rstgen/slowest_sync_clk
ad_connect  sys_rstgen/ext_reset_in sys_ps7/FCLK_RESET0_N

# interface connections

ad_connect  ddr sys_ps7/DDR
ad_connect  gpio_i sys_ps7/GPIO_I
ad_connect  gpio_o sys_ps7/GPIO_O
ad_connect  gpio_t sys_ps7/GPIO_T
ad_connect  fixed_io sys_ps7/FIXED_IO

# ps7 spi connections

ad_connect  spi0_csn_2_o sys_ps7/SPI0_SS2_O
ad_connect  spi0_csn_1_o sys_ps7/SPI0_SS1_O
ad_connect  spi0_csn_0_o sys_ps7/SPI0_SS_O
ad_connect  spi0_csn_i sys_ps7/SPI0_SS_I
ad_connect  spi0_clk_i sys_ps7/SPI0_SCLK_I
ad_connect  spi0_clk_o sys_ps7/SPI0_SCLK_O
ad_connect  spi0_sdo_i sys_ps7/SPI0_MOSI_I
ad_connect  spi0_sdo_o sys_ps7/SPI0_MOSI_O
ad_connect  spi0_sdi_i sys_ps7/SPI0_MISO_I

# axi spi connections


# interrupts

ad_connect  sys_concat_intc/dout sys_ps7/IRQ_F2P
ad_connect  sys_concat_intc/In15 GND
ad_connect  sys_concat_intc/In14 GND
ad_connect  sys_concat_intc/In13 GND
ad_connect  sys_concat_intc/In12 GND
ad_connect  sys_concat_intc/In11 GND
ad_connect  sys_concat_intc/In10 GND
ad_connect  sys_concat_intc/In9 GND
ad_connect  sys_concat_intc/In8 GND
ad_connect  sys_concat_intc/In7 GND
ad_connect  sys_concat_intc/In6 GND
ad_connect  sys_concat_intc/In5 GND
ad_connect  sys_concat_intc/In4 GND
ad_connect  sys_concat_intc/In3 GND
ad_connect  sys_concat_intc/In2 GND
ad_connect  sys_concat_intc/In1 GND
ad_connect  sys_concat_intc/In0 GND

# iic




# ad9361

create_bd_port -dir I rx_clk_in
create_bd_port -dir I rx_frame_in
create_bd_port -dir I -from 11 -to 0 rx_data_in

create_bd_port -dir O tx_clk_out
create_bd_port -dir O tx_frame_out
create_bd_port -dir O -from 11 -to 0 tx_data_out

create_bd_port -dir O enable
create_bd_port -dir O txnrx
create_bd_port -dir I up_enable
create_bd_port -dir I up_txnrx

# ad9361 core(s)

ad_ip_instance axi_ad9361 axi_ad9361
ad_ip_parameter axi_ad9361 CONFIG.ID 0
ad_ip_parameter axi_ad9361 CONFIG.CMOS_OR_LVDS_N 1
ad_ip_parameter axi_ad9361 CONFIG.MODE_1R1T 0
ad_ip_parameter axi_ad9361 CONFIG.ADC_INIT_DELAY 21
# isdbt v2a: 使わない機能を外して資源を空ける（FIR は BD から削除済み）。AD9361 側の補正で足りている
ad_ip_parameter axi_ad9361 CONFIG.DAC_DDS_DISABLE 1
ad_ip_parameter axi_ad9361 CONFIG.DAC_IQCORRECTION_DISABLE 1
ad_ip_parameter axi_ad9361 CONFIG.ADC_IQCORRECTION_DISABLE 1
ad_ip_parameter axi_ad9361 CONFIG.ADC_DCFILTER_DISABLE 1
# isdbt v1: ストリームは 8bit/サンプル（pack8 + cpack 8bit）。コアにそう申告させ、
# カーネル（cf_axi_adc の isdbt パッチ）が scan_elements を le:s8/8 にする
ad_ip_parameter axi_ad9361 CONFIG.USR_DATATYPE_TOTAL_BITS 8
ad_ip_parameter axi_ad9361 CONFIG.USR_DATATYPE_BITS 8
# isdbt v1: サンプルカウンタ（バイト 0x3000、MAGIC 0x49534442）
ad_ip_parameter axi_ad9361 CONFIG.ISDBT_COUNTER_ENABLE 1
# pack8 のシフト量。3 = +6 dB の前置ゲイン（8bit 量子化雑音を下げる。ADC −6 dBFS 以上で飽和するが、
# ソフト AGC の目標 −24 dBFS に対し OFDM のピーク（+12 dB）でも −12 dBFS なので余裕がある）
set isdbt_pack_shift 3
ad_ip_parameter axi_ad9361 CONFIG.ISDBT_PACK_SHIFT $isdbt_pack_shift

ad_ip_instance axi_dmac axi_ad9361_dac_dma
ad_ip_parameter axi_ad9361_dac_dma CONFIG.DMA_TYPE_SRC 0
ad_ip_parameter axi_ad9361_dac_dma CONFIG.DMA_TYPE_DEST 1
ad_ip_parameter axi_ad9361_dac_dma CONFIG.CYCLIC 1
ad_ip_parameter axi_ad9361_dac_dma CONFIG.SYNC_TRANSFER_START 1
ad_ip_parameter axi_ad9361_dac_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter axi_ad9361_dac_dma CONFIG.AXI_SLICE_DEST 0
ad_ip_parameter axi_ad9361_dac_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter axi_ad9361_dac_dma CONFIG.DMA_DATA_WIDTH_DEST 64

ad_ip_instance util_upack2 tx_upack

ad_ip_instance axi_dmac axi_ad9361_adc_dma
ad_ip_parameter axi_ad9361_adc_dma CONFIG.DMA_TYPE_SRC 2
ad_ip_parameter axi_ad9361_adc_dma CONFIG.DMA_TYPE_DEST 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.CYCLIC 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.SYNC_TRANSFER_START 1
ad_ip_parameter axi_ad9361_adc_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.AXI_SLICE_DEST 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.DMA_DATA_WIDTH_SRC 32

ad_ip_instance util_cpack2 cpack
ad_ip_parameter cpack CONFIG.SAMPLE_DATA_WIDTH 8

# isdbt v1: 16bit コンテナの 12bit サンプルを 8bit に量子化する pack8（MIT、pluto-fw-isdbt/rtl）。
# 置き場所は環境変数 ISDBT_RTL_DIR、既定は hdl/../../rtl（pluto-fw-isdbt の submodule 配置）
if {[info exists ::env(ISDBT_RTL_DIR)]} {
  set isdbt_rtl_dir $::env(ISDBT_RTL_DIR)
} else {
  set isdbt_rtl_dir $ad_hdl_dir/../../rtl
}
add_files -norecurse $isdbt_rtl_dir/pack8.v
# isdbt v2b-2c: iic/spi/tdd 削除、FFT 12bit（下の v2b の節を参照）
# isdbt v2b: 前段オフロード（まずは FFT テストモード）。窓切り出し → Xilinx FFT 8192 → ヘッダ付き DMA 出力。
# DMA の入力は dma_mux でモード 0（cpack = raw I/Q）とモード 1 以上（fe_out）を切り替える
add_files -norecurse $isdbt_rtl_dir/isdbt_fe_win.v
add_files -norecurse $isdbt_rtl_dir/isdbt_fe_out.v
add_files -norecurse $isdbt_rtl_dir/isdbt_dma_mux.v
# isdbt v2b-3b: 等化器（モード 4）。表は isdbt_eq_tables.vh（include）
add_files -norecurse $isdbt_rtl_dir/isdbt_eq_tables.vh
set_property file_type {Verilog Header} [get_files isdbt_eq_tables.vh]
set_property include_dirs $isdbt_rtl_dir [get_filesets sources_1]
# isdbt v2b-2: 同期（GI 相関 → 捕捉/追従 + CFO → CORDIC 逆回転）
add_files -norecurse $isdbt_rtl_dir/isdbt_cordic.v
add_files -norecurse $isdbt_rtl_dir/isdbt_cordic_seq.v
add_files -norecurse $isdbt_rtl_dir/isdbt_gi_corr.v
add_files -norecurse $isdbt_rtl_dir/isdbt_sync.v
add_files -norecurse $isdbt_rtl_dir/isdbt_eq.v
add_files -norecurse $isdbt_rtl_dir/isdbt_level.v
create_bd_cell -type module -reference isdbt_eq fe_eq
ad_ip_instance xlslice fe_hdr_start_lo
ad_ip_parameter fe_hdr_start_lo CONFIG.DIN_WIDTH 64
ad_ip_parameter fe_hdr_start_lo CONFIG.DIN_FROM 31
ad_ip_parameter fe_hdr_start_lo CONFIG.DIN_TO 0
ad_ip_instance xlslice fe_eq_cfo
ad_ip_parameter fe_eq_cfo CONFIG.DIN_WIDTH 16
ad_ip_parameter fe_eq_cfo CONFIG.DIN_FROM 7
ad_ip_parameter fe_eq_cfo CONFIG.DIN_TO 0
ad_ip_instance xlslice fe_eq_flags
ad_ip_parameter fe_eq_flags CONFIG.DIN_WIDTH 16
ad_ip_parameter fe_eq_flags CONFIG.DIN_FROM 15
ad_ip_parameter fe_eq_flags CONFIG.DIN_TO 8
create_bd_cell -type module -reference isdbt_gi_corr fe_corr
create_bd_cell -type module -reference isdbt_sync fe_sync
create_bd_cell -type module -reference isdbt_rotate_lut fe_rot
ad_ip_instance xlslice fe_corr_idx
ad_ip_parameter fe_corr_idx CONFIG.DIN_WIDTH 64
ad_ip_parameter fe_corr_idx CONFIG.DIN_FROM 31
ad_ip_parameter fe_corr_idx CONFIG.DIN_TO 0
ad_connect axi_ad9361/isdbt_sample_count fe_corr_idx/Din
ad_ip_instance xlconstant fe_margin
ad_ip_parameter fe_margin CONFIG.CONST_WIDTH 16
ad_ip_parameter fe_margin CONFIG.CONST_VAL 128
create_bd_cell -type module -reference isdbt_fe_win fe_win
create_bd_cell -type module -reference isdbt_fe_out fe_out
create_bd_cell -type module -reference isdbt_dma_mux dma_mux
ad_ip_instance xfft fe_fft
ad_ip_parameter fe_fft CONFIG.transform_length 8192
ad_ip_parameter fe_fft CONFIG.implementation_options pipelined_streaming_io
ad_ip_parameter fe_fft CONFIG.data_format fixed_point
ad_ip_parameter fe_fft CONFIG.input_width 12
ad_ip_parameter fe_fft CONFIG.phase_factor_width 12
ad_ip_parameter fe_fft CONFIG.scaling_options block_floating_point
ad_ip_parameter fe_fft CONFIG.rounding_modes convergent_rounding
ad_ip_parameter fe_fft CONFIG.output_ordering natural_order
ad_ip_parameter fe_fft CONFIG.throttle_scheme realtime
ad_ip_parameter fe_fft CONFIG.xk_index true
ad_ip_parameter fe_fft CONFIG.aresetn true
ad_ip_instance xlconcat fe_status_cat
ad_ip_parameter fe_status_cat CONFIG.NUM_PORTS 2
ad_ip_parameter fe_status_cat CONFIG.IN0_WIDTH 16
ad_ip_parameter fe_status_cat CONFIG.IN1_WIDTH 16

foreach lane {0 1 2 3} {
  create_bd_cell -type module -reference pack8 pack8_$lane
  set_property CONFIG.SHIFT $isdbt_pack_shift [get_bd_cells pack8_$lane]
}

# connections

ad_connect  rx_clk_in axi_ad9361/rx_clk_in
ad_connect  rx_frame_in axi_ad9361/rx_frame_in
ad_connect  rx_data_in axi_ad9361/rx_data_in
ad_connect  tx_clk_out axi_ad9361/tx_clk_out
ad_connect  tx_frame_out axi_ad9361/tx_frame_out
ad_connect  tx_data_out axi_ad9361/tx_data_out
ad_connect  enable axi_ad9361/enable
ad_connect  txnrx axi_ad9361/txnrx
ad_connect  up_enable axi_ad9361/up_enable
ad_connect  up_txnrx axi_ad9361/up_txnrx

ad_connect  axi_ad9361/tdd_sync GND
ad_connect  sys_200m_clk axi_ad9361/delay_clk
ad_connect  axi_ad9361/l_clk axi_ad9361/clk



ad_connect axi_ad9361/l_clk cpack/clk
ad_connect axi_ad9361/rst cpack/reset

ad_connect axi_ad9361/adc_enable_i1 cpack/enable_2
ad_connect axi_ad9361/adc_data_i1 pack8_2/din
ad_connect pack8_2/dout cpack/fifo_wr_data_2
ad_connect axi_ad9361/adc_enable_q1 cpack/enable_3
ad_connect axi_ad9361/adc_data_q1 pack8_3/din
ad_connect pack8_3/dout cpack/fifo_wr_data_3

ad_connect cpack/enable_0 axi_ad9361/adc_enable_i0
ad_connect cpack/enable_1 axi_ad9361/adc_enable_q0
ad_connect axi_ad9361/adc_data_i0 pack8_0/din
ad_connect pack8_0/dout cpack/fifo_wr_data_0
ad_connect axi_ad9361/adc_data_q0 pack8_1/din
ad_connect pack8_1/dout cpack/fifo_wr_data_1
ad_connect axi_ad9361/adc_valid_i0 cpack/fifo_wr_en

# isdbt v2b: cpack → dma_mux → DMA
ad_connect cpack/packed_fifo_wr_en dma_mux/a_wr_en
ad_connect cpack/packed_fifo_wr_data dma_mux/a_wr_data
ad_connect cpack/packed_sync dma_mux/a_sync
ad_connect dma_mux/a_overflow cpack/packed_fifo_wr_overflow
ad_connect dma_mux/fifo_wr_en axi_ad9361_adc_dma/fifo_wr_en
ad_connect dma_mux/fifo_wr_din axi_ad9361_adc_dma/fifo_wr_din
ad_connect axi_ad9361_adc_dma/fifo_wr_overflow dma_mux/fifo_wr_overflow
ad_connect axi_ad9361/isdbt_mode dma_mux/mode
ad_connect fe_out/dma_wr_en dma_mux/b_wr_en
ad_connect fe_out/dma_wr_data dma_mux/b_wr_data

# isdbt v2b: 前段の配線（l_clk ドメイン）
ad_connect axi_ad9361/l_clk fe_win/clk
ad_connect axi_ad9361/l_clk fe_out/clk
ad_connect axi_ad9361/l_clk fe_fft/aclk
ad_connect axi_ad9361/rst fe_win/rst
ad_connect axi_ad9361/rst fe_out/rst
ad_connect axi_ad9361/isdbt_mode fe_out/mode
ad_connect axi_ad9361/isdbt_mode fe_win/mode
ad_connect axi_ad9361/isdbt_mode fe_sync/mode
ad_connect axi_ad9361/isdbt_mode fe_rot/mode
ad_connect axi_ad9361/isdbt_win_stride fe_win/stride
ad_connect axi_ad9361/isdbt_win_offset fe_win/offset
ad_connect axi_ad9361/isdbt_win_decim fe_win/decim
# 生ストリーム → CORDIC 逆回転（NCO 位相は fe_sync）→ 窓エンジン。サンプル番号も同じ遅延で通す
ad_connect axi_ad9361/l_clk fe_rot/clk
ad_connect axi_ad9361/adc_valid_i0 fe_rot/valid_in
ad_connect axi_ad9361/adc_data_i0 fe_rot/x_in
ad_connect axi_ad9361/adc_data_q0 fe_rot/y_in
ad_connect fe_sync/nco_phase fe_rot/phase_in
ad_connect fe_corr_idx/Dout fe_rot/idx_in
ad_connect fe_rot/valid_out fe_win/adc_valid
ad_connect fe_rot/x_out fe_win/adc_i
ad_connect fe_rot/y_out fe_win/adc_q
ad_ip_instance xlconcat fe_idx_cat
ad_ip_parameter fe_idx_cat CONFIG.NUM_PORTS 2
ad_ip_parameter fe_idx_cat CONFIG.IN0_WIDTH 32
ad_ip_parameter fe_idx_cat CONFIG.IN1_WIDTH 32
ad_ip_instance xlconstant fe_zero32
ad_ip_parameter fe_zero32 CONFIG.CONST_WIDTH 32
ad_ip_parameter fe_zero32 CONFIG.CONST_VAL 0
ad_connect fe_rot/idx_out fe_idx_cat/In0
ad_connect fe_zero32/dout fe_idx_cat/In1
ad_connect fe_idx_cat/dout fe_win/sample_count
ad_connect fe_sync/start_valid fe_win/start_valid
ad_connect fe_sync/start_pos fe_win/start_pos
ad_connect fe_sync/tim_delta fe_win/start_delta
ad_connect fe_sync/tim_delta axi_ad9361/isdbt_tim_delta
ad_connect fe_sync/tim_est axi_ad9361/isdbt_tim_est
# GI 相関（8bit = pack8 出力）→ 同期
ad_connect axi_ad9361/l_clk fe_corr/clk
ad_connect axi_ad9361/rst fe_corr/rst
ad_connect axi_ad9361/adc_valid_i0 fe_corr/valid_in
ad_connect pack8_0/dout fe_corr/i_in
ad_connect pack8_1/dout fe_corr/q_in

# ADC レベル計（isdbt v2b-3c: モード 3/4 中のソフト AGC 用。pack8 後の 8bit I/Q の I²+Q² を 65536 サンプル積算）
create_bd_cell -type module -reference isdbt_level fe_level
ad_connect axi_ad9361/l_clk fe_level/clk
ad_connect axi_ad9361/rst fe_level/rst
ad_connect axi_ad9361/adc_valid_i0 fe_level/valid
ad_connect pack8_0/dout fe_level/i_in
ad_connect pack8_1/dout fe_level/q_in
ad_connect fe_level/level axi_ad9361/isdbt_adc_level
ad_connect fe_corr_idx/Dout fe_corr/idx_in
ad_connect axi_ad9361/l_clk fe_sync/clk
ad_connect axi_ad9361/rst fe_sync/rst
ad_connect fe_margin/dout fe_sync/margin
ad_connect fe_corr/valid_out fe_sync/c_valid
ad_connect fe_corr/c_re fe_sync/c_re
ad_connect fe_corr/c_im fe_sync/c_im
ad_connect fe_corr/mag2 fe_sync/c_mag2
ad_connect fe_corr/idx_out fe_sync/c_idx
ad_connect axi_ad9361/adc_valid_i0 fe_sync/raw_valid
ad_connect fe_sync/cfo_inc fe_out/info_a
ad_connect fe_sync/status_word fe_out/info_b
ad_connect fe_sync/dbg_word axi_ad9361/isdbt_sync_status
ad_connect fe_sync/dbg_peak axi_ad9361/isdbt_sync_peak
ad_connect fe_win/cfg_tdata fe_fft/s_axis_config_tdata
ad_connect fe_win/cfg_tvalid fe_fft/s_axis_config_tvalid
ad_connect fe_fft/s_axis_config_tready fe_win/cfg_tready
ad_connect fe_win/s_tdata fe_fft/s_axis_data_tdata
ad_connect fe_win/s_tvalid fe_fft/s_axis_data_tvalid
ad_connect fe_win/s_tlast fe_fft/s_axis_data_tlast
ad_connect fe_fft/s_axis_data_tready fe_win/s_tready
ad_connect fe_fft/m_axis_data_tdata fe_out/m_tdata
ad_connect fe_fft/m_axis_data_tuser fe_out/m_tuser
ad_connect fe_fft/m_axis_data_tvalid fe_out/m_tvalid
ad_connect fe_fft/m_axis_data_tlast fe_out/m_tlast
ad_connect fe_win/hdr_start fe_out/hdr_start
ad_connect fe_win/hdr_seq fe_out/hdr_seq
ad_connect fe_win/hdr_valid fe_out/hdr_valid
ad_connect fe_out/hdr_pop fe_win/hdr_pop
ad_connect fe_win/overrun_count fe_status_cat/In0
ad_connect fe_out/fifo_overflow_count fe_status_cat/In1
ad_connect fe_status_cat/dout axi_ad9361/isdbt_fe_status
ad_connect fe_out/frames_out axi_ad9361/isdbt_fe_frames
# 等化器
ad_connect axi_ad9361/l_clk fe_eq/clk
ad_connect axi_ad9361/rst fe_eq/rst
ad_connect axi_ad9361/isdbt_mode fe_eq/mode
ad_connect axi_ad9361/isdbt_eq_ctrl fe_eq_cfo/Din
ad_connect axi_ad9361/isdbt_eq_ctrl fe_eq_flags/Din
ad_connect fe_eq_cfo/Dout fe_eq/int_cfo
ad_connect fe_eq_flags/Dout fe_eq/eq_flags
ad_connect fe_fft/m_axis_data_tdata fe_eq/m_tdata
ad_connect fe_fft/m_axis_data_tuser fe_eq/m_tuser
ad_connect fe_fft/m_axis_data_tvalid fe_eq/m_tvalid
ad_connect fe_fft/m_axis_data_tlast fe_eq/m_tlast
ad_connect fe_win/hdr_start fe_hdr_start_lo/Din
ad_connect fe_hdr_start_lo/Dout fe_eq/hdr_start
ad_connect fe_win/hdr_delta fe_eq/hdr_delta
ad_connect fe_win/hdr_delta fe_out/hdr_delta
ad_connect fe_eq/o_valid fe_out/eq_valid
ad_connect fe_out/eq_ready fe_eq/o_ready
ad_connect fe_eq/o_data fe_out/eq_data
ad_connect fe_eq/o_last fe_out/eq_last
ad_connect fe_eq/dbg_word axi_ad9361/isdbt_eq_status
ad_connect fe_eq/afc_omega axi_ad9361/isdbt_eq_omega



ad_connect  axi_ad9361/l_clk tx_upack/clk
ad_connect  axi_ad9361/rst tx_upack/reset

ad_connect  tx_upack/fifo_rd_data_0  axi_ad9361/dac_data_i0
ad_connect  tx_upack/enable_0  axi_ad9361/dac_enable_i0
ad_connect  tx_upack/fifo_rd_data_1  axi_ad9361/dac_data_q0
ad_connect  tx_upack/enable_1  axi_ad9361/dac_enable_q0

ad_connect axi_ad9361/dac_enable_i1 tx_upack/enable_2
ad_connect axi_ad9361/dac_data_i1 tx_upack/fifo_rd_data_2
ad_connect axi_ad9361/dac_enable_q1 tx_upack/enable_3
ad_connect axi_ad9361/dac_data_q1 tx_upack/fifo_rd_data_3

ad_connect tx_upack/s_axis  axi_ad9361_dac_dma/m_axis


ad_connect  axi_ad9361/dac_valid_i0  tx_upack/fifo_rd_en
ad_connect  tx_upack/fifo_rd_underflow axi_ad9361/dac_dunf


ad_connect  axi_ad9361/l_clk axi_ad9361_adc_dma/fifo_wr_clk
ad_connect  axi_ad9361/l_clk axi_ad9361_dac_dma/m_axis_aclk
ad_connect  cpack/fifo_wr_overflow axi_ad9361/adc_dovf

# External TDD

# isdbt v2b-3c: xfft のリセットは fe_win が出す（モード 0 の間は保持し、再開時に設定を送り直す）
ad_connect fe_win/fft_aresetn fe_fft/aresetn
# isdbt v2b-2c: TDD コアを外したので DMA の sync は常時 1
ad_connect VCC axi_ad9361_adc_dma/sync
ad_connect VCC axi_ad9361_dac_dma/sync

# interconnects

ad_cpu_interconnect 0x79020000 axi_ad9361
ad_cpu_interconnect 0x7C400000 axi_ad9361_adc_dma
ad_cpu_interconnect 0x7C420000 axi_ad9361_dac_dma

ad_ip_parameter sys_ps7 CONFIG.PCW_USE_S_AXI_HP1 {1}
ad_connect sys_cpu_clk sys_ps7/S_AXI_HP1_ACLK
ad_connect axi_ad9361_adc_dma/m_dest_axi sys_ps7/S_AXI_HP1

create_bd_addr_seg -range 0x20000000 -offset 0x00000000 \
                    [get_bd_addr_spaces axi_ad9361_adc_dma/m_dest_axi] \
                    [get_bd_addr_segs sys_ps7/S_AXI_HP1/HP1_DDR_LOWOCM] \
                    SEG_sys_ps7_HP1_DDR_LOWOCM

ad_ip_parameter sys_ps7 CONFIG.PCW_USE_S_AXI_HP2 {1}
ad_connect sys_cpu_clk sys_ps7/S_AXI_HP2_ACLK
ad_connect axi_ad9361_dac_dma/m_src_axi sys_ps7/S_AXI_HP2

create_bd_addr_seg -range 0x20000000 -offset 0x00000000 \
                    [get_bd_addr_spaces axi_ad9361_dac_dma/m_src_axi] \
                    [get_bd_addr_segs sys_ps7/S_AXI_HP2/HP2_DDR_LOWOCM] \
                    SEG_sys_ps7_HP2_DDR_LOWOCM

ad_connect sys_cpu_clk axi_ad9361_dac_dma/m_src_axi_aclk
ad_connect sys_cpu_clk axi_ad9361_adc_dma/m_dest_axi_aclk
ad_connect sys_cpu_resetn axi_ad9361_adc_dma/m_dest_axi_aresetn
ad_connect sys_cpu_resetn axi_ad9361_dac_dma/m_src_axi_aresetn

# interrupts

ad_cpu_interrupt ps-13 mb-13 axi_ad9361_adc_dma/irq
ad_cpu_interrupt ps-12 mb-12 axi_ad9361_dac_dma/irq

