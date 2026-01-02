# ==============================================================
# Author      : ZiLin
# Name        : Turn Off Taskbar Crap Remind
# Description : 關閉工作列垃圾提醒
# LastUpdate  : 2026-01-02
# ==============================================================

$Remind = @"
由於系統權限限制，請在開啟的設定視窗中手動完成以下動作：

1. 關閉「小工具」
1. 關閉「工作檢視」
2. 將「搜尋」改為「隱藏」
"@

$CheckList = @(
    @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"; Name = "SearchboxTaskbarMode"; Expected = 0; Label = "搜尋框" }
    @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "TaskbarDa"; Expected = 0; Label = "小工具" }
    @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"; Name = "ShowTaskViewButton"; Expected = 0; Label = "工作檢視" }
)

$InvalidItems = $CheckList | Where-Object {
    (Get-RegistryValue -Path $_.Path -Name $_.Name) -ne $_.Expected
}

if ($null -ne $InvalidItems) {
    Start-Process "ms-settings:taskbar"

    Add-Type -AssemblyName Microsoft.VisualBasic
    [void][Microsoft.VisualBasic.Interaction]::MsgBox($Remind, "OKOnly,SystemModal,Information", "【手動操作提醒】")
}

Return
