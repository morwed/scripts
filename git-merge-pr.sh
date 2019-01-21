#!/bin/sh

#set script to exit on error
set -e

masterBranch=develop
branch=NO_BRANCH_NAME
debug=true

#check there's parameter for branch
if [ $# -le 0 ]; then
	echo "ERROR !"
	echo "missing parameter for branch name"
	echo "USAGE: git-merge-pr.sh <branch-name>"
	exit 1
else
	branch=$1
	echo "\nmerging changes from branch: $branch into $masterBranch\n"
fi

#check if current path is valid git repo
if ([ -d .git ] && (git rev-parse --is-inside-work-tree)); then
	if [ $debug ]; then echo "\n******\ncurrent path is a valid git repository\n"
	fi

	gitRepoURL=$(git config --get remote.origin.url)
	if [ $debug ]; then echo "\n******\nremote repository url $gitRepoURL\n"
	fi

	#check if branch exists on origin
	if git ls-remote --heads --exit-code $gitRepoURL $branch; then
		if [ $debug ]; then echo "\n******\nbranch $branch exists on remote repo. checking out.\n"
		fi
		git checkout $branch

		#rebase latest changes from $masterBranch in the branch
		git rebase $masterBranch

		#should merge if there are conflicts after rebase-ing
		conflict=false
		git status --porcelain | while read st file; do
			if [ "$st" == 'UU' ]; then
				if [ $debug ]; then echo "\n******\nconflicts detected in file $file"
				fi
				conflict=true
			fi
		done

		if [ $conflict ]; then
			if [ $debug ]; then echo "\n******\nstarting mergetool"
			fi
		    git mergetool
		fi

		#check there are changes after rebase
		localStatus=$(git rev-parse --verify $branch)
		remoteStatus=$(git rev-parse --verify origin/$branch)

		if [ $localStatus != $remoteStatus ]; then
		    if [ $debug ]; then echo "\n******\nchanges after rebase, force pushing to origin\n"
			fi
			git push -f
		else
		    echo "NO changes to push to origin after rebase\n"
		fi

		#move to $masterBranch again
		if [ $debug ]; then echo "\n******\nchecking out $masterBranch\n"
		fi
		git checkout $masterBranch

		#automatically accept the commit message
		git merge --no-ff --commit --no-edit $branch

		#todo: do push optional so I can merge multiple PRs
		if [ $# == 2 ] && [[ $2 == push ]]; then
			git push
		fi
	else
		echo "branch $branch was not found on remote repository at $gitRepoURL\n"
	fi
else
	echo "current path is NOT A VALID git repository\n"
fi
