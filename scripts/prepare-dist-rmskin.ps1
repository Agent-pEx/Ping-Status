param(
    [Parameter(Mandatory = $true)]
    [string]$Version
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$distDir = Join-Path $repoRoot "dist"

$rmskins = @(Get-ChildItem -LiteralPath $repoRoot -Filter "*.rmskin" -File -ErrorAction SilentlyContinue |
    Where-Object { $_.DirectoryName -eq $repoRoot })

if ($rmskins.Count -eq 0) {
    Write-Error "No .rmskin file in repo root ($repoRoot). Build one in Rainmeter, then copy the file here or run this script again."
    exit 1
}

if ($rmskins.Count -gt 1) {
    Write-Warning "Multiple .rmskin files in root; using: $($rmskins[0].Name)"
}

New-Item -ItemType Directory -Force -Path $distDir | Out-Null
$destName = "Ping-Status-by-A-pEx-v$Version.rmskin"
$destPath = Join-Path $distDir $destName

Copy-Item -LiteralPath $rmskins[0].FullName -Destination $destPath -Force
Write-Host "Copied to: $destPath"
Write-Host "Next: git add dist/ ; commit ; push ; attach this file to the GitHub Release for tag v$Version."
