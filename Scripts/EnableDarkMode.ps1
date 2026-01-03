# ==============================================================
# Author      : ZiLin
# Name        : Enable Dark Mode
# Description : 啟用 Windows 深色主題
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegistryEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize",
            @{
                "AppsUseLightTheme"    = 0
                "SystemUsesLightTheme" = 0
            },
            $true
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
