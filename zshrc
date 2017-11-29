# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
alias ls="ls -A"
alias cls="clear"
alias py="nvim -p *.py"
alias clip="xclip -selection clipboard"
alias f="fg"
alias webadmin='PYTHONPATH=/home/redlolgeerf/work/da/python:/home/redlolgeerf/work/da/python/webadmin DJANGO_SETTINGS_MODULE=settings.development django-admin.py'

# paths for virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

export GOPATH=~/Go
export PATH=$PATH:$HOME/Go/bin:$HOME/bin

# completion settings
zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/home/eyeinthebrick/.zshrc'
autoload -Uz compinit
compinit

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# eval `dircolors $HOME/.dir_colors/dircolors.256dark`

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow pip npm go golang docker)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/bin
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# envoy -t ssh-agent -a ~/.ssh/id_rsa
# source <(envoy -p)

unset GREP_OPTIONS

/usr/bin/setxkbmap -option "ctrl:nocaps"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
# End of lines configured by zsh-newuser-install

export NVM_DIR=$HOME'/.nvm'
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export NVIM_TUI_ENABLE_TRUE_COLOR=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzf='fzf-tmux'
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_DEFAULT_OPTS="--extended --cycle"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fzf commands

# fshow - git commit browser
fshow() {
  local out sha q
  while out=$(
      git log --decorate=short --graph --oneline --color=always |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}
# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}
# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


# kill all background jobs
killbg() {
  # jobs -l | awk '{printf $3" "}' | xargs kill -9
  jobs -l | grep --perl-regexp '\d{3,5}' --only-matching | xargs kill -9
}

function _virtualenv_auto_activate() {
    if [ -e ".env" ]; then
        # Check for symlink pointing to virtualenv
        if [ -L ".env" ]; then
          _VENV_PATH=$(readlink .env)
          _VENV_WRAPPER_ACTIVATE=false
        # Check for directory containing virtualenv
        elif [ -d ".env" ]; then
          _VENV_PATH=$(pwd -P)/.env
          _VENV_WRAPPER_ACTIVATE=false
        # Check for file containing name of virtualenv
        elif [ -f ".env" -a $VENV_WRAPPER = "true" ]; then
          _VENV_PATH=$WORKON_HOME/$(cat .env)
          _VENV_WRAPPER_ACTIVATE=true
        else
          return
        fi

        # Check to see if already activated to avoid redundant activating
        if [ "$VIRTUAL_ENV" != $_VENV_PATH ]; then
            if $_VENV_WRAPPER_ACTIVATE; then
              _VENV_NAME=$(basename $_VENV_PATH)
              workon $_VENV_NAME
            else
              _VENV_NAME=$(basename `pwd`)
              VIRTUAL_ENV_DISABLE_PROMPT=1
              source .env/bin/activate
              _OLD_VIRTUAL_PS1="$PS1"
              PS1="($_VENV_NAME)$PS1"
              export PS1
            fi
            echo Activated virtualenv \"$_VENV_NAME\".
        fi
    fi
}

export PROMPT_COMMAND=_virtualenv_auto_activate
if [ -n "$ZSH_VERSION" ]; then
  function chpwd() {
    _virtualenv_auto_activate
  }
fi
