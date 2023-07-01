# My personal .dotfiles

This repository contains my personal dotfiles for various software, including but not limited to: .vscode, .zshrc, .vimrc, and .obsidian.

The dotfiles are stored in a directory called `dotfiles` and can be easily managed using the included bash script `install.sh`. The script leverages [GNU Stow](https://www.gnu.org/software/stow/) to create symlinks for the dotfiles to the respective locations in the home directory.

## Usage

1. Clone this repository into your home directory.

```bash
git clone https://github.com/JarrodMalkovic/dotfiles.git
```

2. Execute the `install.sh` script.

```bash
cd ~/dotfiles
./install.sh
```

The `install.sh` script accepts the `--vault-path` argument for the Obsidian vault path. This argument must be provided if you wish to stow the `obsidian` directory.

The script can also accept specific dotfiles as arguments. If provided, only those dotfiles will be stowed.

```bash
./install.sh .vimrc .obsidian --vault-path="/path/to/my/obsidian/vault"
```

If no dotfiles are provided as arguments, all dotfiles in the dotfiles directory will be stowed.

Additionally, the script also provides an --overwrite option. If this option is given, existing files or directories will be overwritten by the new symbolic links. Use this option with care, as it will delete the original files.

```bash
./install.sh --overwrite
```

## Software Installation

While this repository manages the configuration of various software, the actual installation of the software is handled by another repository: [JarrodMalkovic/ansible](https://github.com/JarrodMalkovic/ansible), which contains Ansible playbooks for automating the software installation process.

Together, these repositories provide a comprehensive solution for setting up a new machine to match my preferred environment. You can, of course, modify this template to better match your exact dotfiles and the specifics of your setup.