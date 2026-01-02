# ==============================================================
# Author      : ZiLin
# Name        : Disable Left Shift Change Input Mode
# Description : 設定 [注音輸入法] 左 shift 不切換輸入模式
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Software\Microsoft\IME\15.0\IMETC",
            @{
                "Left Shift Usage" = "0x00000002"
            },
            $false
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
