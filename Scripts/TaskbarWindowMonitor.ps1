# ==============================================================
# Author      : ZiLin
# Name        : Taskbar Window Monitor
# Description : 將 「使用多個顯示器時，在以下位置顯示我的工作列應用程式」 設定為 「視窗開啟所在工作列」
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegistryEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
            @{
                "MMTaskbarMode" = 2
            },
            $true
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
