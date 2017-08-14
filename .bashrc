# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# User specific aliases and functions
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	source /usr/share/git-core/contrib/completion/git-prompt.sh
fi
export PS1='\u@\h \[\e[38;5;6m\]\W\[\e[38;5;124m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '
