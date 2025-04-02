#!/bin/bash

# Version Info
VERSION="1.0.0"
AUTHOR="Lukas Fischer"
RELEASE_DATE="2023-11-20"


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