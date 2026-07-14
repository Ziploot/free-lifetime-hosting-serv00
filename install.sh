#!/bin/bash
PROJECT_DIR="$(pwd)/serv00-deployer-project"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

curl -sL "https://raw.githubusercontent.com/Ziploot/free-lifetime-hosting-serv00/main/deploy.sh" -o deploy.sh
curl -sL "https://raw.githubusercontent.com/Ziploot/free-lifetime-hosting-serv00/main/deploy.ps1" -o deploy.ps1
chmod +x deploy.sh

echo "✅ Deployment tools successfully downloaded!"
echo "Run ./deploy.sh to deploy your Node.js apps to Serv00!"
