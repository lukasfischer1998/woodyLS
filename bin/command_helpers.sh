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
