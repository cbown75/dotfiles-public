# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/cbown75/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/cbown75/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/cbown75/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/Users/cbown75/.fzf/shell/key-bindings.bash"
