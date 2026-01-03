# ==============================================================
# Author      : ZiLin
# Name        : Setup WinTools Path
# Description : 將 Documents\WinTools 加入環境變數 PATH
# LastUpdate  : 2026-01-03
# ==============================================================

$ToolsFolderName = "WinTools"

try {
    $TargetDir = Join-Path ([Environment]::GetFolderPath("MyDocuments")) $ToolsFolderName

    if (-not (Test-Path $TargetDir)) {
        New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    }

    $UserPath = [Environment]::GetEnvironmentVariable("Path", "User")

    if (-not ($UserPath -split ';' -contains $TargetDir)) {
        $NewPath = "$UserPath;$TargetDir".Trim(';')
        [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    }
}
catch {
    Return $_.Exception.Message
}

Return
