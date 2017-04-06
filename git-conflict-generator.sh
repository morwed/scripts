#!/bin/sh

# This script will set up a git repo with interesting conflicts in
# two branches.

# hello.txt and goodbye.txt have simple conflicts for illustrating the
# features of git merge, rebase, and am.

# mergetool.txt has a set of conflicts designed to test the capability
# of external merge tools.

# Run only in an empty directory.
# Need to check for hello.txt, goodbye.txt, mergetool.txt, and a .git dir
# and abort if found.

# TODO
# - Might be nice to do more than just one commit in each branch.  This
#   will illustrate how the git commands behave when dealing with
#   sequential commits.

# Be careful not to destroy an existing repo
if [ -d .git ]; then
  echo ".git directory found.  aborting..."
  exit 1
fi

git init

# Create the files
cat >mergetool.txt <<EOF
LINE 1
LINE 2
LINE 3
LINE 4: This will not be changed by anyone
EOF
echo "Hello, Original." >hello.txt
echo "Goodbye, Original." >goodbye.txt

# Add them to the index (stage them for commit)
git add mergetool.txt
git add hello.txt
git add goodbye.txt

# Commit them
git commit -m "Initial Commit"

# In a new branch "b1"
git checkout -b b1

# Make some changes...
sed -i '' "s/LINE 2/LINE 2: Branch b1 changed this./" mergetool.txt
sed -i '' "s/LINE 3/LINE 3: Branch b1 changed this./" mergetool.txt

# An additional commit to make things a little more interesting
git commit -a -m "Change branch b1, mergetool"

sed -i '' "s/Original/branch b1 change/" hello.txt
sed -i '' "s/Original/branch b1 change/" goodbye.txt

# Commit the changes
git commit -a -m "Change branch b1, hi/bye"

# Back in master...
git checkout master

# Make some conflicting changes...
sed -i '' 's/LINE 1/LINE 1: Branch master changed this./' mergetool.txt
sed -i '' 's/LINE 3/LINE 3: Branch master changed this./' mergetool.txt
sed -i '' "s/Original/master change/" hello.txt
sed -i '' "s/Original/master change/" goodbye.txt

# Commit the changes
git commit -a -m "Change master"
