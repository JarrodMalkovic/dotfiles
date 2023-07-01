#!/usr/bin/env bash

# This bash script allows you to search for programming language-specific documentation
# and core utility documentation using the cheat.sh API and fzf (fuzzy finder).
# Simply run the script, select an item from the combined list of languages and core utilities,
# enter a query when prompted, and the script will fetch and display the corresponding documentation.
# The script uses curl to make API requests and utilizes tmux to split the terminal window for better viewing.

# Example usage:
# ./cht.sh

# Dependencies:
# - bash
# - curl
# - fzf
# - tmux

languages=$(echo "golang c cpp typescript rust" | tr " " "\n")
core_utils=$(echo "find xargs sed awk" | tr " " "\n")
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "Your query: " query

if echo "$languages" | grep -qs $selected; then
    tmux split-window -h "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less"
else
    tmux split-window -h "curl cht.sh/$selected~$query | less"
fi
