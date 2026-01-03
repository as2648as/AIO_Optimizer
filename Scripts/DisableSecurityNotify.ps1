# ==============================================================
# Author      : ZiLin
# Name        : Disable Security Notify
# Description : 停用安全性警告通知
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegistryEditor)

try {
    # 停用「顯示可能不安全檔案的安全性警告」
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3",
            @{
                "1806" = 0
            },
            $false
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
