#!/bin/bash

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
