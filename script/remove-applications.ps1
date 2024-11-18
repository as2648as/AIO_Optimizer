#      author: W4RH4WK, ZiLin (as2648as)
# script-name: remove-applications
# last-update: 2024-11-18
#
# reference: https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-default-apps.ps1

Write-Host "===== 移除無用軟體 =====`n"

$apps = @(
    <# 用不到的東西 #>
    "Microsoft.BingNews"                     # 新聞
    "Microsoft.BingSearch"                   # 搜尋
    "Microsoft.BingWeather"                  # 天氣
    "MicrosoftWindows.Client.WebExperience"  # 小工具
    "Microsoft.GetHelp"                      # 取得幫助
    "Microsoft.ZuneMusic"                    # 媒體播放器
    "Microsoft.WindowsFeedbackHub"           # 意見反映中樞
    "Clipchamp.Clipchamp"                    # Clipchamp (影片剪輯)
    "Microsoft.Windows.DevHome"              # DevHome 開發首頁
    "Microsoft.Todos"                        # Microsoft 代辦事項
    "MSTeams"                                # Microsoft Teams
    "Microsoft.MicrosoftOfficeHub"           # Office Hub
    "Microsoft.PowerAutomateDesktop"         # PowerAutomate
    "Microsoft.MicrosoftSolitaireCollection" # SolitaireCollection 遊戲
    "Microsoft.WindowsCamera"                # Windows 相機
    "Microsoft.WindowsSoundRecorder"         # Windows 錄音機

    <# 好東西 #>
    # "Microsoft.Windows.Photos"               # 相片
    # "Microsoft.WindowsAlarms"                # 時鐘
    # "Microsoft.Paint"                        # 小畫家
    # "Microsoft.WindowsCalculator"            # 計算機
    # "Microsoft.ScreenSketch"                 # 剪取工具
    # "Microsoft.MicrosoftStickyNotes"         # 自黏便箋
    # "Microsoft.WindowsNotepad"               # Notepad
    # "Microsoft.WindowsStore"                 # Windows Store
    # "Microsoft.WindowsTerminal"              # Windows Terminal
    # "Microsoft.YourPhone"                    # 手機連結
    # "MicrosoftWindows.CrossDevice"           # 手機連結 (依賴項目)
    # "MicrosoftCorporationII.QuickAssist"     # 快速助手 (遠端連線)
    # "Microsoft.OutlookForWindows"            # Office Outlook
    # "NVIDIACorp.NVIDIAControlPanel"          # NVIDIA 控制面板

    <# 移除可能造成問題 #>
    # "Microsoft.ApplicationCompatibilityEnhancements"
    # "Microsoft.AVCEncoderVideoExtension"
    # "Microsoft.HEIFImageExtension"
    # "Microsoft.HEVCVideoExtension"
    # "Microsoft.RawImageExtension"
    # "Microsoft.VP9VideoExtensions"
    # "Microsoft.WebMediaExtensions"
    # "Microsoft.WebpImageExtension"
    # "Microsoft.MPEG2VideoExtension"
    # "Microsoft.Xbox.TCUI"
    # "Microsoft.XboxGamingOverlay"
    # "Microsoft.XboxIdentityProvider"
    # "Microsoft.XboxSpeechToTextOverlay"
    # "Microsoft.AV1VideoExtension"
    # "Microsoft.DesktopAppInstaller"
    # "Microsoft.GamingApp"
    # "Microsoft.MicrosoftEdge.Stable"
    # "Microsoft.SecHealthUI"
    # "Microsoft.StorePurchaseApp"
)

$appxProvisionedPackages = Get-AppxProvisionedPackage -Online

foreach ($app in $apps) {
    Write-Output "Trying to remove $app"

    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers

    ($appxProvisionedPackages).Where( {$_.DisplayName -EQ $app}) |
        Remove-AppxProvisionedPackage -Online
}

# Prevents Apps from re-installing
$cdm = @(
    "ContentDeliveryAllowed"
    "FeatureManagementEnabled"
    "OemPreInstalledAppsEnabled"
    "PreInstalledAppsEnabled"
    "PreInstalledAppsEverEnabled"
    "SilentInstalledAppsEnabled"
    "SubscribedContent-314559Enabled"
    "SubscribedContent-338387Enabled"
    "SubscribedContent-338388Enabled"
    "SubscribedContent-338389Enabled"
    "SubscribedContent-338393Enabled"
    "SubscribedContentEnabled"
    "SystemPaneSuggestionsEnabled"
)

New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -ItemType Directory -Force
foreach ($key in $cdm) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" $key 0
}

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -ItemType Directory -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" "AutoDownload" 2

# Prevents "Suggested Applications" returning
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -ItemType Directory -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

Write-Host "`n無用軟體移除完成`n"