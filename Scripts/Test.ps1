# ==============================================================
# Author      : ZiLin
# Name        : Test
# Description : 測試腳本
# LastUpdate  : 2026-01-02
# ==============================================================

using module "..\Modules\InstallAgent.psm1"

# 紀錄父目錄
$parentPath = Get-Location

# 切換到腳本目錄
Set-Location "$PSScriptRoot"

# 確認 Installers 目錄存在
$InstallerPath = Test-Path -Path "..\Installers"

if (!$InstallerPath) {
    Set-Location "$parentPath"
    Return "找不到 Installers 目錄"
}

# 回到父目錄
Set-Location "$parentPath"

Return
