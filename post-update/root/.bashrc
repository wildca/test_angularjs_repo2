# ensure SHELL and HOME variables are set
if [[ -n "$SHELL" ]] ; then
	SHELL="/bin/bash"
fi
if [[ -n "$HOME" ]] ; then
	HOME="/root"
fi
export HOME SHELL

# Switch to ~/.
cd

# do not save dupes in the bash history file
export HISTSIZE=1000000
export HISTFILESIZE=10000000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%a %d.%m.%Y %H:%M:%S "

# You may uncomment the following lines if you want ls to be colorized:
export LS_OPTIONS='--color=auto'
eval `dircolors`
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

# Aliases to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Aliases for less typing
alias rd='rmdir'
alias md='mkdir'
alias ..='cd ..'
alias ...='cd ../..'

# Grep subversion source directories
alias sgrep='grep --color=always --exclude-dir=.svn --exclude-dir=tmp --exclude ".*.swp" --exclude "*.old" --exclude "*.rej" --exclude "*.orig" --exclude "patch.*" --exclude "*.patch"'

# Recursive du, sorted desc by size, limited to NUM entries
function rdu() {
	local PATHS=()
	local NUM=50
	while [ -n "$1" ]; do
		if [ -e "$1" ]; then
			PATHS=("${PATHS[@]}" "$1")
		elif [ -z "${1//[0-9]/}" ]; then
			NUM=$1
		else
			echo "Unknown argument '$1'"
		fi
		shift
	done
	du -xm "${PATHS[@]}" | sort -rn | head -n $NUM | sort -k2
}

# Locale
export LC_ALL=C

# Tune less
eval $(lesspipe)
export LESS="-M -S -I"
export PAGER=less
alias more='less'

# Midnight Commander needs this to run in color mode
export COLORTERM=1

# Python
export PYTHONSTARTUP=/etc/python/pythonrc.py

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm*) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		color_prompt=yes
	else
		color_prompt=
	fi
fi

GIT_PS1_SHOWDIRTYSTATE=1

c_fg() {
	echo "\\[\\033[38;5;"$1"m\\]"
}

c_host() {
	c_fg $((16+$((0x3&0x${1:0:1}+2))*6+$((0x3&0x${1:1:1}+2))*6+$((0x3&0x${1:2:1}+2))))
}

c_user() {
	test $EUID -ne 0 && c_fg 69 || c_fg 196
}

c_rst() {
	echo "\\[\\e[0m\\]"
}

if [ "$color_prompt" = yes ]; then
	PS1="${debian_chroot:+($debian_chroot)}${PS1UC:=$(c_user)}\u$(c_rst)$(c_fg 252)@${PS1HC:=$(c_host $(md5sum <<<"${HOSTNAME}"))}\h$(c_fg 252):$(c_fg 117)\w$(c_fg 208)\$(__git_ps1 2>/dev/null) $(c_fg 252)\\$ $(c_rst)"
else
	PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 2>/dev/null) \$ "
fi
unset color_prompt force_color_prompt