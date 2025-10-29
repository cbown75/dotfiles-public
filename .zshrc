if [[ -d "/opt/homebrew/bin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export HOMEBREW_PREFIX="/opt/homebrew"
fi

export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$HOME/.cargo/bin:/opt/homebrew/opt/openjdk/bin:$HOME/.local/bin:$PATH

if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
  echo "Installing Powerlevel10k theme..."
  git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/fzf-tab ]]; then
  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/fzf-tab
fi

if [[ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions ]]; then
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
fi

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

if [[ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/you-should-use ]]; then
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/you-should-use
fi

if [[ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-autosuggestions ]]; then
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-autosuggestions
fi

export PATH="$HOME/go/bin:$PATH"
if [ ! -f "$HOME/go/bin/mcp-grafana" ] && command -v go &> /dev/null; then
    go install github.com/grafana/mcp-grafana/cmd/mcp-grafana@latest
fi

export KUEBCONFIG="$HOME/.kube/config"

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

source ~/.rc/.commonrc
if [ -r ~/.sshrc ]; then
  source ~/.sshrc
fi
if [ -r ~/.private/.cloudflarerc ]; then 
  source ~/.private/.cloudflarerc
fi
if [ -r ~/.private/.spaceliftrc ]; then
  source ~/.private/.spaceliftrc
fi
if [ -f ~/.private/.stratusrc ]; then
  source ~/.private/.stratusrc
fi
if [ -f ~/.rc/.fabricrc ]; then
  source ~/.rc/.fabricrc
fi
if [ -f ~/.rc/.installrc ]; then
  source ~/.rc/.installrc
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Set Perl local lib paths
PERL5_LOCAL="$HOME/perl5"
PATH="$PERL5_LOCAL/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$PERL5_LOCAL/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$PERL5_LOCAL${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$PERL5_LOCAL\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$PERL5_LOCAL"; export PERL_MM_OPT;
