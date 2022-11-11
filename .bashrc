# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

title='\[\e]2;\u@\h: $PWD $(__git_ps1 "| %s")\a\]'
promt='[\u@\h \W]\$ '
PS1=$title$promt

# enable color support of ls and also add handy aliases
if [ -x /bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# fzf fuzy search 
. /usr/share/fzf/completion.bash
. /usr/share/fzf/key-bindings.bash

# git info prompt
. /usr/share/git/git-prompt.sh
. /usr/share/git/completion/git-completion.bash

# non-login shells should load my settings, too
[ -f $HOME/.profile ] && . $HOME/.profile
[ -f $HOME/.Xresources ] && xrdb $HOME/.Xresources


