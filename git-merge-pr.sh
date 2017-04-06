#!/bin/sh

#set script to exist on error
set -e

masterBranch=develop
branch=NO_BRANCH_NAME

#check there's parameter for branch
if [ $# -le 0 ];
then
	echo "ERROR !"
	echo "missing parameter for branch name"
	echo "USAGE: git-merge-pr.sh <branch-name>"
	exit 1
else
	branch=$1
	echo "merging changes from branch: $branch\n"
fi

#check if current path is valid git repo
if ([ -d .git ] && (git rev-parse --is-inside-work-tree));
then
	echo "current path is a valid git repository\n"

	gitRepoURL=$(git config --get remote.origin.url)
	echo "remote repository url $gitRepoURL\n"

	#check if branch exists on origin
	if git ls-remote --heads --exit-code $gitRepoURL $branch;
	then
		echo "branch $branch exists on remote repo. checking out.\n"

		git checkout $branch

		#rebase latest changes from $masterBranch in the branch
		git rebase $masterBranch

		#should merge if there are conflicts when merging
		if $?; then
			echo "CONFLICTS! starting mergetool\n"
			git mergetool
		fi

		#check there are changes after rebase
		localStatus=$(git rev-parse --verify $branch)
		remoteStatus=$(git rev-parse --verify origin/$branch)

		if [ $localStatus = $remoteStatus ]; then
		    echo "NO changes to push to origin after rebase\n"
		else
		    echo "changes after rebase, force pushing to origin\n"
			git push -f
		fi

		#move to $masterBranch again
		echo "checking out $masterBranch\n"
		git checkout $masterBranch

		# to do : automatically accept the commit message
		git merge --no-ff --commit --no-edit $branch

		#?option to do push so I can put multiple PRs into only one
		#git push
	else
		echo "branch $branch was not found on remote repository at $gitRepoURL\n"
	fi
fi
