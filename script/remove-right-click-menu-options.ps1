#      author: ZiLin (as2648as)
# script-name: remove-right-click-menu-options
# last-update: 2024-11-17

Write-Host "===== 右鍵雜項移除  =====`n"

New-Item -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions" -Name "Blocked" -Force | out-null

Write-Host "移除 `"還原舊版`""
New-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Value "Restore Previous Versions - 還原舊版" -Type String -Force | out-null

Write-Host "移除 `"共用`""
New-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" -Value "Share - 分享" -Type String -Force | out-null

Write-Host "移除 `"傳送至`"" # 原始值 {7BA4C740-9E81-11CF-99D3-00AA004AE837}
New-Item -Path "Registry::HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" -Value "" -Force | out-null

Write-Host "移除 `"使用`" Microsoft Defender 掃描..."
Remove-Item -Path "Registry::HKEY_CLASSES_ROOT\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}" -Force -Recurse -ErrorAction SilentlyContinue | out-null

Write-Host "移除 `"列印`""
@(
    "HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\print"
    "HKEY_CLASSES_ROOT\batfile\shell\print"
    "HKEY_CLASSES_ROOT\cmdfile\shell\print"
    "HKEY_CLASSES_ROOT\fonfile\shell\print"
    "HKEY_CLASSES_ROOT\htmlfile\shell\print"
    "HKEY_CLASSES_ROOT\JSEFile\Shell\Print"
    "HKEY_CLASSES_ROOT\otffile\shell\print"
    "HKEY_CLASSES_ROOT\pfmfile\shell\print"
    "HKEY_CLASSES_ROOT\regfile\shell\print"
    "HKEY_CLASSES_ROOT\ttcfile\shell\print"
    "HKEY_CLASSES_ROOT\ttffile\shell\print"
    "HKEY_CLASSES_ROOT\VBEFile\Shell\Print"
    "HKEY_CLASSES_ROOT\VBSFile\Shell\Print"
    "HKEY_CLASSES_ROOT\WSFFile\Shell\Print"
    # Windows 11 似乎沒有以下路徑
    # "HKEY_CLASSES_ROOT\docxfile\shell\print"
    # "HKEY_CLASSES_ROOT\inffile\shell\print"
    # "HKEY_CLASSES_ROOT\inifile\shell\print"
    # "HKEY_CLASSES_ROOT\rtffile\shell\print"
    # "HKEY_CLASSES_ROOT\txtfile\shell\print"
) | Foreach-Object {
    # Get-Item -Path "Registry::$_" -ErrorAction SilentlyContinue | New-ItemProperty -Name "ProgrammaticAccessOnly" -Value "" -Type String -Force | out-null
    Get-Item -Path "Registry::$_" | New-ItemProperty -Name "ProgrammaticAccessOnly" -Value "" -Type String -Force | out-null
}

# Windows 11 似乎沒有以下這些選項

# Write-Host 移除右鍵「疑難排解相容性」
# New-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{1d27f844-3a1f-4410-85ac-14651078412d}" -Value "Troubleshoot compatibility - 疑難排解相容性" -Type String -Force | out-null

# Write-Host 移除右鍵「授予存取權給」
# New-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" -Value "Give access to - 授予存取權給" -Type String -Force | out-null

# Write-Host 移除右鍵「加入至媒體櫃」
# Remove-Item -Path "Registry::HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location" -Force -Recurse -ErrorAction SilentlyContinue | out-null
# Remove-Item -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location" -Force -Recurse -ErrorAction SilentlyContinue | out-null

# Write-Host "移除右鍵「啟用BitLocker - encrypt-bde」"
# New-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Drive\shell\encrypt-bde" -Name "ProgrammaticAccessOnly" -Value "" -Type String -Force | out-null

# Write-Host "移除右鍵「啟用BitLocker - encrypt-bde-elev」"
# New-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Drive\shell\encrypt-bde-elev" -Name "ProgrammaticAccessOnly" -Value "" -Type String -Force | out-null

Write-Host "`n右鍵雜項移除完成`n"