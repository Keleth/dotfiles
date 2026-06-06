# .bashrc

# JAVA
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

### EXPORT
#export TERM="xterm-256color"                      # getting proper colors
export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
#export ALTERNATE_EDITOR="vim"                        # setting for emacsclient
export TERMINAL="st"
export EDITOR="vim"          
export VISUAL="gvim"        
#export LF_ICONS=$(cat ~/.config/lf/ICONS)
export COLORTERM=truecolor
#export GTK_THEME=Adwaita:dark


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

# load cargo
#. "$HOME/.cargo/env"

# load git functions
. "$HOME/develop/bash/git-prompt.sh"

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

#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \e[35m$(__git_ps1 " %s")\e[0m\$ '
#export PS1="\e[32m\]\u\[\e[m\]@\e[36m\]\h\[\e[m\] \e[35m\]\w\[\e[m\] \e[34m\] \$(__git_ps1) \[\e[m\]\n└─ [\$?] \$ ▶ "
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 "%s") \$ '
export PS1

# autocomplete
#bind 'set show-all-if-ambiguous on'
#bind 'TAB:menu-complete'


unset rc

#alias feh="feh --image-bg black"
#alias mocp="mocp -T ~/.moc/themes/gruvbox_theme"
alias fk="sudo !!"
alias v="vim"
#alias up="sudo apt update && sudo apt upgrade"
alias up="epm update && epm full-upgrade"
#alias rm="trash-put"
alias mkdir="mkdir -p"
#alias rmd='/bin/rm  --recursive --force --verbose '
#alias dmenu="dmenu -nb '#282c34' -nf '#bbc2cf' -sb '#3e4451' -sf '#98be65' -fn JetBrainsMono:bold:pixelsize=14"
#alias ssh="TERM=xterm ssh"
#alias scp_kesha="scp -r -P 6022 -i ~/.ssh/id_rsa"

#GIT alias
#alias ec="emacsclient -r -a emacs"
alias ga="git add"
alias gcm="git commit -m"
alias gp="git push origin"
# abf
#alias abf-build="abf build -b rosa2023.1 -a x86_64 -r rosa13/main -r rosa13/contrib -r rosa13/non-free --no-extra-tests --save-to-repository keleth_personal/main --update-type newpackage"

alias s2chopper="java -jar /opt/s2chopper-1.0.jar"
alias chopper="ssh 192.168.1.40"
alias wtd="$HOME/develop/bash/weather_day"
alias wt="$HOME/develop/bash/weather"

alias fli="flatpak install --noninteractive -y flathub"
alias flr="flatpak remove --noninteractive -y"
alias fr="flatpak repair"
alias fl="flatpak list"

# VM
alias vm-list="virsh -c qemu+ssh://192.168.1.40/system list --all"
alias vm-start="virsh -c qemu+ssh://192.168.1.40/system start "
alias vm="ssh st@192.168.1.40 -p 2222"

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

#~/.local/bin/colorscript/colorscript.sh random
#echo "Сейчас за окном: "
#~/develop/bash/weather_day
##
#eval "$(starship init bash)"


export PATH="$HOME/.local/bin:$PATH"
