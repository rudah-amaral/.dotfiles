# Welcome to my dotfiles repo!

In this edition I've moved from a bare repo to GNU Stow managed dotfiles. Its
easier to set up, better to use and it plays nicer with vim fugitive.

## Installation instructions

First of all, clone the repo
```
git clone https://github.com/rudah-amaral/.dotfiles $HOME/.dotfiles
```

Then, use GNU Stow to create all the necessary symlinks.

```
cd ~/.dotfiles
stow .
```

Open a new session and everything should work by now!
