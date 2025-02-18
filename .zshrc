if [[ $TERM_PROGRAM == 'ghostty' ]]; then
  if [[ -z $TMUX ]]; then
    exec tmux
  fi
fi

# Unicode language support
export LC_ALL=en_US.UTF-8

# Keybinds
bindkey -v

bindkey ^R history-incremental-search-backward
bindkey ^S history-incremental-search-forward

# Options
setopt prompt_subst

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

if [[ $TERM_PROGRAM == 'tmux' ]]; then
  ZSH_THEME="starship"
else
  ZSH_THEME="robbyrussell"
fi

plugins=(
  git
  z
)

if [[ $TERM_PROGRAM == 'tmux' ]]; then
  plugins=($plugins zsh-syntax-highlighting)
fi

source "$ZSH/oh-my-zsh.sh"

# Editor
alias code="cursor"

export EDITOR="cursor"

if [[ $TERM_PROGRAM == 'tmux' ]]; then
  export EDITOR="nvim"
fi

# Aliases
if [[ $TERM_PROGRAM == 'tmux' ]]; then
  alias ls="eza"
  alias vim="nvim"
fi

alias lzg="lazygit"

alias gck="git checkout"
alias gcp="git cherry-pick"
alias gca="git commit --amend"
alias glg="git log    --graph --oneline"
alias gsp="git status --porcelain"

alias zshconfig="vim $HOME/Developer/Personal/gfiles/.zshrc"
alias vimconfig="vim $HOME/Developer/Personal/gfiles/.config/nvim/init.lua"
alias tmuxconfig="vim $HOME/Developer/Personal/gfiles/.tmux.conf"
alias ghosttyconfig="vim $HOME/Developer/Personal/gfiles/.config/ghostty/config"
alias starshipconfig="vim $HOME/Developer/Personal/gfiles/.config/starship.toml"
alias aerospaceconfig="vim $HOME/Developer/Personal/gfiles/.config/aerospace/aerospace.toml"

# Evals
eval "$(fnm env --use-on-cd)"

# Exports
export PATH="$PATH:$HOME/.scripts"
export PATH="$PATH:$HOME/.cargo/bin"

export HOMEBREW_NO_AUTO_UPDATE=1

# Haskell
[ -f "/Users/gabrielmoreno/.ghcup/env" ] && source "/Users/gabrielmoreno/.ghcup/env"

# Bun completions
[ -s "/Users/gabrielmoreno/.bun/_bun" ] && source "/Users/gabrielmoreno/.bun/_bun"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# Go
export PATH="$HOME/go/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Deno
export DENO_INSTALL="/Users/gabrielmoreno/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# PNPM
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# SST
export PATH=/Users/gabrielmoreno/.sst/bin:$PATH

# AWS
export AWS_SDK_LOAD_CONFIG=1

# Python
export PYTHON="/opt/homebrew/bin/python3"

# Fetch
if [[ $TERM_PROGRAM == 'tmux' ]]; then
  macfetch
fi
