#      author: ZiLin (as2648as)
# script-name: lgpo-setting
# last-update: 2024-11-17
#
# Get Windows Build Version:
#   10: https://en.wikipedia.org/wiki/Windows_10_version_history
#   11: https://en.wikipedia.org/wiki/Windows_11_version_history

Write-Host "===== LGPO 設定 =====`n"

# 取得 Windows Build 版本
$windows_version = (Get-ComputerInfo).WindowsProductName
$windows_build = [system.environment]::osversion.version.Build
$win10_builds = @(10240, 19045)
$win11_builds = @(22000, 26100)

Write-Host "當前版本: $windows_version, Build: $windows_build"

# Windows Build 非 Win10 & Win11
if ($windows_build -le $win10_builds[0]) {
    Write-Host "不支援目前的 Windows 版本，退出 LGPO 設定。"
    exit
}

# 不在 Win10 的 Build 區間，亦不在 Win11 的 Build 區間，應為新版的 Win11 版本
$isWin11 = if ($windows_build -ge $win10_builds[0] -and $windows_build -le $win10_builds[1]) { $false } else { $true }

if ($isWin11) {
    $file = "$PSScriptRoot\..\lgpo\profile\Win11"
    Write-Host "使用 Windows 11 的群組管理原則設定檔"

}
else {
    $file = "$PSScriptRoot\..\lgpo\profile\Win10"
    Write-Host "使用 Windows 10 的群組管理原則設定檔"
}

.\lgpo\LGPO.exe /r "$file.txt" /w "$file.pol"
.\lgpo\LGPO.exe /m "$file.pol"
.\lgpo\LGPO.exe /u "$file.pol"

gpupdate /force

Write-Host "`nLGPO 設定完成`n"