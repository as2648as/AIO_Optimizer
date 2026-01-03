# ==============================================================
# Author      : ZiLin
# Name        : Set User Folder
# Description : 設定使用者資料夾
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\RegistryTools.psm1"

param([RegistryEditor] $RegistryEditor)

$basePath = Read-Host "請輸入使用者資料夾的基底路徑 (例如：E:\User)"

Write-Host @"

這將會把您的使用者資料夾 (桌面、文件、圖片、音樂、影片、下載) 移動到該路徑下。
預覽：
    桌面    -> $basePath\Desktop
    文件    -> $basePath\Documents
    圖片    -> $basePath\Pictures
    音樂    -> $basePath\Music
    影片    -> $basePath\Videos
    下載    -> $basePath\Downloads

"@ -ForegroundColor Cyan

$confirmation = Read-Host "請輸入 Y 以確認，或其他任意鍵以取消"

Write-Host ""

if ($confirmation -ne 'Y' -and $confirmation -ne 'y') {
    Return "操作已取消"
}

foreach ($folder in @("Desktop", "Documents", "Pictures", "Music", "Videos", "Downloads")) {
    $target = Join-Path $basePath $folder
    if (!(Test-Path $target)) {
        try {
            New-Item -Path $target -ItemType Directory -ErrorAction Stop | Out-Null
        }
        catch {
            Return $_.Exception.Message
        }
    }
}

Return

try {
    $registryEditor.AddSetting(
        [RegistrySetting]::new(
            "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders",
            @{
                "Desktop"                                = "$basePath\Desktop"
                "Personal"                               = "$basePath\Documents"
                "My Pictures"                            = "$basePath\Pictures"
                "My Music"                               = "$basePath\Music"
                "My Video"                               = "$basePath\Videos"
                "{374DE290-123F-4565-9164-39C4925E467B}" = "$basePath\Downloads"
                "{7D83EE9B-2244-4E70-B1F5-5393042AF1E4}" = "$basePath\Downloads"
                "{754AC886-DF64-4CBA-86B5-F7F8FABF6CFE}" = "$basePath\Desktop"
                "{0DDD015D-B06C-45D5-8C4C-F59713854639}" = "$basePath\Pictures"
                "{3528A68A-3C57-41A1-BBB1-0EA7D37D6C95}" = "$basePath\Videos"
                "{A0C69A99-21C8-4671-8703-7934162CF1D}"  = "$basePath\Music"
                "{F42EE2D3-909F-4907-8871-4C22FC0BF756}" = "$basePath\Documents"
            },
            $true
        )
    )
}
catch {
    Return $_.Exception.Message
}

Return
