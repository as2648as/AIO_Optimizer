# ==============================================================
# Author      : ZiLin
# Name        : Enable NumLock On Login
# Description : 在登入時自動啟用 NumLock
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Control Panel\Keyboard",
            @{
                "InitialKeyboardIndicators" = "2"
            },
            $false
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
