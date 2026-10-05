<#
.SYNOPSIS
AOS Windows Standalone Installer Script
#>

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host " 🚀 Installing AOS (Agent Operating System) Core" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan

# 2. Ensure Global ~/.aos Directory and bin
$globalAos = Join-Path $HOME ".aos"
$binDir = Join-Path $globalAos "bin"
if (-not (Test-Path $binDir)) {
    New-Item -ItemType Directory -Path $binDir -Force | Out-Null
    Write-Host " • Created global binary directory: $binDir" -ForegroundColor Green
}

# 3. Attempt Standalone Binary Download from Branded Gateway
$binaryInstalled = $false
$gatewayUrl = if ($env:AOS_DOWNLOAD_URL) { $env:AOS_DOWNLOAD_URL } else { "https://api.aos.run/download/windows" }
$targetExe = Join-Path $binDir "aos.exe"

try {
    Write-Host " • Fetching latest standalone binary from: $gatewayUrl" -ForegroundColor Cyan
    Invoke-WebRequest -Uri $gatewayUrl -OutFile $targetExe -TimeoutSec 10 -ErrorAction Stop
    if ((Test-Path $targetExe) -and (Get-Item $targetExe).Length -gt 1000000) {
        Write-Host " • Downloaded standalone executable: $targetExe" -ForegroundColor Green
        $binaryInstalled = $true
    } else {
        Remove-Item $targetExe -ErrorAction SilentlyContinue
    }
} catch {
    Write-Host " • Standalone binary gateway offline or unreachable. Falling back to local Python wrapper." -ForegroundColor Yellow
}

# 4. Fallback: Create Windows wrapper script 'aos.cmd'
if (-not $binaryInstalled) {
    $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    if (-not $pythonCmd) {
        Write-Error "Neither binary could be fetched nor Python 3 found in PATH. Please install Python 3.10+."
        exit 1
    }
    $pyVersion = & python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
    Write-Host " • Detected Python: $pyVersion" -ForegroundColor Green
    
    $aosCmdPath = Join-Path $binDir "aos.cmd"
    $scriptContent = "@echo off`r`npython -m app.client.cli_setup %*"
    Set-Content -Path $aosCmdPath -Value $scriptContent -Encoding ASCII
    Write-Host " • Created standalone Python launcher: $aosCmdPath" -ForegroundColor Green
}

# 5. Check PATH
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$binDir*") {
    Write-Host " • Appending $binDir to User PATH..." -ForegroundColor Yellow
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$binDir", "User")
    $env:Path += ";$binDir"
}

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host " ✅ AOS Installation Complete!" -ForegroundColor Green
Write-Host " Run 'aos setup' inside any repository to enable." -ForegroundColor White
Write-Host "=====================================================" -ForegroundColor Cyan
