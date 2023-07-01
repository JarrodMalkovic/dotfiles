#!/bin/bash

# The directory where your dotfiles are stored
DOTFILES_DIR=~/dotfiles

# The default obsidian vault path
OBSIDIAN_VAULT_PATH=""

# Files/directories to ignore
IGNORE=("README.md" "manage_dotfiles.sh" ".gitignore" ".git" "LICENSE")

# Collecting specific directories to stow, if any
declare -a DIRS_TO_STOW

# Overwrite existing files?
OVERWRITE=false

# Function to check if a value is in an array
function contains() {
    local value=$1
    shift
    local array=("$@")
    for i in "${array[@]}"; do
        if [ "$i" = "$value" ]; then
            return 0
        fi
    done
    return 1
}

# Function to stow a directory or file
function stow_item() {
    local item=$1
    local target=$2
    local overwrite=$3

    echo "Stowing $item to $target..."
    if [ "$overwrite" = true ]; then
        stow --target="$target" --dir="$DOTFILES_DIR" --overwrite="$item"
    else
        stow --target="$target" --dir="$DOTFILES_DIR" "$item"
    fi
}

# Function to check and stow .obsidian
function stow_obsidian() {
    local item=$1
    local vault_path=$2
    local overwrite=$3

    if [ "$item" = "obsidian" ]; then
        if [ -z "$vault_path" ]; then
            echo "Skipping $item. Please make sure --vault-path is provided for $item."
            return 1;
        fi
        stow_item "$item" "$vault_path" "$overwrite"
        return 0
    else
        return 1
    fi
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
    .*)
    DIRS_TO_STOW+=("$i")
    shift # past argument with no equals sign
    ;;
    *)
    # unknown option
    ;;
esac
done

# If specific items are provided, only stow them
if [ ${#DIRS_TO_STOW[@]} -ne 0 ]; then
    for item in "${DIRS_TO_STOW[@]}"; do
        if contains "$item" "${IGNORE[@]}"; then
            echo "Ignoring $item"
            continue
        fi
        if ! stow_obsidian "$item" "$OBSIDIAN_VAULT_PATH" "$OVERWRITE"; then
            stow_item "$item" ~ "$OVERWRITE"
        fi
    done
else
    # Stow all items
    for item in $(ls -A $DOTFILES_DIR); do
        if contains "$item" "${IGNORE[@]}"; then
            echo "Ignoring $item"
            continue
        fi
        if ! stow_obsidian "$item" "$OBSIDIAN_VAULT_PATH" "$OVERWRITE"; then
            stow_item "$item" ~ "$OVERWRITE"
        fi
    done
fi

# Calculate the time taken
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)

# Log the time taken to run the script
echo "✨ Done in $elapsed_time seconds"