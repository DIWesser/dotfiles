#################################################################################
# Variables
#################################################################################
Edit=nvim
MDEdit=nvim
Dropbox="$HOME/Dropbox"
CurrentGnuCoreutils=true
kernel=$(uname -s)
if [ -f $HOME/.config/diwesser/device-id ]; then
    settings="$HOME/.config/diwesser/device-id"
    hostName=$(grep -iw '^\s*host:' $settings | cut -d: -f2 | xargs)
    userName=$(grep -iw '^\s*user:' $settings | cut -d: -f2 | xargs)
    myTimezone=$(grep -iw '^\s*timezone:' $settings | cut -d: -f2 | xargs)
fi

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

    # Lock computer from terminal
    alias lock='
    /System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

    # Mute
    alias mute='osascript -e "set Volume 0"'

    # Make VeraCrypt CLI sane.
    alias veracrypt='/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt'

    # Make Carbon Copy Cloner CLI sane.
    alias ccc='/Applications/Carbon\ Copy\ Cloner.app/Contents/MacOS/ccc'

    # Human readable uptime
    alias uptime-p="uptime | sed 's/,//g' | cut -f 4-6 -d ' '|
        sed 's/\(.*\):\(.*\)/\1 hours \2mins/'"

fi
#################################################################################
# Linux
#################################################################################
if [[ $(uname -s) == Linux ]] ; then
    alias osfamily="echo 'Linux'"

fi

#################################################################################
# Device and Account Specific
#################################################################################
if [[ $hostName == "hermes" || $hostName == "elli" || $hostName == "cronus" ||
    $(uname -n | grep Journalism.ukings.ns.Ca) ]] ; then
    # `<current directory> >`
    PS1='\[\033[0;35m\]\W > \[\033[0m\]'
else
    # `<user>@<current directory> >`
    PS1='\[\033[0;34m\]\u\[\033[0m\]@\[\033[0;34m\]\h \[\033[0;35m\]\W > \[\033[0m\]'
fi

#################################################################################
# All Operating Systems and Devices
#################################################################################
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Use Neovim as default editor
VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR

# Use my scripts
export PATH=~/bin:$PATH

    #############################################################################
    # Aliases
    #############################################################################
    # Basic bash and navigation
        # Lazyness
            alias :q="exit"
            alias :Q="exit"
            alias clr="clear"
            alias ..="cd .."
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

    # Use NeoVim a bit more (If it actually exists)
    if [[ $(command -v nvim) ]] ; then
        #alias vi='nvim'
        alias vim='nvim'
    fi

    # Dalhousie VPN
    if [ -x /opt/cisco/anyconnect/bin/vpn ]; then
        alias dalvpn-connect='/opt/cisco/anyconnect/bin/vpn connect vpn.its.dal.ca'
        alias dalvpn-exit='/opt/cisco/anyconnect/bin/vpn disconnect'
    fi

    # Stream instrumental pop covers
    if [[ $(command -v mpv) ]] ; then
        alias studystream='mpv --vid=no https://www.youtube.com/playlist?list=PLsUMoyJKBqcn7dk3jC3i1023Ie-BntpgF'
    fi

    # Print time in prefered timezone
    if [[ !$(command -v mytime) ]] ; then
        alias mytime='env TZ=$myTimezone date +"%H:%M %Z"'
    fi

    # Check if if internet connection is live
    alias netcheck="ping -c3 8.8.8.8 | egrep '(bytes from | No route to host)'"

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
    alias school="
        cd $Dropbox/Education/F.\ 2017-2018\ Kings\ II\ Term\ 2 && ranger"

    # Christmas notes
    alias xmas="$MDEdit $Dropbox/Notes/Christmas\ Gifts.md"

    # Journal
    if [[ $(uname -s) == Darwin ]] ; then
        alias journal="veracrypt --text --mount $Dropbox/Journal /Volumes/Journal \
            && ranger /Volumes/Journal/ && veracrypt -d $Dropbox/Journal"
    elif [[ $(uname -s ) == Linux ]] ; then
        alias journal="veracrypt --text --mount $Dropbox/Journal /media/Journal \
            && ranger /media/Journal/ && veracrypt -d $Dropbox/Journal"
    fi

    #############################################################################
    # Misc
    #############################################################################
    # Print weather to terminal
    if [[ $(command -v wget) ]] ; then
        alias weather='wget -qO - http://wttr.in/ | head -7'
        alias todays-weather="wget -qO - http://wttr.in/ | head -17 | tail -n +8"
    elif [[ $(command -v curl) ]] ; then
        alias weather='curl -s http://wttr.in/ | head -7'
        alias todays-weather="curl -s http://wttr.in/ | head -17 | tail -n +8"
    fi

#################################################################################
# Remove Variables
#################################################################################
unset CurrentGnuCoreutils
unset MDEdit
