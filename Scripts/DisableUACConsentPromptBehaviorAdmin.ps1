# ==============================================================
# Author      : ZiLin
# Name        : Disable UAC Consent Prompt Behavior Admin
# Description : 關閉 UAC 管理員同意提示
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {

    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System",
            @{
                "ConsentPromptBehaviorAdmin" = 0
            },
            $false
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
