# shell env
export LANG="de_DE.utf8"
export EDITOR="/sbin/nvim"
export VISUAL="/sbin/nvim"
export LC_MESSAGES="de_DE.utf8"
#export PATH="~/bin:$GOPATH/bin:$HOME/.cargo/bin:$PATH"
export PATH="$GOPATH/bin:$HOME/.cargo/bin:$PATH"

# alias
alias bc='bc -q'
alias ll="ls -lah"
alias vi="nvim"
alias wakepancho="wol 00:24:1D:DC:B6:93"
alias haltpancho="ssh -t pancho 'sudo /sbin/poweroff'"
alias zi="sudo extpool.sh"
alias zx="sudo zpool export extpool"

# gpu accel
export VDPAU_DRIVER=va_gl

# cd backup
alias cdbackup='abcde -o flac -acddb,tag,playlist,cue,move,clean -N -x'

# go
export GOROOT=/usr/lib/go
export GOPATH=$HOME/dev/go

# npm
export PATH="${PATH}:./node_modules/.bin"

# fix wayland
export _JAVA_AWT_WM_NONREPARENTING=1
#export IDEA_JDK=/usr/lib/jvm/java-11-openjdk
export BEMENU_BACKEND="wayland"
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1
export GDK_SCALE=2
#export GDK_DPI_SCALE=0.5
export QT_AUTO_SCREEN_SCALE_FACTOR=2
export XKB_DEFAULT_LAYOUT="de,us"
export XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle

# java
export JAVA_HOME="/usr/lib/jvm/default"
export JDTLS_HOME="/usr/share/java/jdtls"
export WORKSPACE="$HOME/work"

# fzf fuzy search
. /usr/share/fzf/completion.bash
. /usr/share/fzf/key-bindings.bash

# passwords
export PASSWORD_STORE_DIR="/home/knut/.local/share/pass"
