# ==============================================================
# Author      : ZiLin
# Name        : Wallpaper Remind
# Description : 設定桌布提醒
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

Start-Process "ms-settings:personalization-background"

$Remind = @"
【手動操作提醒】

由於系統權限限制，請在開啟的設定視窗中手動完成以下動作：

1. 設定桌布
"@

Add-Type -AssemblyName Microsoft.VisualBasic
[void][Microsoft.VisualBasic.Interaction]::MsgBox($Remind, "OKOnly,SystemModal,Information", "腳本執行通知")

Return
