using module ".\Modules\RegistryTools.psm1"

<# ===== Getting Administrator ===== #>

$IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $IsAdmin) {
    $Message = @"

===== 注意 =====

目前 PowerShell 執行原則為：$ExecutionPolicy
此腳本需要將執行原則設為 Unrestricted 才能正常運作。

請以【系統管理員】權限執行下列指令：
--------------------------------------------------
Set-ExecutionPolicy Unrestricted -Force
--------------------------------------------------

完成後，請重新執行此腳本。

按下任意鍵繼續

"@

    Write-Host $Message -ForegroundColor Yellow

    $null = $Host.UI.RawUI.ReadKey('NoEcho, IncludeKeyDown')

    Start-Process powershell -Verb RunAs -ArgumentList "-File `"$PSCommandPath`""

    Exit
}

Set-Location "$PSScriptRoot"

<# ===== Script Run ===== #>

$scripts = @(
    <# 鍵盤滑鼠設定 #>
    "AddEnglishLanguage"                   # 增加鍵盤語言 (en-US)
    "DisableIdiotKeyboardSetting"          # 關閉 Windows 惱人的鍵盤設定（相黏鍵、篩選鍵、切換鍵）
    # "DisableLeftShiftChangeInputMode"      # 停用 「左 Shift 切換輸入法」
    "DisableMouseEnhancePointerPrecision"  # 取消 「增強鼠標的準確性」
    "EnableNumLockOnLogin"                 # 登入時啟用 NumLock
    "SetZhuInDefaultInputMode"             # 預設中文輸入模式為「英數模式」

    <# 個人化設定 #>
    "DisableUACConsentPromptBehaviorAdmin" # 關閉 UAC 管理員同意提示
    "DisableSecurityNotify"                # 關閉安全性警告通知
    "EnableDarkMode"                       # 啟用深色模式
    "ExplorerBasicSetting"                 # 檔案總管基本設定
    "SetClassicRightClickMenu"             # 將右鍵還原為舊版樣式
    "SetStartMenuAtLeft"                   # 將開始功能表設為左側
    "SnapBasicSetting"                     # 停用 [貼齊視窗] 的所有子項目
    "TaskbarWindowMonitor"                 # 將 「使用多個顯示器時，在以下位置顯示我的工作列應用程式」 設定為 「視窗開啟所在工作列」
    "TurnOffTaskbarCrapRemind"             # 關閉小工具提醒
    "WallpaperRemind"                      # 設定桌布提醒
    "ApplyLGPO"                            # 套用 LGPO 設定
    "SetUserFolder"                        # 設定使用者資料夾
    "SetWinToolsPath"                      # 將 WinTools 加入環境變數 PATH
)

$scripts | ForEach-Object {
    if (-not (Test-Path ".\Scripts\$_.ps1")) {
        throw "找不到腳本檔案：Scripts\$_.ps1"
    }
}

Write-Host @"

======================================
            開始執行腳本
======================================

"@ -ForegroundColor Cyan

$registryEditor = [RegistryEditor]::new()

$scriptCount = $scripts.Count
$paddingWidth = $scriptCount.ToString().Length

for ($i = 0; $i -lt $scripts.Count; $i++) {
    $script = $scripts[$i]
    $currentIndex = ($i + 1).ToString("D$paddingWidth")

    Write-Host "[$currentIndex/$scriptCount] $script - " -NoNewline

    $ErrorMessage = & (".\Scripts\$script.ps1") -RegistryEditor $registryEditor

    if ($null -eq $ErrorMessage) {
        Write-Host "[OK]" -ForegroundColor Green
    }
    else {
        Write-Host "[$ErrorMessage]" -ForegroundColor Red
    }
}

Write-Host "`n[RegistryEditor] 正在套用登錄檔變更，請稍候... - " -NoNewline

$registryEditor.Apply()

Write-Host "OK" -ForegroundColor Green

Write-Host @"

======================================
            所有項目完成！
======================================

"@ -ForegroundColor Cyan

Write-Host "按下任意鍵退出`n"

$null = $Host.UI.RawUI.ReadKey('NoEcho, IncludeKeyDown');
