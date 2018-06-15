# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# User specific aliases and functions

# Git Completion and Prompt Setup. 
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -f ~/.git-completion.bash ]; then
	source ~/.git-completion.bash
else
	wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
	source ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
	source ~/.git-prompt.sh
else
	wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
	source ~/.git-prompt.sh
fi
export PS1='\u@\h \[\e[38;5;6m\]\W\[\e[38;5;124m\] $(__git_ps1 " (%s)")\[\e[0m\]\$ '
