#!/bin/bash

# The default obsidian vault path
OBSIDIAN_VAULT_PATH=""

# Overwrite existing files?
OVERWRITE=false

# Function to stow a directory
function stow_dir() {
    local dir=$1
    local target=$2
    local overwrite=$3

    echo "Stowing $dir to $target..."
    if [ "$overwrite" = true ]; then
        stow --target="$target" --overwrite "$dir"
    else
        stow --target="$target" "$dir"
    fi
}

# Function to display help message
function display_help() {
    echo "Usage: ./manage_dotfiles.sh [options]"
    echo ""
    echo "Options:"
    echo "  --vault-path=PATH      The path to the Obsidian vault where .obsidian will be stowed."
    echo "  --overwrite            Overwrite existing dotfiles when stowing."
    echo ""
    echo "Use './manage_dotfiles.sh help' to display this help message."
}

# Record the start time
start_time=$(date +%s.%N)

# Loop over all arguments
for i in "$@"
do
case $i in
    --vault-path=*)
    OBSIDIAN_VAULT_PATH="${i#*=}"
    shift # past argument=value
    ;;
    --overwrite)
    OVERWRITE=true
    shift # past argument with no equals sign
    ;;
    help)
    display_help
    exit 0
    ;;
    *)
    echo "Unknown option: $i"
    display_help
    exit 1
    ;;
esac
done

# Stow directories
stow_dir "home" "$HOME" "$OVERWRITE"

# Special case for obsidian
if [ ! -z "$OBSIDIAN_VAULT_PATH" ]; then
    cd "other"
    echo "$PWD"
    stow_dir "obsidian" "$OBSIDIAN_VAULT_PATH" "$OVERWRITE"
fi

# Calculate the time taken
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)

# Log the time taken to run the script
echo "✨ Done in $elapsed_time seconds"
