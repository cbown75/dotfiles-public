export PATH=/opt/homebrew:/opt/homebrew/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH

source ~/.commonrc
#source ~/.warpcli
if [ -r ~/.sshrc ]; then
  source ~/.sshrc
fi
if [ -r ~/.private/.cloudflarerc ]; then 
  source ~/.private/.cloudflarerc
fi
if [ -r ~/.private/.spaceliftrc ]; then
  source ~/.private/.spaceliftrc
fi
if [ -f ~/.private/.updaterrc ]; then
  source ~/.private/.updaterrc
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

export HOMEBREW_PREFIX=$(brew --prefix)

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

setopt autocd

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':omz:update' frequency 7

ENABLE_CORRECTION="true"

plugins=( pass terraform kubectl docker golang screen history ssh-agent kube-ps1 aws gcloud )
if ! [[ "$HOME" =~ "^/pass" ]] ; then
	plugins+=(git git-prompt)
fi

source $ZSH/oh-my-zsh.sh

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-you-should-use/you-should-use.plugin.zsh
