# ==============================================================
# Author      : ZiLin
# Name        : Apply LGPO
# Description : 套用 LGPO 設定
# LastUpdate  : 2026-01-03
# ==============================================================

$WindowsVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion

$ParentPath = Get-Location

Set-Location "$PSScriptRoot"

if ($WindowsVersion -ne "25H2") {
    Write-Host @"
========================================================
    注意：此 pol 僅實驗於 Windows 11 25H2 版本。
    您目前的版本為：$WindowsVersion
    無法保證腳本能正常運作，請自行斟酌是否繼續執行。
========================================================
"@ -ForegroundColor Yellow

    $confirmation = Read-Host "請輸入 Y 以確認，或其他任意鍵以取消"

    Write-Host ""

    if ($confirmation -ne 'Y' -and $confirmation -ne 'y') {
        Return "操作已取消"
    }
}

$LGPO_PATH = $null

if (Get-Command "LGPO.exe" -ErrorAction SilentlyContinue) {
    $LGPO_PATH = (Get-Command "LGPO.exe").Source
}
elseif (Test-Path (Join-Path $PSScriptRoot "..\LGPO.exe")) {
    $LGPO_PATH = "$ParentPath\LGPO.exe"
}
else {
    Set-Location $ParentPath
    Return "找不到 LGPO.exe"
}

# 刪除以套用的原則
# Remove-Item -Path "$env:SystemRoot\System32\GroupPolicy" -Recurse -Force
# Remove-Item -Path "$env:SystemRoot\System32\GroupPolicyUsers" -Recurse -Force

& $LGPO_PATH /m (Join-Path $PSScriptRoot "../LGPO/Win11_25H2.pol") *>$null
& $LGPO_PATH /u (Join-Path $PSScriptRoot "../LGPO/Win11_25H2.pol") *>$null

gpupdate /force | Out-Null

Set-Location $ParentPath
Return
