
export PATH="$PATH:/usr/local/sbin:/Users/emoraru/tools"


if [ -f /usr/local/etc/bash_completion ]; then
  echo "bash completion enabled"
  source /usr/local/etc/bash_completion
fi


if [ -e /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
  echo "git prompt enabled"
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWUPSTREAM="auto verbose"
  GIT_PS1_SHOWCOLORHINTS=true
  #source /usr/local/etc/bash_completion.d/git-prompt.sh
  export PROMPT_COMMAND='__git_ps1 "\033]0;${PWD##*/}\007\[\e[32m\]\u\[\e[m\]@\[\e[33m\]\H\[\e[m\]\[\e[37m\]/\[\e[m\]\[\e[31m\]\w\[\e[m\]" "\n\D{%F %T} >>"'
else
  export PS1='\033]0;${PWD##*/}\007\[\e[32m\]\u\[\e[m\]@\[\e[33m\]\H\[\e[m\]\[\e[37m\]/\[\e[m\]\[\e[31m\]\w\[\e[m\] `parse_git_branch`\n\D{%F %T} >>'
fi


if [ -d /usr/local/opt/coreutils ]; then
  echo "ls with directories first enabled"
  alias ll="gls -alh --group-directories-first --color=always"
else 
  alias ll="ls -al"
fi


if [ -h /Library/Java/Home ]; then
  echo "added JAVA_HOME"
  export JAVA_HOME=/Library/Java/Home
fi


if [ -d /usr/local/mysql/bin ]; then
  echo 'mysql set'
  export PATH=$PATH:/usr/local/mysql/bin
else
	echo 'mysql not set'
fi


if [ -d ~/tools/mongodb/bin ]; then
  echo 'mongodb set'
  export PATH=$PATH:~/tools/mongodb/bin
else
  echo 'mongodb not set'
fi


# Maximum number of history lines in memory
export HISTSIZE=50000
# Maximum number of history lines on disk
export HISTFILESIZE=50000
# Ignore duplicate lines
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file 
#  instead of overwriting it
shopt -s histappend

# After each command, append to the history file 
#  and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


export NPMRC_AUTH_TOKEN_AX=27ec2bc7-a6ee-41e3-9bf7-fd6cc9c160a6
