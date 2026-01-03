# ==============================================================
# Author      : ZiLin
# Name        : Disable MS-Gamebar Link Dialog
# Description : 停用 [無法開啟此ms-gamebar連結] 對話框
# LastUpdate  : 2026-01-03
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegistryEditor)

try {
    $RegistryEditor.AddSetting(
        [RegistrySetting]::new(
            "Registry::HKEY_CLASSES_ROOT\ms-gamebar",
            @{
                ""             = "URL:ms-gamebar"
                "URL Protocol" = ""
                "NoOpenWith"   = ""
            },
            $false
        )
    )

    $RegistryEditor.AddSetting(
        [RegistrySetting]::new(
            "Registry::HKEY_CLASSES_ROOT\ms-gamebar\shell\open\command",
            @{
                "" = "$env:SystemRoot\System32\systray.exe"
            },
            $false
        )
    )

    $RegistryEditor.AddSetting(
        [RegistrySetting]::new(
            "Registry::HKEY_CLASSES_ROOT\ms-gamebarservices",
            @{
                ""             = "URL:ms-gamebarservices"
                "URL Protocol" = ""
                "NoOpenWith"   = ""
            },
            $false
        )
    )

    $RegistryEditor.AddSetting(
        [RegistrySetting]::new(
            "Registry::HKEY_CLASSES_ROOT\ms-gamebarservices\shell\open\command",
            @{
                "" = "$env:SystemRoot\System32\systray.exe"
            },
            $false
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
