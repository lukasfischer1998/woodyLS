#!/bin/bash

# Version Info
VERSION="1.0.0"
AUTHOR="Lukas Fischer"
RELEASE_DATE="2023-11-20"

declare -A FILE_ICONS=(
    # Text
    [".txt"]="📄" [".md"]="📖" [".pdf"]="📕" [".doc"]="📃" [".docx"]="📃"
    [".odt"]="📑" [".rtf"]="📝" [".tex"]="✍️" [".csv"]="📊" [".xls"]="📊"
    [".xlsx"]="📊" [".ods"]="📊"

    # Pictures
    [".jpg"]="🖼️" [".jpeg"]="🖼️" [".png"]="🖼️" [".gif"]="🖼️" [".svg"]="🖼️"
    [".bmp"]="🖼️" [".tiff"]="🖼️" [".webp"]="🖼️" [".ico"]="🖼️" [".psd"]="🎨"

    # Audio/Video
    [".mp3"]="🎵" [".wav"]="🎵" [".ogg"]="🎵" [".flac"]="🎵" [".aac"]="🎵"
    [".mp4"]="🎬" [".avi"]="🎬" [".mov"]="🎬" [".mkv"]="🎬" [".flv"]="🎬"
    [".webm"]="🎬"

    # Code
    [".sh"]="💻" [".bash"]="💻" [".zsh"]="💻" [".js"]="📜" [".ts"]="📜"
    [".py"]="🐍" [".java"]="☕" [".c"]="🔧" [".cpp"]="🔧" [".h"]="🔧"
    [".go"]="🐹" [".rb"]="💎" [".php"]="🐘" [".swift"]="🐦" [".kt"]="🅱️"
    [".rs"]="🦀" [".lua"]="🌙" [".pl"]="🐪" [".sql"]="🗃️" [".hs"]="λ"

    # Web
    [".html"]="🌐" [".htm"]="🌐" [".css"]="🎨" [".scss"]="🎨" [".sass"]="🎨"
    [".less"]="🎨" [".json"]="🔣" [".xml"]="📋" [".yml"]="🔣" [".yaml"]="🔣"
    [".toml"]="🔣"

    # Archive
    [".zip"]="🗜️" [".tar"]="🗜️" [".gz"]="🗜️" [".bz2"]="🗜️" [".7z"]="🗜️"
    [".rar"]="🗜️" [".xz"]="🗜️" [".deb"]="📦" [".rpm"]="📦" [".pkg"]="📦"

    # System/Config
    [".conf"]="⚙️" [".cfg"]="⚙️" [".ini"]="⚙️" [".log"]="📋" [".lock"]="🔒"
    [".bak"]="🔙" [".tmp"]="🕒" [".env"]="🌱" [".gitignore"]="🚫"

    # Others
    [".exe"]="⚙️" [".dll"]="🔧" [".app"]="🖥️" [".apk"]="📱" [".iso"]="💿"
    [".img"]="💾" [".dmg"]="🍏" [".ps1"]="💻" [".vbs"]="💻"
)

# Color definitions
declare -A COLORS=(
    [dir]="1;34"     # Blue
    [file]="0;33"    # Yellow
    [hidden]="0;37"  # Grey
    [symlink]="1;36" # Cyan
    [exec]="1;32"    # Green
)

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

