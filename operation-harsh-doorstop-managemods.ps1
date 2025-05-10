Set-Location -Path ".\operation-harsh-doorstop\950900"

$workshopDir = ".\steamapps\workshop\content\736590"
$ohdModsDir = ".\HarshDoorstop\Mods"

if (Test-Path $workshopDir) {
  Write-Output "Linking mods"
  Get-ChildItem -Path $workshopDir -Directory | ForEach-Object {
    $steamIdModDir = Join-Path -Path $workshopDir -ChildPath $_.Name
    
    # Write-Host
    # Write-Host "Parent Dirs:"
    # Write-Host $_.Name
    
    if (Test-Path -Path $steamIdModDir -PathType Container) {
        # Write-Host "has child directory" 
    } else {
        Continue
    }
    
    Get-ChildItem -Path $steamIdModDir -Directory | ForEach-Object {
        $modDir = Join-Path -Path $steamIdModDir -ChildPath $_.Name

        $symlinkName = Join-Path -Path $ohdModsDir -ChildPath $_.Name
    
        Write-Host "Made symlink for:" $symlinkName
        
        if (Test-Path -LiteralPath $symlinkName) {
            Remove-Item -LiteralPath $symlinkName -Force -Recurse
        }
        New-Item -ItemType Junction -Name $symlinkName -Target $modDir -Force | Out-Null
    }

  }
} else {
  Write-Output "No mods to link"
}

# exit 0