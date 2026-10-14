###############################################################################
## pluto_nano: ADI projects/pluto を PlutoSDR Nano（XC7Z010-CLG400）向けにしたもの。
## ブロックデザインは pluto と同一（../pluto/system_bd.tcl を使う）。
## 違いは部品（clg400）、トップ（未同定ポート削除）、ピン制約（バウンダリスキャン実測）。
## PS7 側のピン制約は Vivado 生成の system_sys_ps7_0.xdc をそのまま使う（pluto は無効化していた）。
###############################################################################

source ../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project_xilinx.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

adi_project_create pluto_nano 0 {} "xc7z010clg400-1"

adi_project_files pluto_nano [list \
  "system_top.v" \
  "system_constr.xdc" \
  "$ad_hdl_dir/library/common/ad_iobuf.v"]

adi_project_run pluto_nano
source $ad_hdl_dir/library/axi_ad9361/axi_ad9361_delay.tcl
