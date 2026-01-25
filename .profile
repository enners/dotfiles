# shell env
export LANG="de_DE.utf8"
export EDITOR="/sbin/nvim"
export VISUAL="/sbin/nvim"
export LC_MESSAGES="de_DE.utf8"
export HISTCONTROL=ignoreboth:erasedups
LC_MESSAGES=C # en in shell itself
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="fd --strip-cwd-prefix"

# alias
alias bc='bc -q'
alias gnucash='env LC_MESSAGES=de_DE.utf8 gnucash'
alias htop="btm -b --theme nord"
alias l="ls -Ah1"
alias ll="ls -Ahl"
alias open="xdg-open"
alias panchostart="wol 00:24:1D:DC:B6:93"
alias panchostop="ssh -t pancho 'sudo /sbin/poweroff'"
alias sysupdate="sudo pacman -Suy && rua upgrade && rustup update"
alias vi="nvim"
alias zi="sudo extpool.sh"
alias zx="sudo zpool export extpool"
#alias rebase-develop="git rebase -i HEAD~$(git rev-list --count HEAD ~develop)"

# gpu accel
export VDPAU_DRIVER=va_gl
export RUSTICL_ENABLE=iris

# cd backup
alias cdbackup='abcde -o flac -acddb,tag,playlist,cue,move,clean -N -x'

# go
export GOROOT=/usr/lib/go
#export GOPATH=$HOME/dev/go
export GOPATH=$HOME/work/gvl/go
export PATH="${PATH}:${GOPATH}/bin"

# npm
export PATH="${PATH}:./node_modules/.bin"

# python
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.local/share/nvim/mason/bin"

# rust
export PATH="${PATH}:${HOME}/.cargo/bin"

# java
export JAVA_HOME="/usr/lib/jvm/default"
export JDTLS_JVM_ARGS="-javaagent:/usr/lib/lombok-common/lombok.jar"
export WORKSPACE="$HOME/work"

# git
export GIT_PS1_SHOWDIRTYSTATE=1

# fix wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export BEMENU_BACKEND="wayland"
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1
export GDK_SCALE=2
#export GDK_DPI_SCALE=1.5
export QT_AUTO_SCREEN_SCALE_FACTOR=2

# keyboard layout
export XKB_DEFAULT_LAYOUT="de,us"
export XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle

# passwords
export PASSWORD_STORE_DIR="/home/knut/.local/share/pass"

# ICE project settings
source ~/work/ice/cfg/profile.sh
