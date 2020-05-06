# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

settings="$HOME/.config/diwesser/device-id"

# History
HISTSIZE=1000
HISTFILESIZE=10000
HISTTIMEFORMAT="%y-%m-%d %T "
HISTIGNORE="[ \t]*" # Exclude lines begining with a space from history
shopt -s histappend

# Use vim as default editor
VISUAL=vim; EDITOR=vim
export VISUAL EDITOR

# Import my configs
# TODO: Replace variable extraction with bash parameter expansion
if [ -f $HOME/.config/diwesser/device-id ]; then
    SYNC_DIR=$(grep -iw '^\s*sync_dir:' $settings | cut -d: -f2 | xargs)
    #prompt=$()
fi

if [ -f "$HOME/.bash_aliases" ] ; then
    . "$HOME/.bash_aliases"
fi
# <blue><\u><white><@><blue><\h> <purple><\W (CURRENT DIR)> <\$ ($ or #)> <white>
PS1='\[\033[0;34m\]\u\[\033[0m\]@\[\033[0;34m\]\h \[\033[0;35m\]\W \$ \[\033[0m\]'

# Add scripts etc to PATH
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$PATH:$HOME/.local/bin"
fi

if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/bin"
fi
