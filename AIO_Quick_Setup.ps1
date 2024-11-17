# ===== Getting Adminitrator =====

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    Write-Host "`n"
    Write-Host "若腳本執行在時直接退出，"
    Write-Host "本請使用系統管理員開啟 Powershell`n並輸入："
    Write-Host "`"Set-ExecutionPolicy Unrestricted -Force`""
    Write-Host "指令再執行此腳本。`n"

    Write-Host "按下任意按鍵繼續..."

    $null = $Host.UI.RawUI.ReadKey('NoEcho, IncludeKeyDown')

    Start-Process powershell -verb runAs -ArgumentList ('-File', "$($myinvocation.MyCommand.Definition)")
    Exit
}

Set-Location "$PSScriptRoot"
Write-Host ""

# ===== Script Run =====

@(
    <# --------------------------------
        # 註解為停用腳本, 取消註解可啟用腳本
        # 注意腳本順序盡量不要隨意更動
    ---------------------------------- #>

    "add-en-US-keybroad-language"     # 新增鍵盤語言(en-US)
    "disable-services"                # 關閉服務
    "lgpo-setting"                    # LGPO 設定
    "remove-right-click-menu-options" # 右鍵雜項移除
    "auto-install-soft"               # 自動安裝軟體

    # "remove-onedrive"                 # 移除 OneDrive
    # "ethernet-interface-setting"      # 網路介面設定
    # "power-options"                   # 電源選項設定
    # "personal-setting"                # 個人化設置
) | ForEach-Object {
    .("$PSScriptRoot\script\$_.ps1")  # run script
}

# ===== End script =====

Write-Host "`n===== 設定完成 =====`n";
Write-Host "按下任意鍵退出";

$null = $Host.UI.RawUI.ReadKey('NoEcho, IncludeKeyDown');
