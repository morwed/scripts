
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


if [ -d ~/projects/vssh ]; then
	echo 'VSSH available'
	export PATH=$PATH:~/projects/vssh/
else
	echo 'NO vssh'
fi


export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


export nexusUser=<TO-BE-FILLED>
export nexusPassword=<TO-BE_FILLED>
export NEXUS_USER=$nexusUser
export NEXUS_PASSWORD=$nexusPassword
export DOCKER_MINDSHIFT_URL="docker-mindshift.int.secrz.com:80"
alias g="./gradlew"


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


find-up () {
	path=$(pwd)
	while [[ "$path" != "" && ! -e "$path/$1" ]]; do
		path=${path%/*}
	done
	echo "$path"
}

cdnvm(){
	cd "$@";
	nvm_path=$(find-up .nvmrc | tr -d '[:space:]')

	# If there are no .nvmrc file, use the default nvm version
	if [[ ! $nvm_path = *[^[:space:]]* ]]; then

		declare default_version;
		default_version=$(nvm version default);

		# If there is no default version, set it to `node`
		# This will use the latest version on your machine
		if [[ $default_version == "N/A" ]]; then
			nvm alias default node;
			default_version=$(nvm version default);
		fi

		# If the current version is not the default version, set it to use the default version
		if [[ $(nvm current) != "$default_version" ]]; then
			nvm use default;
		fi

		elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
		declare nvm_version
		nvm_version=$(<"$nvm_path"/.nvmrc)

		# Add the `v` suffix if it does not exists in the .nvmrc file
		if [[ $nvm_version != v* ]]; then
			nvm_version="v""$nvm_version"
		fi

		# If it is not already installed, install it
		if [[ $(nvm ls "$nvm_version" | tr -d '[:space:]') == "N/A" ]]; then
			nvm install "$nvm_version";
		fi

		if [[ $(nvm current) != "$nvm_version" ]]; then
			nvm use "$nvm_version";
		fi
	fi
}
alias cd='cdnvm'
