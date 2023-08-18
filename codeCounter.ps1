$continue = $true

while ($continue) {
    $rootPath = Read-Host "Please enter the rootPath (e.g., C:\path\to\your\root\directory)"

    # Check if the rootPath corresponds to a Git repository
    $isGitRepository = Test-Path (Join-Path -Path $rootPath -ChildPath ".git") -PathType Container

    if ($isGitRepository) {
        $projectFolder = Get-Item -Path $rootPath

        Write-Host ("Project Information for {0}" -f $projectFolder.Name)
        Write-Host "--------------------------"

        $codeStats = Count-CodeLines -path $projectFolder.FullName -extensions @(".html", ".css", ".js", ".ts", ".jsx", ".tsx")

        Write-Host ("Total Number of Files --> {0}" -f $codeStats.Files)
        Write-Host ("Total Number of Code Lines --> {0}" -f $codeStats.CodeLines)
    }
    else {
        function Count-CodeLines {
            param (
                [string]$path,
                [string[]]$extensions
            )

            $totalFiles = 0
            $totalCodeLines = 0

            Get-ChildItem -Path $path -Recurse -File | ForEach-Object {
                $extension = $_.Extension.ToLower()

                if ($extensions -contains $extension -and $_.FullName -notlike "*\node_modules\*") {
                    $totalFiles++
                    $codeLines = Get-Content $_.FullName | Where-Object { $_ -match '\S' }
                    $totalCodeLines += $codeLines.Count
                }
            }

            return @{
                Files = $totalFiles
                CodeLines = $totalCodeLines
            }
        }

        $projectFolders = Get-ChildItem -Path $rootPath -Directory

        foreach ($projectFolder in $projectFolders) {
            Write-Host ("Project Information for {0}" -f $projectFolder.Name)
            Write-Host "--------------------------"

            $codeStats = Count-CodeLines -path $projectFolder.FullName -extensions @(".html", ".css", ".js", ".ts", ".jsx", ".tsx")

            Write-Host ("Total Number of Files --> {0}" -f $codeStats.Files)
            Write-Host ("Total Number of Code Lines --> {0}" -f $codeStats.CodeLines)
            Write-Host ""
        }
    }

    $choice = Read-Host "Press 'E' to exit or 'N' for a new rootPath, then press Enter"
    if ($choice -eq "E" -or $choice -eq "e") {
        $continue = $false
    }
}
