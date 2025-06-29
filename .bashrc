# .bashrc

# JAVA
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

### EXPORT
#export TERM="xterm-256color"                      # getting proper colors
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
export ALTERNATE_EDITOR=""                        # setting for emacsclient
export EDITOR="vim"           # $EDITOR use Emacs in terminal
export VISUAL="gvim"           # $VISUAL use Emacs in GUI mode
#export LF_ICONS=$(cat ~/.config/lf/ICONS)
export COLORTERM=truecolor

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

# PS1='\[\e[34m\]\t 🕒 \W/ 📂 ▶\[\e[m\]'
PS1="[\$(date +%k:%M:%S)] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(parse_git_branch)\$ "
export PS1

unset rc

alias lf="lfub"
alias feh="feh --image-bg black"
#alias mocp="mocp -T ~/.moc/themes/gruvbox_theme"
#alias emacs="emacsclient -c -a emacs"
#alias em="/usr/bin/emacs -nw"
alias up="sudo apt update && sudo apt upgrade"
#alias rm="trash -v"
alias mkdir="mkdir -p"
#alias telegram='flatpak run org.telegram.desktop'
alias rmd='/bin/rm  --recursive --force --verbose '
#alias dmenu="dmenu -nb '#282c34' -nf '#bbc2cf' -sb '#3e4451' -sf '#98be65' -fn JetBrainsMono:bold:pixelsize=14"
#alias ssh="TERM=xterm ssh"
alias scp_kesha="scp -r -P 6022 -i ~/.ssh/id_rsa"
#alias alacritty="/usr/local/bin/alacritty --config-file ~/.config/alacritty/alacritty.yml"
#alias mocp="/usr/bin/mocp -T ~/.config/moc/themes/gruvbox_theme"

alias fli="flatpak install --noninteractive -y flathub"
alias flr="flatpak remove --noninteractive -y"
alias fr="flatpak repair"
alias fl="flatpak list"
#alias ec="emacsclient -c -a emacs"

#alias qtilelog='tail -n 100 ~/.local/share/qtile/qtile.log' # qtail log


# zshrc or bashrc lf preview images
#lf () {
#	LF_TEMPDIR="$(mktemp -d -t lf-tempdir-XXXXXX)"
#	LF_TEMPDIR="$LF_TEMPDIR" lf-run -last-dir-path="$LF_TEMPDIR/lastdir" "$@"
#	if [ "$(cat "$LF_TEMPDIR/cdtolastdir" 2>/dev/null)" = "1" ]; then
#		cd "$(cat "$LF_TEMPDIR/lastdir")"
#	fi
#	rm -r "$LF_TEMPDIR"
#	unset LF_TEMPDIR
#}

~/.local/bin/colorscript/colorscript.sh random
#echo "Сейчас за окном: "
#~/develop/bash/weather_day
##
#eval "$(starship init bash)"

#
