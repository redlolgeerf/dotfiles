# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export EDITOR=nvim

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
alias ls="ls -A"
alias cls="clear"
alias f="fg"

autoload -U colors && colors
export PATH=$PATH:/usr/local/go/bin:$HOME/Go/bin:$HOME/bin:$HOME/.local/bin

# completion settings
zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/home/eyeinthebrick/.zshrc'
autoload -Uz compinit
compinit

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
plugins=(git gitfast git-extras pip npm golang docker timer)

source $ZSH/oh-my-zsh.sh

# User configuration


unset GREP_OPTIONS

# /usr/bin/setxkbmap -option "ctrl:nocaps"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
# End of lines configured by zsh-newuser-install

export NVM_DIR=$HOME'/.nvm'
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

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
# fb - checkout git branch (excluding remote branches)
fb() {
  local branches branch
  branches=$(git branch | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
# fcf - files changed in branch
fcf() {
	local commits branch_name fork_point git_root
	git_root=$(git rev-parse --show-toplevel)
	branch_name=$(git rev-parse --abbrev-ref HEAD)
	fork_point=$(git merge-base --fork-point master "$branch_name")
	commits=$(git diff-tree -r "$fork_point".. --name-only)
	f="$(echo "$commits" | fzf-tmux -d $(( 2 + $(wc -l <<< "$commits") )) +m)"
	nvim "$git_root"'/'"$f"
}

jsearch() {
	local line
	setopt localoptions pipefail 2> /dev/null
	line="$(jira search $@ 2> /dev/null | fzf-tmux --preview="jira dump {1}" | cut -d' ' -f1)"
	print -z $line
}


# kill all background jobs
killbg() {
  jobs -l | grep --perl-regexp '\d{3,5}' --only-matching | xargs kill -9
}

dirty() {
  local files git_root
  git_root="$(git rev-parse --show-toplevel)"
  echo $git_root
  files="$(git diff --numstat 2>/dev/null | cut -f3 | sort -u | xargs -I{} echo -n $git_root'/'{}' ' )"
  [[ -n $files ]] && echo -n $files  | xargs vim
}

# #compdef pipenv
# _pipenv() {
  # eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh  pipenv)
# }
# if [[ "$(basename ${(%):-%x})" != "_pipenv" ]]; then
  # autoload -U compinit && compinit
  # compdef _pipenv pipenv
# fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# zprof
