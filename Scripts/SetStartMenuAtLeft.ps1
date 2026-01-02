# ==============================================================
# Author      : ZiLin
# Name        : Set Start Menu At Left
# Description : 將開始功能表設為左側
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
            @{
                "TaskbarAl" = 0
            },
            $true
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
