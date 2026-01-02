# ==============================================================
# Author      : ZiLin
# Name        : Set Classic Right Click Menu
# Description : 將右鍵還原為舊版樣式
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegisterEditor)

try {
    # 還原舊版右鍵選單
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}",
            @{
                "InprocServer32" = ""
            },
            $true
        )
    )

    # 移除 [還原舊版]
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked",
            @{
                "{596AB062-B4D2-4215-9F74-E9109B0A8153}" = "Restore Previous Versions - 還原舊版"
            },
            $true
        )
    )

    # 移除 [共用]
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked",
            @{
                "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" = "Sharing - 共用"
            },
            $true
        )
    )

    # 移除 [傳送至]
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked",
            @{
                "{7BA4C740-9E81-11CF-99D3-00AA004AE837}" = "SendTo - 傳送至"
            },
            $true
        )
    )

    # 移除 [列印]
    @(
        "Registry::HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\print"
        "Registry::HKEY_CLASSES_ROOT\batfile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\cmdfile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\fonfile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\htmlfile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\JSEFile\Shell\Print"
        "Registry::HKEY_CLASSES_ROOT\otffile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\pfmfile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\regfile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\ttcfile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\ttffile\shell\print"
        "Registry::HKEY_CLASSES_ROOT\VBEFile\Shell\Print"
        "Registry::HKEY_CLASSES_ROOT\VBSFile\Shell\Print"
        "Registry::HKEY_CLASSES_ROOT\WSFFile\Shell\Print"
    ) | ForEach-Object {
        $registryEditor.AddSetting(
            [RegistrySetting]::new(
                $_,
                @{
                    "ProgrammaticAccessOnly" = ""
                },
                $true
            )
        )
    }
}
catch {
    Return $_.Exception.Message
}

Return
