# Downloader for Serv00 deployer
try {
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
    $projectFolder = Join-Path $pwd "serv00-deployer-project"
    if (Test-Path $projectFolder) {
        Write-Host "Folder serv00-deployer-project already exists." -ForegroundColor Yellow
    } else {
        New-Item -ItemType Directory -Path $projectFolder -ErrorAction SilentlyContinue | Out-Null
    }

    Copy-Item -Path "$scriptDir\\deploy.ps1" -Destination "$projectFolder\\deploy.ps1" -Force
    Copy-Item -Path "$scriptDir\\deploy.sh" -Destination "$projectFolder\\deploy.sh" -Force

    Write-Host "[SUCCESS] Serv00 deployment tool generated!" -ForegroundColor Green
    Write-Host "To deploy any Node.js project, execute: powershell -File serv00-deployer-project\deploy.ps1" -ForegroundColor Yellow
    Read-Host "Press Enter to exit..."
} catch {
    Write-Host "[ERROR] Setup failed: $_" -ForegroundColor Red
    Read-Host "Press Enter to exit..."
}
