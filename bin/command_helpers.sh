#!/bin/bash

# Filter function
should_include_file() {
    local filename="$1"

    if [ -z "$FILTER_EXT" ]; then
        return 0
    fi
    if [[ "$filename" == *"$FILTER_EXT" ]]; then
        return 0
    fi

    return 1
}

# Sorting function
sort_entries() {
    local entries=("$@")
    local dirs=() files=()

    for entry in "${entries[@]}"; do
        if [ -d "$entry" ]; then
            dirs+=("$entry")
        else
            if should_include_file "$entry"; then
                files+=("$entry")
            fi
        fi
    done

    dirs=($(printf "%s\n" "${dirs[@]}" | sort))
    files=($(printf "%s\n" "${files[@]}" | sort))

    echo "${dirs[@]}" "${files[@]}"
}

#Include file ||!
should_include_file() {
    local filename="$1"
    [[ "$filename" == *"$FILTER_EXT" ]] && return 0
    return 1
}

# Find Method for --f
has_matching_files() {
    local dir="$1"
    local found=0

    for file in "$dir"/*"$FILTER_EXT"; do
        if [ -f "$file" ]; then
            return 0
        fi
    done

    for subdir in "$dir"/*/; do
        if [ -d "$subdir" ]; then
            if [[ "$(basename "$subdir")" =~ ^(.git|node_modules|__pycache__)$ ]]; then
                continue
            fi
            if has_matching_files "$subdir"; then
                return 0
            fi
        fi
    done

    return 1
}
