# Enhanced Tree Command 🌳

A colorful, feature-rich alternative to the standard `tree` command with icons. Verison: 1.0.0

![Example Output](showcase.png)

## Features ✨

- 🎨 Color-coded output (directories, files, symlinks)
- 🏷️ File type icons for better visual scanning
- 🔍 Recursive directory listing (`-r` option)
- 👁️ Show hidden files (`-a` option)
- 🔗 Symlink detection with target display
- 📊 Smart sorting (dirs first, then files)
- 🛠️ Configurable colors and icons

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
-r, --recursive  Show recursive directory tree
-a, --all        Show hidden files
-ra, -ar         Show recursive with hidden files
-v, --version    Show version information
-h, --help       Show help message
```

## License 📜
MIT License - See [License](LICENSE) file