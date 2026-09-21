#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p .build
if [ ! -d .build/frappe_docker/.git ]; then
  git clone https://github.com/frappe/frappe_docker.git .build/frappe_docker
fi
git -C .build/frappe_docker checkout a0c52135d4d41c4b8acf7adfdfc5bbcba46dd4d0
docker build --build-arg FRAPPE_BRANCH=version-15 --secret id=apps_json,src=apps.json --tag shopify-erpnext-demo:15 --file .build/frappe_docker/images/layered/Containerfile .build/frappe_docker
docker build -f Dockerfile.callback -t shopify-erpnext-demo:15-callback .
