# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/cbown75/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/cbown75/.fzf/bin"
fi

eval "$(fzf --zsh)"
