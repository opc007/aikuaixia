#!/bin/bash
# 部署 Render 后，用此脚本更新网页 API 地址
# 用法: ./scripts/set-api-url.sh https://aikuaixia-api.onrender.com
set -e
URL="${1%/}"
if [ -z "$URL" ]; then
  echo "用法: $0 https://你的服务.onrender.com"
  exit 1
fi
FILE="$(dirname "$0")/../landing/config.js"
sed -i.bak "s|window.AIKUAIXIA_API_BASE = .*|window.AIKUAIXIA_API_BASE = '${URL}/api/v1';|" "$FILE"
sed -i.bak "s|window.AIKUAIXIA_DEFAULT_API = .*|window.AIKUAIXIA_DEFAULT_API = '${URL}/api/v1';|" "$FILE"
rm -f "${FILE}.bak"
echo "✅ 已更新 landing/config.js → ${URL}/api/v1"
echo "   请 git commit && git push 使 GitHub Pages 生效"
