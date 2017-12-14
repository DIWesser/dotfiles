#################################################################################
# Variables
#################################################################################
Edit=nvim
MDEdit=nvim
Dropbox="$HOME/Dropbox"
CurrentGnuCoreutils=true

#################################################################################
# Mac
#################################################################################
if [[ $(uname -s) == Darwin ]] ; then
    alias osfamily="echo 'Mac'"

    # Use GnuCore Utils with their normal names
    #PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    # Access GnuUtil man pages with their normal names
    #MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    if [[ $(command -v gls) ]] ; then
        CurrentGnuCoreutils=true
        alias ls="gls"
    else
        CurrentGnuCoreutils=false
    fi

    # Use my scripts
    export PATH=~/bin:$PATH

    # Lock computer from terminal
    alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

    # Mute
    alias mute='osascript -e "set Volume 0"'

    # Make VeraCrypt CLI sane.
    alias veracrypt='/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt'

    # Make Carbon Copy Cloner CLI sane.
    alias ccc='/Applications/Carbon\ Copy\ Cloner.app/Contents/MacOS/ccc'

fi
#################################################################################
# Linux
#################################################################################
if [[ $(uname -s) == Linux ]] ; then
    alias osfamily="echo 'Linux'"

fi
#################################################################################
# All Operating Systems and Devices
#################################################################################
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

PS1='\[\033[0;34m\]\u\[\033[0m\]@\[\033[0;34m\]\h \[\033[0;35m\]\W > \[\033[0m\]'

# Use Neovim as default editor
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

    #############################################################################
    # Aliases
    #############################################################################
    # Basic bash and navigation
        # Lazyness
            alias :q="exit"
            alias :Q="exit"
            alias clr="clear"
            alias ..="cd .."
            alias up="uptime"
        # ls tweaks
            alias la='ls -A' # List all except implied (. ..)
            alias lg='ls | grep -i ' # Grep filtered ls (case insensitive)
            alias lag='ls -A | grep -i '
            # Xubuntu ls stock tweaks
            alias ll='ls -alF'
            alias l='ls -CF'
            # Depends on recent Gnu coreutils
            if [[ $CurrentGnuCoreutils ]] ; then
                alias lA='ls -A -I .DS_Store'
            else
                alias lA='ls -A | grep -v .DS_Store'
            fi

    # Use NeoVim a bit more
    if [[ $(command -v nvim) ]] ; then
        #alias vi='nvim'
        alias vim='nvim'
    fi

    #############################################################################
    # Editing specific files and directories #
    #############################################################################
    # Todo list quick look
    alias todo="vim $Dropbox/Lists/Personal.taskpaper"

    # View notes
    alias notes="cd $Dropbox/Notes && ranger"
    # Make new note
    alias mknote="cd $Dropbox/Notes && $MDEdit"

    # Open school work
    alias school="cd $Dropbox/Education/E.\ 2017-2018\ Kings\ II && ranger"

    # Christmas notes
    alias xmas="$MDEdit $Dropbox/Notes/2017\ Christmas.md"

    # Journal
    alias journal="veracrypt --mount $Dropbox/Journal && ranger /Volumes/NO\ Name/ \
        && veracrypt -d $Dropbox/Journal"

    #############################################################################
    # Print weather to terminal
    #############################################################################
    if [[ $(command -v wget) ]] ; then
        alias weather='wget -qO - http://wttr.in/ | head -7'
        alias todays-weather="wget -qO - http://wttr.in/ | head -17 | tail -n +8"
    elif [[ $(command -v curl) ]] ; then
        alias weather='curl -s http://wttr.in/ | head -7'
        alias todays-weather="curl -s http://wttr.in/ | head -17 | tail -n +8"
    fi
