#      author: ZiLin (as2648as)
# script-name: power-options
# last-update: 2024-11-18
#
# reference: https://ss64.com/nt/powercfg.html
#
# 若電源選項GUID被變更, 可以取消註釋下方的指令來查看GUID
#
# 查看所有電源選項GUID
# powercfg /l
#
# 查看所有選項別名
# powercfg /ALIASES
# @pause
#
# 詳細可用選項使用 powercfg /? 查看

# GUID
# $Scheme_GUID = "e9a42b02-d5df-448d-aa00-03f14749eb61" # 終極效能
# $Scheme_GUID = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" # 高效能
#
# 切換電源計畫
# powercfg -s $Scheme_GUID

Write-Host "===== 設置電源選項 =====`n"

$monitorTimeout = 3    # 在幾分鐘後關閉螢幕，設定 0 分鐘為永不
$standbyTimeout = 10   # 在幾分鐘後讓電腦睡眠，設定 0 分鐘為永不
$hibernateTimeout = 10 # 在幾分鐘後讓電腦休眠，設定 0 分鐘為永不

Write-Host 關閉「休眠功能」
powercfg -h off

Write-Host 設定「關閉顯示器」為 永不

Powercfg -x -monitor-timeout-ac $monitorTimeout # PC
Powercfg -x -monitor-timeout-dc $monitorTimeout # Notebook

Write-Host 設定「讓電腦睡眠」為 永不
powercfg -x -standby-timeout-dc $standbyTimeout # PC
powercfg -x -standby-timeout-ac $standbyTimeout # Notebook

# Write-Host 設定「讓電腦休眠」為 永不
# powercfg -x -hibernate-timeout-dc $hibernateTimeout # PC
# powercfg -x -hibernate-timeout-ac $hibernateTimeout # Notebook

Write-Host "`n電源選項設置完成`n"