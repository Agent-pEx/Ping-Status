# Creates or updates a GitHub Release for a tag and uploads dist/*.rmskin.
# Requires: $env:GITHUB_TOKEN with repo scope (classic: repo, or fine-grained: Contents + Releases on this repo).
# Usage:  $env:GITHUB_TOKEN = 'ghp_...'   .\scripts\publish-github-release.ps1 -Tag v1.0

param(
    [string]$Tag = "v1.0",
    [string]$RmskinName = "Ping-Status-by-A-pEx-v1.0.rmskin"
)

$ErrorActionPreference = "Stop"
$token = $env:GITHUB_TOKEN
if ([string]::IsNullOrWhiteSpace($token)) {
    throw "Set GITHUB_TOKEN (GitHub PAT). See: https://github.com/settings/tokens"
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$rmskinPath = Join-Path $repoRoot "dist\$RmskinName"
if (-not (Test-Path -LiteralPath $rmskinPath)) {
    throw "Missing file: $rmskinPath"
}

$owner = "Agent-pEx"
$repo = "Ping-Status-by-A-pEx"
$api = "https://api.github.com"
$headers = @{
    Authorization = "Bearer $token"
    Accept        = "application/vnd.github+json"
    "User-Agent"  = "Ping-Status-publish-script"
}

function Invoke-GitHub {
    param([string]$Method, [string]$Uri, $Body = $null)
    $params = @{ Uri = $Uri; Method = $Method; Headers = $headers }
    if ($null -ne $Body) {
        $params.ContentType = "application/json"
        $params.Body = ($Body | ConvertTo-Json -Compress -Depth 10)
    }
    return Invoke-RestMethod @params
}

function Test-NotFound {
    param($ErrorRecord)
    $resp = $ErrorRecord.Exception.Response
    if (-not $resp) { return $false }
    return $resp.StatusCode.value__ -eq 404
}

# Existing release for tag?
$release = $null
try {
    $release = Invoke-GitHub -Method GET -Uri "$api/repos/$owner/$repo/releases/tags/$Tag"
}
catch {
    if (-not (Test-NotFound $_)) { throw }
}

if (-not $release) {
    $body = @{
        tag_name         = $Tag
        name             = "Ping Status by A-pEx $Tag"
        body             = @"
ICMP-based connectivity monitor for Rainmeter.

- Install the ``.rmskin`` below, or clone this repo and load ``PingStatusByA-pEx.ini``.
- **License:** CC BY-NC-SA 3.0
- **Site:** https://p3x-2225.xyz
"@
        draft            = $false
        prerelease       = $false
    }
    $release = Invoke-GitHub -Method POST -Uri "$api/repos/$owner/$repo/releases" -Body $body
    Write-Host "Created release id=$($release.id)"
}
else {
    Write-Host "Release already exists id=$($release.id)"
}

# Skip upload if same filename already attached
$existing = $release.assets | Where-Object { $_.name -eq $RmskinName }
if ($existing) {
    Write-Host "Asset already on release: $RmskinName (skip upload)"
    exit 0
}

$uploadBase = $release.upload_url -replace '\{\?name,label\}', ''
$uploadUri = "$uploadBase?name=$([uri]::EscapeDataString($RmskinName))"
$uploadHeaders = @{
    Authorization = "Bearer $token"
    Accept        = "application/vnd.github+json"
    "User-Agent"  = "Ping-Status-publish-script"
}
Invoke-WebRequest -Uri $uploadUri -Method POST -Headers $uploadHeaders -ContentType "application/octet-stream" -InFile $rmskinPath -UseBasicParsing | Out-Null
Write-Host "Uploaded: $RmskinName"
Write-Host "Release: $($release.html_url)"
