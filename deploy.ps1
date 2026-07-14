# ZipLoot Windows 1-Click Serv00 Deployment Tool
try {
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[ZipLoot] Serv00 SSH Deployment Tool" -ForegroundColor Green
    Write-Host "==============================================" -ForegroundColor Green

    $username = Read-Host "Enter your Serv00 Username"
    $server = Read-Host "Enter your Serv00 Server Domain (e.g. s3.serv00.com)"
    $port = Read-Host "Enter your reserved port on Serv00 (e.g. 12345)"
    
    $localFolder = Read-Host "Enter path to your local Node.js project folder"
    if (-not (Test-Path $localFolder)) {
        Write-Host "[ERROR] Local folder not found." -ForegroundColor Red
        Exit
    }

    $remoteDir = "/home/$username/app-$port"

    Write-Host "`nConnecting and preparing remote directory via SSH..." -ForegroundColor Yellow
    ssh "$username@$server" "mkdir -p $remoteDir"

    Write-Host "Uploading files via SCP..." -ForegroundColor Yellow
    scp -r "$localFolder\*" "$username@$server`:$remoteDir"

    Write-Host "Running remote setup commands (npm install, port configuration, PM2 start)..." -ForegroundColor Yellow
    $remoteCmd = @"
cd $remoteDir
npm install --production
pm2 stop app-$port 2>/dev/null || true
PORT=$port pm2 start index.js --name app-$port
pm2 save
"@
    ssh "$username@$server" "$remoteCmd"

    Write-Host "`n[SUCCESS] Project deployed successfully to Serv00!" -ForegroundColor Green
    Write-Host "Check your app running on port $port!" -ForegroundColor Green
    
    Read-Host "Press Enter to exit..."
} catch {
    Write-Host "[ERROR] Deployment failed: $_" -ForegroundColor Red
    Read-Host "Press Enter to exit..."
}
