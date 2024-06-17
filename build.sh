#!/bin/bash

if ! command -v curl > /dev/null; then
  echo "Require: curl" >&2
  exit 1
fi
if ! command -v jq > /dev/null; then
  echo "Require: jq" >&2
  exit 1
fi
if ! command -v docker > /dev/null; then
  echo "Require: docker" >&2
  exit 1
fi

spigot_rev="$(curl -sL https://launchermeta.mojang.com/mc/game/version_manifest_v2.json | jq -r .latest.release)"
if [ -z "$1" ]; then
  read -p "SPIGOT_REV(Default: $spigot_rev): " spigot_rev_input
else
  spigot_rev_input="$1"
fi
if [ -n "$spigot_rev_input" ]; then
  spigot_rev="$spigot_rev_input"
fi

echo "SPIGOT_REV: $spigot_rev"
if [ "$2" != "--batch" ]; then
  read -p "Continue? [y/N]: " -n 1 yn
  echo ''
  if [ "$yn" != "y" ]; then
    echo "Aborted." >&2
    exit 1
  fi
fi

docker image build --build-arg "SPIGOT_REV=$spigot_rev" -t build-spigot:latest .
docker run --rm --name build-spigot --mount "type=bind,source=$(pwd),target=/tmp/data" -it build-spigot:latest cp "spigot-$spigot_rev.jar" /tmp/data
docker image rm build-spigot:latest

sudo chown "$(id -u):$(id -g)" "$(pwd)"/spigot-*.jar
ls -l "$(pwd)"/spigot-*.jar