pretty_tree() {
    local dir="${1:-.}" depth="${2:-1}" prefix="${3:-}"
    local ignore_dirs=".git|node_modules|vendor|__pycache__|.idea|.vscode"
    local entries=() entry name ext icon is_last new_prefix color

    [[ "$SHOW_HIDDEN" -eq 1 ]] && shopt -s dotglob

    local is_empty=1
    for entry in "$dir"/*; do
        name=$(basename "$entry")
        if [[ "$SHOW_IGNORED" -eq 1 || ! $name =~ ^($ignore_dirs)$ ]] && [[ "$name" != "*" ]]; then
            is_empty=0
            if [ "$DIRS_ONLY" -eq 0 ] || [ -d "$entry" ]; then
                entries+=("$entry")
            fi
        fi
    done

    entries=($(sort_entries "${entries[@]}"))
    local entries_count=${#entries[@]} i=0

    for entry in "${entries[@]}"; do
        i=$((i + 1))
        name=$(basename "$entry")
        is_last=$((i == entries_count))

        if ((is_last)); then
            echo -n "${prefix}└── "
            new_prefix="${prefix}    "
        else
            echo -n "${prefix}├── "
            new_prefix="${prefix}│   "
        fi

        if [ -d "$entry" ]; then
            # Directory - blue
            color=${COLORS[dir]}
            echo -e "📁 \e[${color}m$name\e[0m"
            if [ "$depth" -gt 1 ]; then
                local sub_entries=()
                for sub_entry in "$entry"/*; do
                    sub_name=$(basename "$sub_entry")
                    if [[ ! $sub_name =~ ^($ignore_dirs)$ ]] && [[ "$sub_name" != "*" ]]; then
                        if [ "$DIRS_ONLY" -eq 0 ] || [ -d "$sub_entry" ]; then
                            sub_entries+=("$sub_entry")
                        fi
                    fi
                done
                if [ ${#sub_entries[@]} -gt 0 ]; then
                    sub_entries=($(sort_entries "${sub_entries[@]}"))
                    pretty_tree "$entry" $((depth - 1)) "$new_prefix"
                fi
            fi
        elif [ "$DIRS_ONLY" -eq 0 ]; then # Only show files if not in dirs-only mode
            if should_include_file "$entry"; then
                if [ -L "$entry" ]; then
                    # Symbolic link - cyan
                    color=${COLORS[symlink]}
                    target=$(readlink "$entry")
                    icon="🔗"
                    echo -e "$icon \e[${color}m$name → $target\e[0m"
                elif [ -x "$entry" ]; then
                    # Executable file - green
                    color=${COLORS[exec]}
                    ext=".${name##*.}"
                    icon=${FILE_ICONS["$ext"]:-📄}
                    echo -e "$icon \e[${color}m$name\e[0m"
                elif [[ "$name" =~ ^\. ]]; then
                    # Hidden file - grey
                    color=${COLORS[hidden]}
                    ext=".${name##*.}"
                    icon=${FILE_ICONS["$ext"]:-📄}
                    echo -e "$icon \e[${color}m$name\e[0m"
                else
                    # Normal file - yellow
                    color=${COLORS[file]}
                    ext=".${name##*.}"
                    icon=${FILE_ICONS["$ext"]:-📄}
                    echo -e "$icon \e[${color}m$name\e[0m"
                fi
            fi
        fi
    done

    shopt -u dotglob 2>/dev/null
}

show_help() {
    echo "Usage: tree [OPTIONS]"
    echo "  -r, --recursive       Show recursive directory tree"
    echo "  -a, --all             Show hidden files"
    echo "  -d, --dirs-only       Show directories only"
    echo "  -i, --include-ignored Show normally ignored directories (.git, node_modules etc.)"
    echo "  -rd, -dr              Show recursive directories only"
    echo "  -ra, -ar              Show recursive with hidden files"
    echo "  -rdep, --re-depth N   Set custom recursion depth (e.g., '--re-depth 2')"
    echo "  -f, --filter EXT      Filter files by extension (e.g., '--filter=.txt')"
    echo "  -v, --version         Show version information"
    echo "  -h, --help            Show help message"
    exit 0
}

show_version() {
    echo "tree (enhanced) v$VERSION"
    echo "Copyright (c) $RELEASE_DATE $AUTHOR"
    echo "License: MIT"
    exit 0
}

# Parameter processing
SHOW_HIDDEN=0
RECURSIVE_DEPTH=1
DIRS_ONLY=0
SHOW_IGNORED=0
FILTER_EXT=""

while [[ $# -gt 0 ]]; do
    case "$1" in
    -r | --recursive)
        RECURSIVE_DEPTH=999
        ;;
    -a | --all)
        SHOW_HIDDEN=1
        ;;
    -d | --dirs-only)
        DIRS_ONLY=1
        ;;
    -i | --include-ignored)
        SHOW_IGNORED=1
        ;;
    -rd | -dr)
        RECURSIVE_DEPTH=999
        DIRS_ONLY=1
        ;;
    -ra | -ar)
        SHOW_HIDDEN=1
        RECURSIVE_DEPTH=999
        ;;
    -v | --v | -version | --version)
        show_version
        ;;
    -h | --help)
        show_help
        ;;
    -rdep | --re-depth)
        if [[ -z "$2" || ! "$2" =~ ^[0-9]+$ || "$2" -le 0 ]]; then
            echo "Error: '$1' requires a positive integer (e.g., '--re-depth 3')"
            exit 1
        fi
        RECURSIVE_DEPTH="$2"
        shift
        ;;
    -f | --filter)
        if [[ -z "$2" ]]; then
            echo "Error: '$1' requires an extension (e.g., '--filter .txt' or '--filter=.txt')"
            exit 1
        fi
        FILTER_EXT="${2#=}"
        shift
        ;;
    -f=* | --filter=*)
        FILTER_EXT="${1#*=}"
        ;;
    *)
        echo "Error: Unknown option '$1'"
        echo "Try 'tree --help' for more information"
        exit 1
        ;;
    esac
    shift
done

pretty_tree "$(pwd)" "$RECURSIVE_DEPTH" ""
