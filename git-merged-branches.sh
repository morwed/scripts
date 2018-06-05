#!/bin/sh

git branch -r --merged | while read branch
do
	if [ "$branch" != "origin/HEAD -> origin/develop" ]  && [ "$branch" != "origin/develop" ];
	then
		name=`git log --pretty=format:"%Cred%an%Creset" -1 $branch`
		time=`git log --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" -1 $branch`
		echo $time $name $branch
	fi
done | sort
