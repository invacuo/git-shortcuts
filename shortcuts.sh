#!/bin/sh
#aliases for git commands
alias gs='git status'
alias gb='git branch'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gpf='git push -f'
alias gfr='gum && git fetch origin && git rebase origin/master'
alias prep='gum && git rebase -i origin/master'
alias snp='prep && git push'
alias gum='git co master && git pull && git co -'

function delbranch {
  if [ -z "$1" ]
    then
      echo "You need to specify a branchname";
    return 1;
  fi
  while true; do
    read -p "Are you sure you want to delete branch: $1?  : "  yn
    case $yn in
      [Yy]* ) git push origin --delete $1;git branch -D $1;break;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no.";;
    esac
  done
}

function mergeit {
  if [ -z "$1" ]
    then
      echo "You need to specify a branchname";
    return 1;
  fi
  while true; do
    git log origin/master..
    git diff --stat origin/master
    read -p "Are you sure you want to merge this branch to master?" yn
    case $yn in
      [Yy]* )   git push origin $1 && git checkout master && git merge $1 --ff-only && git push && delbranch $1;break;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no.";;
    esac
  done
}

function fixmaster {
  git fetch origin && git reset --hard origin/master
}
