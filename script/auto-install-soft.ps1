#      author: ZiLin (as2648as)
# script-name: auto-install-soft
# last-update: 2024-11-17

Write-Host "===== 自動安裝軟體 =====`n"

Get-ChildItem ".\Soft\*" -Include *.exe, *.msi |
Foreach-Object {
    # Write-Host $_.Name installing...
    Write-Host -noNewLine "$($_.Name) 安裝中..."

    # 7zip
    if ($_.Name.StartsWith("7z")) {
        Start-Process -Wait -FilePath $_.FullName -Args "/S"
    }

    # Java
    elseif ($_.Name.StartsWith("jre")) {
        Start-Process -Wait -FilePath $_.FullName -Args "/s"
    }

    # .NET 3.5 & VC++ 2005-2022
    elseif ($_.Name.StartsWith("VisualCppRedist_AIO_x86_x64") -or $_.Name.StartsWith("dotNetFx35W")) {
        Start-Process -Wait -FilePath $_.FullName -Args "/ai /gm2"
    }

    # Other
    else {
        Start-Process -Wait -FilePath $_.FullName
    }

    Write-Host "OK"
}

Write-Host "`n自動安裝軟體完成`n"
