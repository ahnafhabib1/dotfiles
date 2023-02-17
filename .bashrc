# =============================================================== #
#    ___   _   _ 
#   / _ \ | | | |  Ahnaf Habib <ahnafhabib@onmail.com>
#  / /_\ \| |_| |  https://github.com/arh-01/dotfiles
#  |  _  ||  _  |  
#  | | | || | | |
#  \_| |_/\_| |_/
#            
# PERSONAL $HOME/.bashrc 
# Created: Tue 2023/02/14 05:46 PM PST
# Last Updated: Tue 2023/02/16 06:25 PM PST 
# =============================================================== #

#-------------------------------------------------------------
# Environment Options | History | Shell Options
#-------------------------------------------------------------

# Terminal Colors
# Set the terminal to use 256 colors for a more visually appealing experience
export TERM="xterm-256color"

# Manpager
# Choose one option for how man pages should be displayed

# Option 1: Use bat as the manpager
# Display man pages in color using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Option 2: Use vim as the manpager
# Display man pages in a Vim buffer with appropriate syntax highlighting and key bindings
# Uncomment the line below to enable this option
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

# Option 3: Use nvim as the manpager
# Display man pages in a Neovim buffer with appropriate syntax highlighting and key bindings
# Uncomment the line below to enable this option
# export MANPAGER="nvim -c 'set ft=man' -"

# History
# Set the size of the command history
export HISTSIZE=999999
export HISTFILESIZE=999999
# Avoid storing duplicate commands in the history
export HISTCONTROL=ignoredups:erasedups
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# Shopts
# Enable autocd for fast directory navigation
shopt -s autocd
# Enable autocorrect for misspelled cd commands
shopt -s cdspell
# Save multi-line commands as a single line in the history
shopt -s cmdhist
# Enable globbing for dotfiles
shopt -s dotglob
# Append new commands to the history instead of overwriting it
shopt -s histappend
# Expand aliases in the command line
shopt -s expand_aliases
# Check the terminal size after each command
shopt -s checkwinsize

# TAB Completion
# Ignore case for TAB completion for a more user-friendly experience
bind "set completion-ignore-case on"

# Vi Mode
# Enable vi-style key bindings for the terminal
set -o vi
# Clear the screen with Control-l in both command and insert mode
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# This fixes the ugly promt in bash.

# This is commented out if using starship prompt
# PS1='[\u@\h \W]\$ '

# Making sure git works with PGP 

export GPG_TTY=$(tty)

#-------------------------------------------------------------
# Path
#-------------------------------------------------------------

# Check if .bin directory exists in the home directory, and if so, add it to the PATH
if [ -d "$HOME/.bin" ]; then
  PATH="$HOME/.bin:$PATH"
fi

# Check if .local/bin directory exists in the home directory, and if so, add it to the PATH
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Check if .emacs.d/bin directory exists in the home directory, and if so, add it to the PATH
if [ -d "$HOME/.emacs.d/bin" ]; then
  PATH="$HOME/.emacs.d/bin:$PATH"
fi

# Check if Applications directory exists in the home directory, and if so, add it to the PATH
if [ -d "$HOME/Applications" ]; then
  PATH="$HOME/Applications:$PATH"
fi

# Check if the /var/lib/flatpak/exports/bin/ directory exists, and if so, add it to the PATH
if [ -d "/var/lib/flatpak/exports/bin/" ]; then
  PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi

# Add platform tools to PATH

if [ -d "/opt/platform-tools" ]; then
  PATH="/opt/platform-tools:$PATH"
fi


### XDG VARIABLES

# If XDG_CONFIG_HOME is not set, set it to "$HOME/.config"
if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

# If XDG_DATA_HOME is not set, set it to "$HOME/.local/share"
if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi

# If XDG_CACHE_HOME is not set, set it to "$HOME/.cache"
if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

#-------------------------------------------------------------
# Functions | Aliases
#-------------------------------------------------------------

### ARCHIVE EXTRACTION
# usage: ex <file>
# This function allows you to extract a variety of archive file types.
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted using this function." ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# Use nala instead

apt() { 
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}

### ALIASES ###

# root privileges
# This alias allows you to use "doas" command with "--" flag.
alias doas="doas --"

# better clear

alias clear="clear; bash"


# navigation
# This alias allows you to go up a specified number of directory levels.
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit directory levels.";
  fi
}

# vim and emacs
# This alias allows you to use "nvim" command instead of "vim".
alias vim="nvim"
# This alias allows you to use "em" command instead of "emacs -nw".
alias em="/usr/bin/emacs -nw"
# This alias allows you to use "emacs" command to open emacs client.
alias emacs="emacsclient -c -a 'emacs'"

# Changing "ls" to "exa"
# This alias changes the "ls" command to "exa" with extra flags for listing all files and directories, in a long format, with colors and group directories first.
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

# Colorize grep output (good for log files)
# This alias allows you to use "grep" command with the "--color=auto" flag for colorizing output.
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
# These aliases adds "-i" flag to "cp", "mv" and "rm" commands to confirm before overwriting something.
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
# These aliases adds "-h" flag to "df" for human-readable sizes, and "-m" flag to "free" for showing sizes in MB.
alias df='df -h'
alias free='free -m'
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
alias vifm='./.config/vifm/scripts/vifmrun'
alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'


# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# Using bat as cat

alias cat="bat"

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

#-------------------------------------------------------------
# Neofetch | Starship Prompt
#-------------------------------------------------------------

### Neofetch

neofetch

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init bash)"
