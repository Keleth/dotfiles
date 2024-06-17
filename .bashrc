# .bashrc

### EXPORT
#export TERM="xterm-256color"                      # getting proper colors
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
export ALTERNATE_EDITOR=""                        # setting for emacsclient
#export EDITOR="emacsclient -t -a ''"              # $EDITOR use Emacs in terminal
#export VISUAL="emacsclient -c -a emacs"           # $VISUAL use Emacs in GUI mode
export EDITOR="vim"
export VISUAL="gvim"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# git current branch function
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1="[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(parse_git_branch)\$ "
export PS1

unset rc

#alias feh="feh --image-bg black"
#alias mocp="mocp -T ~/.moc/themes/gruvbox_theme"
#alias emacs="emacsclient -c -a emacs"
alias up="sudo apt-get update && sudo apt-get dist-upgrade && flatpak update"
#alias rm="trash -v"
alias mkdir="mkdir -p"
#alias telegram='flatpak run org.telegram.desktop'
alias rmd='/bin/rm  --recursive --force --verbose '
#alias dmenu="dmenu -nb '#282c34' -nf '#bbc2cf' -sb '#3e4451' -sf '#98be65' -fn JetBrainsMono:bold:pixelsize=14"
#alias doomsync="~/.emacs.d/bin/doom sync"
#alias doomdoctor="~/.emacs.d/bin/doom doctor"
#alias doomupgrade="~/.emacs.d/bin/doom upgrade"
#alias doompurge="~/.emacs.d/bin/doom purge"
#alias ssh="TERM=xterm ssh"
alias scp_kesha="scp -r -P 6022 -i ~/.ssh/id_rsa"
#alias alacritty="/usr/local/bin/alacritty --config-file ~/.config/alacritty/alacritty.yml"
#alias mocp="/usr/bin/mocp -T ~/.config/moc/themes/gruvbox_theme"

alias fli="flatpak install --noninteractive -y flathub"
alias flr="flatpak remove --noninteractive -y"
alias fr="flatpak repair"
alias fl="flatpak list"

# Changing "ls" to "exa"
#alias ls='exa -al --color=always --group-directories-first' # my preferred listing
#alias la='exa -a --color=always --group-directories-first'  # all files and dirs
#alias ll='exa -l --color=always --group-directories-first'  # long format
#alias lt='exa -aT --color=always --group-directories-first' # tree listing
#alias qtilelog='tail -n 100 ~/.local/share/qtile/qtile.log' # qtail log
#alias l.='exa -a | egrep "^\."'


/opt/shell-color-scripts/colorscript.sh random
#echo "Сейчас за окном: "
#~/develop/bash/weather_day
#. "$HOME/.cargo/env"
