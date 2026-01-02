# ==============================================================
# Author      : ZiLin
# Name        : Set ZhuIn Default Input Mode
# Description : 設定 [注音輸入法] 預設輸入模式 為 「英數字元」
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Software\Microsoft\IME\15.0\IMETC",
            @{
                "Default Input Mode" = "0x00000001"
            },
            $false
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
