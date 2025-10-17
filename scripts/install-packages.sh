#!/bin/bash

# Existing installation flow code here...

# Function to detect available category files
get_optional_categories() {
    local categories_dir="packages/optional"
    echo "Available categories:"
    if command -v fzf &> /dev/null; then
        # Use fzf if available
        local selected_categories=$(ls "$categories_dir" | fzf --multi --preview 'cat "$categories_dir/{}"')
    else
        # Fallback to numbered prompt
        local categories=( $(ls "$categories_dir") )
        echo "Select categories (comma-separated numbers):"
        for i in "${!categories[@]}"; do
            echo "$((i + 1)): ${categories[i]}"
        done
        read -p "Enter numbers: " numbers_input
        IFS=',' read -r -a selected_indices <<< "$numbers_input"
        local selected_categories=""
        for index in "${selected_indices[@]}"; do
            selected_categories+="${categories[$((index - 1))]} "
        done
    fi
    echo "$selected_categories"
}

# Main installation function
install_packages() {
    local optional_categories="$(get_optional_categories)"
    local temp_optional_file="/tmp/optional_packages.txt"

    # Concatenate selected category files into a temporary file
    for category in $optional_categories; do
        cat "packages/optional/$category" >> "$temp_optional_file"
    done

    # Proceed with existing installation flow
    # Existing installation code...
}

install_packages
