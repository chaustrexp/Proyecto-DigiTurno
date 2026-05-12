$files = Get-ChildItem -Path "resources/views" -Filter "*.blade.php" -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    if ($content -match 'Trmite' -or $content -match 'Consultora' -or $content -match 'Formalizacin') {
        Write-Host "Fixing $($file.FullName)"
        $newContent = $content -replace 'Trmite', 'Trámite' `
                               -replace 'Consultora', 'Consultoría' `
                               -replace 'Formalizacin', 'Formalización'
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
    }
}
