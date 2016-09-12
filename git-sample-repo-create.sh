#!/usr/bin/env bash

# git-sample-repo-create.sh from within http://github.com/wilsonmar/git-utilities.
# by Wilson Mar (wilsonmar@gmail.com
# This creates and populates a sample repo for my "Git and GitHub" tutorial,
# Explained at https://wilsonmar.github.io/git-commands-and-statuses/)

# Sample call in MacOS Terminal shell window:
# chmod +x git-sample-repo-create.sh
# ./git-sample-repo-create.sh

# Tested on MacOS 10.11 (El Capitan)
# TODO: Get a version that works on Windows

TMP='git-sample-repo'
clear
# Make the beginning of run easy to find:
echo "**********************************************************"
echo "******** STEP 01: Delete \"$TMP\" remnant from previous run:"
rm -rf ${TMP}
mkdir ${TMP}
cd ${TMP}

echo "******** STEP Init repo :"
# init without --bare so we get a working directory:
git init
# return the .git path of the current project::
git rev-parse --git-dir
ls -al
ls .git/

echo "******** STEP Make develop the default branch instead of master :"
cat .git/HEAD
# Change from default "ref: refs/heads/master" :
# See http://www.kernel.org/pub/software/scm/git/docs/git-symbolic-ref.html
git symbolic-ref HEAD refs/heads/develop
cat .git/HEAD
git branch
DEFAULT_BRANCH="develop"
echo $DEFAULT_BRANCH

# This is when remote is used :
# git remote set-head origin develop
# git config branch.develop.remote origin
# git config branch.develop.merge refs/heads/develop

echo "******** STEP Config:"
# See https://git-scm.com/docs/pretty-formats :
git config user.name "Wilson Mar"
git config user.email "wilsonmar@gmail.com"
# echo "$GIT_COMMITTER_EMAIL=" $GIT_COMMITTER_EMAIL
# echo $GIT_AUTHOR_EMAIL
# Verify settings:
git config user.name
git config user.email
git config core.filemode false

# On Unix systems, ignore ^M symbols created by Windows:
# git config core.whitespace cr-at-eol

# Change default commit message editor program to Sublime Text (instead of vi):
git config core.editor "~/Sublime\ Text\ 3/sublime_text -w"

# Allow all Git commands to use colored output, if possible:
git config color.ui auto

# See https://git-scm.com/docs/pretty-formats :
git config alias.l "log --pretty='%Cred%h%Creset %C(yellow)%d%Creset | %Cblue%s%Creset | (%cr) %Cgreen<%ae>%Creset' --graph"
git config alias.s "status -s"
git config alias.w "show -s --quiet --pretty=format:'%Cred%h%Creset | %Cblue%s%Creset | (%cr) %Cgreen<%ae>%Creset'"

# Have git diff use mnemonic prefixes (index, work tree, commit, object) instead of standard a and b notation:
git config diff.mnemonicprefix true

# Dump config file:
# git config --list

echo "******** STEP First commit: a"
touch README.md
git add .
git commit -am "a"

echo "******** STEP Second commit:"
echo ".DS_Store">>.gitignore
git status
git add .
# git status
git commit -m "b"
git l

echo "******** STEP Third commit: branch F1"
git tag v1
git checkout v1 -b F1
git branch
git l

echo "******** STEP Fourth commit: c"
echo "MIT">>LICENSE.md
git add .
git commit -m "c"
git l

echo "******** STEP commit: d"
echo "free!">>LICENSE.md
echo "d">>file-d.txt
git add .
git commit -m "d"
git l

echo "******** STEP Merge:"
git checkout $DEFAULT_BRANCH
#git merge F1 --no-commit
# git merge F1 --no-ff <:q
git merge F1 --no-ff
# Manually type ":q" to exit merge.
git commit -m "merge F1"
git branch
git l

#echo "******** $NOW Remove Merge branch ref:"
#git branch -d F1
#git branch
#git l

echo "******** STEP commit: e"
echo "e">>file-e.txt
git add .
git status
git commit -m "e"
git l

echo "******** STEP commit: f"
echo "f">>file-f.txt
ls -al
git add .
git commit -m "f"


# Undo last commit, preserving local changes:
# git reset --soft HEAD~1

# Undo last commit, without preserving local changes:
# git reset --hard HEAD~1

# Undo last commit, preserving local changes in index:
# git reset --mixed HEAD~1

# Undo non-pushed commits:
# git reset origin/$DEFAULT_BRANCH

# Reset to remote state:
# git fetch origin
# git reset --hard origin/$DEFAULT_BRANCH


echo "Copy this and paste to a text edit for reference: --------------"
git l
echo "******** show HEAD : ---------------------------------------"
git w HEAD
echo "******** show HEAD~1 :"
git w HEAD~1
echo "******** show HEAD^ :"
git w HEAD^
echo "******** show HEAD^1 :"
git w HEAD^1
echo "******** show HEAD~2 :"
git w HEAD~2
echo "******** show HEAD^^ :"
git w HEAD^^
echo "******** show HEAD^2 :"
git w HEAD^2
echo "******** show HEAD~3 :"
git w HEAD~3
echo "******** show HEAD^^^ :"
git w HEAD^^^
echo "******** show HEAD^3 :"
git w HEAD^3
echo "******** show HEAD~4 :"
git w HEAD~4
echo "******** show HEAD~1^1 :"
git w HEAD~1^1
echo "******** show HEAD~1^2 :"
git w HEAD~1^2
echo "******** show HEAD~1^3 :"
git w HEAD~2^1
echo "******** show HEAD~2^2 :"
git w HEAD~2^2
echo "******** show HEAD~2^3 :"
git w HEAD~2^3

echo "******** Reflog: ---------------------------------------"
git reflog

echo "******** Create archive file, excluding .git directory :"
NOW=$(date +%Y-%m-%d:%H:%M:%S-MT)
FILENAME=$(echo ${TMP}_${NOW}.zip)
echo $FILENAME
# git archive --format zip --output ../$FILENAME  F1
# ls -l ../$FILENAME

echo "******** checkout c :"
ls -al
git checkout HEAD@{5}
ls -al

# echo "******** Cover your tracks:"
# Remove from repository all locally deleted files:
# git rm $(git ls-files --deleted)

# Move the branch pointer back to the previous HEAD:
# git reset --soft HEAD@{1}

# Commented out for cleanup at start of next run:
# cd ..
# rm -rf ${TMP}

echo "******** $NOW end."
