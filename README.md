![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

# Enhanced Tree Command 🌳

This was actually just a learning project for me, but I now use the command regularly.
A colorful, feature-rich alternative to the standard `tree` command with icons. Verison: 1.0.0

![Example Output](showcase.png)

## Features ✨

**Visual Enhancements**
- 🎨 Color-coded output (directories, files, symlinks)
- 🏷️ 50+ file type icons

**Functionality**
- 🔍 Recursive directory listing (`-r` option)
- 👁️ Hidden file visibility (`-a` option)
- 🔗 Symlink detection with target paths
- ⚡ Fast execution (pure Bash)

**Customization**
- 🛠️ Configurable color schemes
- 🖌️ Custom icon sets
- 🏗️ Modular design for easy extension

## Installation 📦

```bash
# Clone the repository
git clone https://github.com/lukasfischer1998/tree-command.git

# Make the script executable
chmod +x bin/tree

# Add to PATH (optional)
export PATH=$PATH:$(pwd)/bin
```

## Usage 🛠️

```bash
tree [OPTIONS]
-r, --recursive         Show recursive directory tree
-a, --all               Show hidden files
-d, --dirs-only         Show directories only
-i, --include-ignored   Show normally ignored directories ( node_modules etc.)
-rd, -dr                Show recursive directories only
-ra, -ar                Show recursive with hidden files
-v, --version           Show version information
-h, --help              Show help message
```

## Contributing 🤝

1. Fork the repository
2. Create a feature branch
3. Open a Pull Request

## Built With 🛠️

- **Bash 5.0+** - For maximum compatibility
- **Unicode 13** - Emoji and icon support
- **ANSI Colors** - 256-color support


## License 📜
MIT License - See [License](LICENSE) file