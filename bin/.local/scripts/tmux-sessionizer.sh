#!/usr/bin/env bash

# This bash script facilitates quick session management using tmux and fzf (fuzzy finder).
# It allows you to select an existing session or create a new one based on directories in your home directory.
# The script uses tmux to create and switch to sessions, and fzf for interactive session selection.

# Example usage:
# ./script.sh

# Dependencies:
# - bash
# - tmux
# - fzf

session=$(find ~ -mindepth 1 -maxdepth 1 -type d | fzf)
session_name=$(basename "$session" | tr . _)

if ! tmux has-session -t "$session_name" 2> /dev/null; then
    tmux new-session -s "$session_name" -c "$session" -d
fi

tmux switch-client -t "$session_name"
