# What are dotfiles?

Dotfiles are files used for customizing Linux or other Unix-based systems. They are named with a leading dot to indicate that they are hidden files or directories. This repository contains my personal dotfiles, which are conveniently stored for quick access on new machines or 
installations. Furthermore, other users may find some of the included configurations helpful for enhancing their own dotfiles.

# Requirements to use my dotfiles

1. Kitty Terminal ``` sudo pacman -S kitty ```
2. Firacode Nerd Font ``` sudo pacman -S ttf-firacode-nerd ```
3. Starship Prompt ``` curl -sS https://starship.rs/install.sh | sh ```
4. Misc. ``` sudo pacman -S bat exa ``` - bat is better version of "cat" while exa is a better version of "ls"

# How to use my dotfiles on another system?

1. Prevent tracking of dotfiles on the system by adding to .gitignore

``` bash
echo "dotfiles" >> .gitignore
```
2. Clone the dotfiles repository

``` bash
git clone --bare https://github.com/arh-01/dotfiles.git $HOME/dotfiles
```

3. Add an alias to .bashrc for easy access to dotfiles. This command sets an alias "config" for "git" using the cloned dotfiles repo as the .git directory and the current system as the working directory.

``` bash
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
```

4. Hide untracked files for this local repo only.

``` bash
config config --local status.showUntrackedFiles no
```

5. Checkout the files from the dotfiles repo to your system.

``` bash
config checkout
```
6. Checkout the files again in case there were conflicts.

``` bash
config checkout
````

# Credits

The OneDark.conf for the Kitty Terminal is the property of Giuseppe Cesarano <https://github.com/GiuseppeCesarano>

The .bashrc for the Bash Shell is based on the work of Derek Taylor <https://gitlab.com/dwt1>

The startship.toml for the Starship Prompt is based on the work of Derek Taylor <https://gitlab.com/dwt1>
