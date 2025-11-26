# ============================================================
# PATH Configuration
# ============================================================

# Helper function to add directory to PATH if it exists and isn't already there
add_to_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Homebrew
if [[ -d "/opt/homebrew/bin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export HOMEBREW_PREFIX="/opt/homebrew"
fi

# Core paths (order matters - first in list = highest priority)
add_to_path "$HOME/bin"
add_to_path "/usr/local/sbin"
add_to_path "/usr/local/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "/opt/homebrew/opt/openjdk/bin"
add_to_path "$HOME/go/bin"
add_to_path "$HOME/perl5/bin"
add_to_path "/opt/homebrew/opt/libpq/bin"
# Note: pyenv/bin path is added by 'pyenv init' in .rc/.zsh-tools

# Source auto-installation script for Oh My Zsh and plugins
source ~/.rc/.zsh-autoinstall

# Enable Powerlevel10k instant prompt (must be near top of .zshrc)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add zsh-completions to fpath
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

export KUBECONFIG="$HOME/.kube/config"

# history setup
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt autocd

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"

ENABLE_CORRECTION="true"

plugins=( pass screen ssh-agent fzf-tab you-should-use zsh-syntax-highlighting zsh-autosuggestions direnv)
if ! [[ "$HOME" =~ "^/pass" ]] ; then
	plugins+=(git git-prompt)
fi

source $ZSH/oh-my-zsh.sh

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 7
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -la --git --icons $realpath'

# Source optional config files
[[ -r ~/.rc/.commonrc ]] && source ~/.rc/.commonrc
[[ -r ~/.sshrc ]] && source ~/.sshrc
[[ -r ~/.private/.cloudflarerc ]] && source ~/.private/.cloudflarerc
[[ -r ~/.private/.privaterc ]] && source ~/.private/.privaterc
[[ -r ~/.private/.spaceliftrc ]] && source ~/.private/.spaceliftrc
[[ -r ~/.private/.stratusrc ]] && source ~/.private/.stratusrc
[[ -r ~/.rc/.fabricrc ]] && source ~/.rc/.fabricrc
[[ -r ~/.rc/.installrc ]] && source ~/.rc/.installrc

# Initialize development tools
source ~/.rc/.zsh-tools

# Perl environment variables (PATH already set above)
export PERL5_LOCAL="$HOME/perl5"
export PERL5LIB="$PERL5_LOCAL/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$PERL5_LOCAL${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$PERL5_LOCAL\""
export PERL_MM_OPT="INSTALL_BASE=$PERL5_LOCAL"
