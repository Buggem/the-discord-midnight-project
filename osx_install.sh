#!/bin/bash

clear;clear

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}" )"
cd "${SCRIPT_DIR}"

echo "Install Discord Midnight Theme for macOS"

sleep 1

echo "Continuing will quit Discord."
sleep 0.5
echo "Are you sure you want to proceed?"

read

killall Discord

clear;clear

DISCORD_PATH="/Users/$USER/Library/Application Support/discord/"

DISCORD_VER="$(ls "$DISCORD_PATH" | grep "^0.")"

MIDNIGHT_INJECT="${DISCORD_PATH}$DISCORD_VER/modules/discord_utils/index.js"
line_from_etc () {
    echo "$(echo "$(grep -n "$1" "$2" | cut -d : -f 1)" | head -1)"
}
cut_chunk () {
    let "a=${2}-1"
    let "b=${3}+1"
    head -n $a "$1"
    tail -n+$b "$1"
}
MIDNIGHT_LINE="$(line_from_etc "window?.DiscordNative?.isRenderer" "$MIDNIGHT_INJECT")"

echo "Injection starting..."


ed -s "$MIDNIGHT_INJECT" <<EOF
${MIDNIGHT_LINE}r midnight.js
w
EOF


echo "Done!"
echo "Relaunching Discord..."
nohup /Applications/Discord.app/Contents/MacOS/Discord
