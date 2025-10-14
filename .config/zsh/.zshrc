# source antidote
source "$ZDOTDIR/antidote/antidote.zsh"

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# Load completions from nix packaged programs
fpath=(~/.nix-profile/share/zsh/site-functions $fpath)

# source global shell alias & variables files
[[ -f "$XDG_CONFIG_HOME/shell/alias.sh" ]] && source "$XDG_CONFIG_HOME/shell/alias.sh"
[[ -f "$XDG_CONFIG_HOME/shell/vars.sh" ]] && source "$XDG_CONFIG_HOME/shell/vars.sh"

# zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive comp
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colored comp
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always $realpath'

autoload -Uz compinit
compinit

# History
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTDUPE=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
