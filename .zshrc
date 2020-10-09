# Language
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# XDG
export XDG_CONFIG_HOME="$HOME/.config/"

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone --depth 1 https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh
fi

# Essential
source ~/.zplug/init.zsh
# Let zplug manage zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Make sure to use double quotes to prevent shell expansion
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "junegunn/fzf-bin", \
  as:command, \
  from:gh-r, \
  rename-to:fzf, \
  use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf", \
  as:command, \
  use:"bin/fzf-tmux"
zplug "junegunn/fzf", \
  use:"shell/*.zsh"
zplug "zchee/go-zsh-completions"
zplug "zsh-users/zsh-autosuggestions", \
  use:"zsh-autosuggestions.zsh"

export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Tips for unused aliases
zplug "spatcholla/alias-tips"
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="💡  Try: "

# Docker completions
zplug "docker/cli", use:contrib/completion/zsh
zplug "docker/compose", use:contrib/completion/zsh

# Prezto modules
zplug 'modules/environment', from:prezto
zplug 'modules/terminal', from:prezto
zplug 'modules/editor', from:prezto
zplug 'modules/history', from:prezto
zplug 'modules/directory', from:prezto
zplug 'modules/spectrum', from:prezto
zplug 'modules/utility', from:prezto
zplug 'modules/completion', from:prezto
zplug 'modules/git', from:prezto
zplug 'modules/tmux', from:prezto

# Tmux
alias tmux="tmux -f ${HOME}/.tmux.conf"

# Spaceship
zplug 'denysdovhan/spaceship-prompt', \
  use:spaceship.zsh, \
  from:github, \
  as:theme

# export SPACESHIP_GIT_STATUS_PREFIX=" "
# export SPACESHIP_GIT_STATUS_SUFFIX=""
# export SPACESHIP_GIT_STATUS_ADDED="%F{yellow}•%F{red}"
# export SPACESHIP_GIT_STATUS_UNTRACKED="%F{blue}•%F{red}"
# export SPACESHIP_GIT_STATUS_DELETED="%F{red}•%F{red}"
# export SPACESHIP_GIT_STATUS_MODIFIED="%F{green}•%F{green}"

# Install packages that have not been installed yet
if ! zplug check --verbose; then
  echo; zplug install
fi

zplug load

# Add zplug bin directory to PATH
export PATH=$HOME/.zplug/bin:$PATH

# Environment
alias ls='ls --color=auto'
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Default less options
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
export LESS='-F -g -i -M -R -S -w -X -z-4'


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
# zsh-history-substring-search
if zplug check "zsh-users/zsh-history-substring-search"; then
  zmodload zsh/terminfo
  [ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
  [ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# Ignore gitignore with fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Local bin directory
export PATH=$HOME/.bin:$HOME/.local/bin:$PATH

# # Automatically launch a tmux session
# if [[ -z "$TMUX" ]]; then
#   tmux_session="$(echo $USER | tr -d '.')"
#
#   if tmux has-session -t "$tmux_session" 2>/dev/null; then
#     tmux attach-session -t "$tmux_session"
#   else
#     tmux new-session -s "$tmux_session"
#   fi
#
#   # if ! tmux has-session -t "$tmux_session" 2> /dev/null; then
#   #   # Disable the destruction of unattached sessions globally.
#   #   tmux set-option -g destroy-unattached off &> /dev/null
#
#   #   # Create a new session.
#   #   tmux new-session -d -s "$tmux_session"
#
#   #   # Disable the destruction of the new, unattached session.
#   #   tmux set-option -t "$tmux_session" destroy-unattached off &> /dev/null
#
#   #   # Enable the destruction of unattached sessions globally to prevent
#   #   # an abundance of open, detached sessions.
#   #   tmux set-option -g destroy-unattached on &> /dev/null
#   # fi
#
#   # exec tmux new-session -t "$tmux_session"
# fi

# Use only noevim
alias vim='nvim'
alias vi='vim'

function take ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

py-init() {
    python3 -m venv venv
    source venv/bin/activate
    pip install -U pip setuptools jedi black neovim pylama 
}

eval $(thefuck --alias)
