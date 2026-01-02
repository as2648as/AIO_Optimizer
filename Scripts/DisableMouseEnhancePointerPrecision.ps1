# ==============================================================
# Author      : ZiLin
# Name        : Disable Mouse Enhance Pointer Precision
# Description : 取消 「增強鼠標的準確性」
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Control Panel\Mouse",
            @{
                "MouseSpeed"      = "0"
                "MouseThreshold1" = "0"
                "MouseThreshold2" = "0"
            },
            $true
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
