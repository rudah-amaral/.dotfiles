# ALWAYS sourced first, so keep customizations out of it
# Just set some useful defaults

# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export MANPAGER="less -R --use-color -Dd+r -Du+b" # colored man pages

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
