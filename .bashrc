# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# User specific aliases and functions
source ~/.git-prompt.sh
export PS1='\u@\h \[\e[38;5;6m\]\W\[\e[38;5;124m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '
