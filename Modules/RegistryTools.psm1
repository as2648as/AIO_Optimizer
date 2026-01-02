class RegistrySetting {
    [string]$Path
    [hashtable]$Items
    [bool]$restartExplorer

    RegistrySetting([string]$p, [hashtable]$i, [bool]$r = $false) {
        $this.Path = $p
        $this.Items = $i
        $this.restartExplorer = $r
    }
}

class RegistryEditor {
    [System.Collections.Generic.List[RegistrySetting]]$settings = [System.Collections.Generic.List[RegistrySetting]]::new()

    [void]AddSetting([RegistrySetting]$setting) {
        $this.settings.Add($setting)
    }

    [void]Apply() {
        $shouldRestartExplorer = $false

        foreach ($entry in $this.settings) {
            $path = $entry.Path
            $items = $entry.Items

            if (-not (Test-Path $path)) {
                try {
                    New-Item -Path $path -Force -ErrorAction Stop | Out-Null
                }
                catch {
                    throw $_
                }
            }

            foreach ($item in $items.GetEnumerator()) {
                try {
                    Set-ItemProperty -Path $path -Name $item.Key -Value $item.Value -Force
                }
                catch {
                    throw $_
                }
            }

            if ($entry.restartExplorer) {
                $shouldRestartExplorer = $true
            }
        }

        if ($shouldRestartExplorer) {
            Stop-Process -Name explorer -Force
            Start-Process explorer
        }
    }
}

function Get-RegistryValue {
    param (
        [string]$Path,
        [string]$Name
    )

    try {
        $value = (Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop).$Name
        return $value
    }
    catch {
        throw $_
    }
}
