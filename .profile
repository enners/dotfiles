# shell env
export LANG="de_DE.utf8"
export EDITOR="/sbin/nvim"
export VISUAL="/sbin/nvim"
export LC_MESSAGES="de_DE.utf8"

# alias
alias vi="nvim"
alias caja="caja --no-desktop"
alias wakepancho="wol 00:24:1D:DC:B6:93"
alias haltpancho="ssh -t pancho 'sudo /sbin/poweroff'"
alias zi="sudo extpool.sh"
alias zx="sudo zpool export extpool"

# gpu accel
export VDPAU_DRIVER=va_gl

# cd backup
alias cdbackup='abcde -o flac -acddb,tag,playlist,cue,move,clean -N -x'

# go
export GOROOT=/snap/go/current
export GOPATH=$HOME/dev/go

export PATH=~/bin:$PATH:$GOPATH/bin

# fix wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1
export XKB_DEFAULT_LAYOUT=de

# nnn
export NNN_PLUG='s:open-selected $nnn'

export JAVA_HOME="/usr/lib/jvm/default"


export PATH="$HOME/.cargo/bin:$PATH"

# fzf fuzy search
. /usr/share/fzf/completion.bash

