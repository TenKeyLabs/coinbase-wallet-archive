#!/bin/bash

set -e

cd cwv_repo
go build -o ../cwv main.go
cd ..

latest_version=`./cwv check`
latest_release=`curl -s "https://github.com/TenKeyLabs/coinbase-wallet-archive/releases.atom" | grep -m2 -o '<title>[^<]*' | tail -n1 | grep -o '[^v]*$'`

if [ $latest_release = $latest_version ]; then
  exit 0
fi

./cwv download

echo $latest_version
