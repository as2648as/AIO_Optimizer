#      author: ZiLin (as2648as)
# script-name: disable-services
# last-update: 2024-11-17

Write-Host "===== 關閉服務 =====`n"

@(
    # 關閉蒐集資訊
    "DiagTrack"           # 使用者體驗蒐集 - Connected User Experiences and Telemetry
    "DPS"                 # Windows診斷跟蹤服務 - Diagnostic Policy Service
    "WdiSystemHost"       # Windows診斷跟蹤服務 - Diagnostic Service Host
    "WdiServiceHost"      # Windows診斷跟蹤服務 - Diagnostic System Home

    # 用不到的東西
    "BDESVC"              # BitLocker Drive Encryption Service
    "MapsBroker"          # 下載地圖管理 - Download Maps Manager
    "Fax"                 # 傳真服務 - Fax
    "WpcMonSvc"           # 家長監護
    "RetailDemo"          # 零售示範服務

    # 系統優化項目
    "BITS"                # 背景傳輸服務 - Background Intelligent Transfer Service
    "sdrsvc"              # 系統還原服務 - Windows Backup
    "SysMain"             # 維護和改進系統效能 - SysMain
    "WerSvc"              # 停止回應回報錯誤 - Windows Error Reporting Service

    # 可選
    # "BcastDVRUserService" # GameDVR及直播使用者服務
    # "WSearch"             # Windows搜尋 - Windows Search
    # "iphlpsvc"            # IPv6轉換 - IP Helper
    # "PhoneSvc"            # 管理手機狀態 - Phone Service
) | ForEach-Object {
    Write-Host -noNewLine "$_..."
    Get-Service -Name "$_"
    Stop-Service -Name "$_" -Force
    Set-Service -Name "$_" -StartupType Disabled
    Write-Host "OK"
}

Write-Host "`n關閉服務完成`n"
