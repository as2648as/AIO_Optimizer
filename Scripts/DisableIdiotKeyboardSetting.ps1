# ==============================================================
# Author      : ZiLin
# Name        : Disable Idiot Keyboard Setting
# Description : 關閉 Windows 惱人的鍵盤設定（相黏鍵、篩選鍵、切換鍵）
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    # 關閉「Shift 相黏鍵」
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Control Panel\Accessibility\StickyKeys",
            @{
                "Flags" = "506"
            },
            $false
        )
    )

    # 關閉「Shift 篩選鍵」
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Control Panel\Accessibility\ToggleKeys",
            @{
                "Flags" = "58"
            },
            $false
        )
    )

    # 關閉「NumLock 切換鍵」
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Control Panel\Accessibility\Keyboard Response",
            @{
                "Flags" = "122"
            },
            $false
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
