#!/bin/bash

killall Discord
echo "Current dir: '$1'"
read hiais
rm -f "$1/d-stable.tar.gz"
wget "https://discord.com/api/download/stable?platform=linux&format=tar.gz" -O "$1/d-stable.tar.gz"
rm -rf "$1/discord-old"
mv "$1/discord-latest" "$1/discord-old"

mkdir -p "$1/discord-latest"
tar -xzf "$1/d-stable.tar.gz" -C "$1/discord-latest"

# "$1/discord-latest/Discord/Discord" &
