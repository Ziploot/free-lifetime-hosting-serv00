#!/bin/bash
# ZipLoot Linux/macOS 1-Click Serv00 Deployment Tool
echo "=============================================="
echo "⚡ ZipLoot - Serv00 SSH Deployment Tool ⚡"
echo "=============================================="

read -p "Enter your Serv00 Username: " username
read -p "Enter your Serv00 Server Domain (e.g. s3.serv00.com): " server
read -p "Enter your reserved port on Serv00 (e.g. 12345): " port
read -p "Enter path to your local Node.js project folder: " localFolder

if [ ! -d "$localFolder" ]; then
  echo "Error: Local directory not found."
  exit 1
fi

remoteDir="/home/$username/app-$port"

echo "Creating remote folder..."
ssh "$username@$server" "mkdir -p $remoteDir"

echo "Uploading files..."
scp -r "$localFolder"/* "$username@$server:$remoteDir"

echo "Installing packages and starting with PM2..."
ssh "$username@$server" "cd $remoteDir && npm install --production && pm2 stop app-$port 2>/dev/null || true && PORT=$port pm2 start index.js --name app-$port && pm2 save"

echo "Deployment finished successfully!"
