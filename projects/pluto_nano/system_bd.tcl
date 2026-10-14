###############################################################################
## Copyright (C) 2014-2024 Analog Devices, Inc. All rights reserved.
### SPDX short identifier: ADIBSD
###############################################################################

# create board design
source $ad_hdl_dir/projects/common/xilinx/adi_fir_filter_bd.tcl
source $ad_hdl_dir/library/axi_tdd/scripts/axi_tdd.tcl

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

create_bd_port -dir O spi_csn_o
create_bd_port -dir I spi_csn_i
create_bd_port -dir I spi_clk_i
create_bd_port -dir O spi_clk_o
create_bd_port -dir I spi_sdo_i
create_bd_port -dir O spi_sdo_o
create_bd_port -dir I spi_sdi_i

create_bd_port -dir O txdata_o
create_bd_port -dir I tdd_ext_sync

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

ad_ip_instance axi_quad_spi axi_spi
ad_ip_parameter axi_spi CONFIG.C_USE_STARTUP 0
ad_ip_parameter axi_spi CONFIG.C_NUM_SS_BITS 1
ad_ip_parameter axi_spi CONFIG.C_SCK_RATIO 8

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

ad_connect  sys_cpu_clk  axi_spi/ext_spi_clk
ad_connect  spi_csn_i  axi_spi/ss_i
ad_connect  spi_csn_o  axi_spi/ss_o
ad_connect  spi_clk_i  axi_spi/sck_i
ad_connect  spi_clk_o  axi_spi/sck_o
ad_connect  spi_sdo_i  axi_spi/io0_i
ad_connect  spi_sdo_o  axi_spi/io0_o
ad_connect  spi_sdi_i  axi_spi/io1_i

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

# nano: I2C のピンは未同定なので IOBUF 付き inout ではなく i/o/t の個別ポートで出し、
# system_top で内部的に終端する（ドライバが触っても PL 外には何も出ない）
foreach p {scl sda} {
  create_bd_port -dir I iic_${p}_i
  create_bd_port -dir O iic_${p}_o
  create_bd_port -dir O iic_${p}_t
}

ad_ip_instance axi_iic axi_iic_main

foreach p {scl sda} {
  ad_connect iic_${p}_i axi_iic_main/${p}_i
  ad_connect iic_${p}_o axi_iic_main/${p}_o
  ad_connect iic_${p}_t axi_iic_main/${p}_t
}
ad_cpu_interconnect 0x41600000 axi_iic_main
ad_cpu_interrupt ps-15 mb-15 axi_iic_main/iic2intc_irpt

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
# isdbt v2b: 前段オフロード（まずは FFT テストモード）。窓切り出し → Xilinx FFT 8192 → ヘッダ付き DMA 出力。
# DMA の入力は dma_mux でモード 0（cpack = raw I/Q）とモード 1 以上（fe_out）を切り替える
add_files -norecurse $isdbt_rtl_dir/isdbt_fe_win.v
add_files -norecurse $isdbt_rtl_dir/isdbt_fe_out.v
add_files -norecurse $isdbt_rtl_dir/isdbt_dma_mux.v
create_bd_cell -type module -reference isdbt_fe_win fe_win
create_bd_cell -type module -reference isdbt_fe_out fe_out
create_bd_cell -type module -reference isdbt_dma_mux dma_mux
ad_ip_instance xfft fe_fft
ad_ip_parameter fe_fft CONFIG.transform_length 8192
ad_ip_parameter fe_fft CONFIG.implementation_options pipelined_streaming_io
ad_ip_parameter fe_fft CONFIG.data_format fixed_point
ad_ip_parameter fe_fft CONFIG.input_width 16
ad_ip_parameter fe_fft CONFIG.phase_factor_width 16
ad_ip_parameter fe_fft CONFIG.scaling_options block_floating_point
ad_ip_parameter fe_fft CONFIG.rounding_modes convergent_rounding
ad_ip_parameter fe_fft CONFIG.output_ordering natural_order
ad_ip_parameter fe_fft CONFIG.throttle_scheme realtime
ad_ip_parameter fe_fft CONFIG.xk_index true
ad_ip_parameter fe_fft CONFIG.aresetn true
ad_ip_instance xlslice fe_mode_bit0
ad_ip_parameter fe_mode_bit0 CONFIG.DIN_WIDTH 4
ad_ip_parameter fe_mode_bit0 CONFIG.DIN_FROM 0
ad_ip_parameter fe_mode_bit0 CONFIG.DIN_TO 0
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
ad_connect axi_ad9361/isdbt_mode fe_mode_bit0/Din
ad_connect fe_mode_bit0/Dout fe_win/enable
ad_connect fe_mode_bit0/Dout fe_out/enable
ad_connect axi_ad9361/isdbt_mode fe_out/mode
ad_connect axi_ad9361/isdbt_win_stride fe_win/stride
ad_connect axi_ad9361/isdbt_win_offset fe_win/offset
ad_connect axi_ad9361/isdbt_win_decim fe_win/decim
ad_connect axi_ad9361/isdbt_sample_count fe_win/sample_count
ad_connect axi_ad9361/adc_valid_i0 fe_win/adc_valid
ad_connect axi_ad9361/adc_data_i0 fe_win/adc_i
ad_connect axi_ad9361/adc_data_q0 fe_win/adc_q
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
set TDD_CHANNEL_CNT 3
set TDD_DEFAULT_POL 0b110
set TDD_REG_WIDTH 32
set TDD_BURST_WIDTH 32
set TDD_SYNC_WIDTH 0
set TDD_SYNC_INT 0
set TDD_SYNC_EXT 1
set TDD_SYNC_EXT_CDC 1
ad_tdd_gen_create axi_tdd_0 $TDD_CHANNEL_CNT \
                            $TDD_DEFAULT_POL \
                            $TDD_REG_WIDTH \
                            $TDD_BURST_WIDTH \
                            $TDD_SYNC_WIDTH \
                            $TDD_SYNC_INT \
                            $TDD_SYNC_EXT \
                            $TDD_SYNC_EXT_CDC

ad_ip_instance util_vector_logic logic_inv [list \
  C_OPERATION {not} \
  C_SIZE 1]

ad_connect logic_inv/Op1  axi_ad9361/rst
ad_connect logic_inv/Res  axi_tdd_0/resetn
ad_connect logic_inv/Res  fe_fft/aresetn
ad_connect axi_ad9361/l_clk axi_tdd_0/clk
ad_connect axi_tdd_0/sync_in tdd_ext_sync
ad_connect axi_tdd_0/tdd_channel_0 txdata_o
ad_connect axi_tdd_0/tdd_channel_1 axi_ad9361_adc_dma/sync
ad_connect axi_tdd_0/tdd_channel_2 axi_ad9361_dac_dma/sync

# interconnects

ad_cpu_interconnect 0x79020000 axi_ad9361
ad_cpu_interconnect 0x7C400000 axi_ad9361_adc_dma
ad_cpu_interconnect 0x7C420000 axi_ad9361_dac_dma
ad_cpu_interconnect 0x7C430000 axi_spi
ad_cpu_interconnect 0x7C440000 axi_tdd_0

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
ad_cpu_interrupt ps-11 mb-11 axi_spi/ip2intc_irpt

