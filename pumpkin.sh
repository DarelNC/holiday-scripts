#!/bin/bash
#
# ANSI color scheme script by pfh
#
# Initializing mod by lolilolicon from Archlinux
#

rows=(
"         ▄      "
"   ▄▄▄▄▄█▄▄▄▄▄  "
" ▄███▀█████▀███▄"
" ████▄██▄██▄████"
"  ▀███▄█▄█▄███▀ "
)
blink=("${rows[@]}")
blink[2]=${rows[2]//▀/█}

colors=(5 4 3 2)

trap 'printf "\e[0m\e[?25h\e[?1049l"' EXIT
trap 'exit' INT TERM
printf '\e[?1049h\e[?25l'

t=0
while :; do
  bold=$'\e[22m'
  (( t % 2 )) && bold=$'\e[1m'
  shown=("${rows[@]}")
  (( t % 8 == 7 )) && shown=("${blink[@]}")

  frame=$'\e[H\n'
  for r in 0 1 2 3 4; do
    line=$bold
    for p in 0 1 2 3; do
      line+=$'\e[3'${colors[(p + t / 2) % 4]}'m'"${shown[r]}  "
    done
    frame+=$line$'\n'
  done

  printf '%s\e[0m' "$frame"
  sleep 0.4
  (( t++ ))
done
