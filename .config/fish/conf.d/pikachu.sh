#!/bin/bash

# Chafa image generation
art=$(chafa --colors=256 --size=24x24 ~/.config/fish/conf.d/pikachu.png)

# ANSI escape sequences
esc=$(printf '\033')
color="${esc}[38;2;156;202;255m"
reset="${esc}[0m"
aligned="${esc}[28G"  # move to column 28

# System info
source /etc/os-release
distro="$NAME"

user="$USER"
os=${distro:-$(uname -o)}
arch=$(uname -m)
cpu=$(awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo | sed 's/^[ \t]*//')
ram=$(free -h --si | awk '/Mem:/ {print $2}')
mb=$(cat /sys/devices/virtual/dmi/id/board_name 2>/dev/null || echo "N/A")
time=$(date +"%Y-%m-%d %H:%M:%S")

# Use printf '%s\0' to preserve blank lines
text=$(
  printf '%s' "\
${aligned}${color}Motherboard:${reset} $mb
${aligned}${color}CPU:${reset} $cpu

${aligned}${color}OS:${reset} $os
${aligned}${color}Arch:${reset} $arch

${aligned}${color}User:${reset} $user
${aligned}${color}RAM:${reset} $ram

${aligned}${color}Time:${reset} $time
 
"
)

# Convert to array with null terminator to keep blank lines
IFS=$'\0' read -r -d '' -a lines <<< "$text"

# Print the aligned text
for line in "${lines[@]}"; do
    printf "%b\n" "$line"
done

# Move cursor up to overlay image
target=14
printf "\033[%sA" "$target"
echo "$art"



## Get terminal height (number of rows)
#rows=$(tput lines)
#
## Calculate number of blank lines to print before image
#blank_lines=$((rows - target - 3))
#if (( blank_lines < 0 )); then
#  blank_lines=0
#fi
#
## Print blank lines to fill terminal except for image space
#for ((i=0; i<blank_lines; i++)); do
#  echo ""
#done