
export PATH="$PATH:/usr/local/sbin:~/tools/scripts"


if [ -f /usr/local/etc/bash_completion ]; then
	echo "bash completion enabled"
	source /usr/local/etc/bash_completion
else
	echo "NO bash completion"
fi


if [ -e /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
	echo "git prompt enabled"
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWUPSTREAM="auto verbose"
	GIT_PS1_SHOWCOLORHINTS=true
	export PROMPT_COMMAND='__git_ps1 "\033]0;${PWD##*/}\007\[\e[32m\]\u\[\e[m\]@\[\e[33m\]\H\[\e[m\]\[\e[37m\]/\[\e[m\]\[\e[31m\]\w\[\e[m\]" "\n\D{%F %T} >>"'
else
	echo "NO git branch on prompt command"
	export PS1='\033]0;${PWD##*/}\007\[\e[32m\]\u\[\e[m\]@\[\e[33m\]\H\[\e[m\]\[\e[37m\]/\[\e[m\]\[\e[31m\]\w\[\e[m\]\n\D{%F %T} >>'
fi


if [ -d /usr/local/opt/coreutils ]; then
	echo "ls with directories first enabled"
	alias ll="gls -alh --group-directories-first --color=always"
	MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
else
	echo "regular ll"
	alias ll="ls -alh"
fi


if [ -h /Library/Java/Home ]; then
	echo "set JAVA_HOME"
	export JAVA_HOME=/Library/Java/Home
else
	echo "NO Java home"
fi


if [ -d /usr/local/mysql/bin ]; then
	echo 'MySQL available'
	export PATH=$PATH:/usr/local/mysql/bin
else
	echo 'NO MySQL'
fi


if [ -d ~/tools/mongodb/bin ]; then
	echo 'MongoDB available'
	export PATH=$PATH:~/tools/mongodb/bin
else
	echo 'NO MongoDB'
fi


if [ -d /usr/local/opt/node@8 ]; then
	echo "Added Node.js 8 to PATH"
	export PATH=/usr/local/opt/node@8/bin:$PATH
else
	echo "No Node.js 8"
fi


alias grd="./gradlew"


# Maximum number of history lines in memory
export HISTSIZE=50000
# Maximum number of history lines on disk
export HISTFILESIZE=50000
# Ignore duplicate lines
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


#enable iTerm shell integration
if [ -e "${HOME}/tools/scripts/.iterm2_shell_integration.bash" ]; then
  echo "enabled iTerm shell integration"
  source "${HOME}/tools/scripts/.iterm2_shell_integration.bash"
fi

