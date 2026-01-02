# ==============================================================
# Author      : ZiLin
# Name        : Snap Basic
# Description : 停用 [貼齊視窗] 的所有子項目
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
            @{
                "SnapAssist"             = 0
                "EnableSnapAssistFlyout" = 0
                "EnableSnapBar"          = 0
                "EnableTaskGroups"       = 0
                "DITest"                 = 0
            },
            $true
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
