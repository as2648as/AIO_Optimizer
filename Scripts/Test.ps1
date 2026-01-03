# ==============================================================
# Author      : ZiLin
# Name        : Test
# Description : 測試腳本
# LastUpdate  : 2026-01-02
# ==============================================================

for ($i = 0; $i -lt 5; $i++) {
    try {
        Set-ItemProperty -Path "HKCU:\Test" -Name "" -Value "Test" -Force
    }
    catch {
        Return $_.Exception.Message
    }
}

Return
