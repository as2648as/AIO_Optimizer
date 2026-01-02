# ==============================================================
# Author      : ZiLin
# Name        : Explorer Basic Settings
# Description : 設定 Explorer 基本選項
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
            @{
                "HideFileExt" = 0
                "Hidden"      = 1
                "LaunchTo"    = 1
            },
            $true
        )
    )

    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer",
            @{
                "ShowFrequent" = 0
                "ShowRecent"   = 0
            },
            $true
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
