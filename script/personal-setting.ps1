#      author: ZiLin (as2648as)
# script-name: personal-setting
# last-update: 2024-11-18

Write-Host "===== 設置個人化設定 =====`n"

<# ===== 桌面/主畫面設定 ===== #>

Write-Host 啟用「深色主題」
@(
    "AppsUseLightTheme"
    "SystemUsesLightTheme"
) | ForEach-Object { New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "$_" -Value "0" -PropertyType DWORD -Force | Out-Null }

# Write-Host 桌面顯示「我的電腦」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value "0" -PropertyType DWORD -Force | Out-Null

<# ===== 關於惱人的事物設定 ===== #>

Write-Host 設定「登入時 NumLock 啟用」
New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Value "2" -PropertyType String -Force | Out-Null
New-ItemProperty -Path "Registry::HKEY_USERS\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Value "2" -PropertyType String -Force | Out-Null

Write-Host 設定「Edge Alt + Tab 僅限開啟視窗」
New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Value "3" -PropertyType DWORD -Force | Out-Null

<# ===== 輸入法設定 ===== #>

Write-Host 預設中文輸入模式為「英數模式」
New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\IME\15.0\IMETC" -Name "Default Input Mode" -Value "0x00000001" -PropertyType String -Force | Out-Null

<# ===== 可以靠 Optimizer 完成的工作 ===== #>

# Write-Host 啟用「工作列位置 - 置左」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value "0" -PropertyType "DWORD" -Force

# Write-Host 設定「將右鍵還原為舊版樣式」
# New-Item -Path "Registry::HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Name "InprocServer32" -Value "" -Force | Out-Null

# Write-Host 開啟「顯示檔案副檔名」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value "0" -PropertyType DWORD -Force | Out-Null

# Write-Host 開啟「顯示隱藏的項目」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value "1" -PropertyType DWORD -Force | Out-Null

# Write-Host 設定「開啟檔案總管為本機」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value "1" -PropertyType DWORD -Force | Out-Null

# Write-Host 關閉「在[快速存取]中顯示最近使用的檔案」
# Write-Host 關閉「在[快速存取]中顯示經常使用的資料夾」
# @(
#     "ShowFrequent"
#     "ShowRecent"
# ) | ForEach-Object { New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "$_" -Value "0" -PropertyType DWORD -Force | Out-Null }

# Write-Host 關閉「工作列的搜尋框」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value "0" -PropertyType DWORD -Force | Out-Null

# Write-Host 關閉「聊天」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value "0" -PropertyType DWORD -Force | Out-Null

# Write-Host 關閉「小工具」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value "0" -PropertyType DWORD -Force | Out-Null

# Write-Host 關閉「工作列的工作檢視」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "0" -PropertyType DWORD -Force | Out-Null

# Write-Host 關閉「新聞和興趣」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value "2" -PropertyType DWORD -Force | Out-Null

# Write-Host 關閉「 Shift 相黏鍵 」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "506" -PropertyType String -Force | Out-Null

# Write-Host 關閉「 NumLock 切換鍵 」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Value "122" -PropertyType String -Force | Out-Null

# Write-Host 關閉「 Shift 篩選鍵 」
# New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value "58" -PropertyType String -Force | Out-Null

Stop-Process -Name explorer -Force
Start-Sleep 1

Write-Host "`n個人化設定設置完成`n"