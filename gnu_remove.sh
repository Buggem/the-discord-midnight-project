#!/bin/bash

clear;clear

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}" )"
cd "${SCRIPT_DIR}"

echo "Uninstall Discord Midnight Theme for GNU Linux"

sleep 1

echo "Continuing will quit Discord."
sleep 0.5
echo "Are you sure you want to proceed?"

read

killall Discord

clear;clear

DISCORD_PATH="$HOME/.config/discord/"

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
MIDNIGHT_LINE="$(line_from_etc "//DD_START" "$MIDNIGHT_INJECT")"
MIDNIGHT_END="$(line_from_etc "//DD_END" "$MIDNIGHT_INJECT")"
#echo $MIDNIGHT_LINE
echo "Rejection starting..."

echo "$(cut_chunk "$MIDNIGHT_INJECT" "$MIDNIGHT_LINE" "$MIDNIGHT_END")" > "$MIDNIGHT_INJECT"
#sed -i '/<>/,/<a>/d' anothertest.txt
#sed -i '/<!-- BOF CLEAN -->/,/<!-- EOF CLEAN -->/d' anothertest.txt;

echo "Done!"
echo "Relaunch Discord..."
