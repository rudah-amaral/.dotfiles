# Welcome to my dotfiles repo!
### How to install them?
```
git clone https://github.com/rudah-amaral/.dotfiles $HOME/.dotfiles --bare 
git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME reset --hard
```
### How to make repo not show the status of untracked files
```
dotfiles config --local status.showUntrackedFiles no
```
### This enables fugitive to manage the repo
```
dotfiles config --local core.worktree $HOME
```
P.S if the `dotfiles` alias don't work, just substitute him with

`git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME`

P.P.S. Although core.worktree is set, fugitive will not complain that it isn't
compatible with core.bare as long as we invoke nvim prefixed with the
GIT_WORK_TREE=$HOME enviroment variable. In those cases use the `dotfilesDiff`
alias
