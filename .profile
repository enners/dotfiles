# shell env
export EDITOR="/usr/bin/vim"
export LANG="de_DE.utf8"
export LC_MESSAGES="C"
export LOCATE_PATH="${HOME}/.cache/mlocate.db"
export PATH=$PATH:$HOME/bin/scala/bin:$HOME/bin/sbt/bin
alias ll='ls -lah'
alias signal="/usr/bin/chromium-browser \
    --profile-directory=Default \
    --app-id=bikioccmkafdpakkkcpdbppfkghcmihk"
alias gnucash="env LC_MESSAGES=de_DE.utf8 gnucash"

# cd backup
alias cdbackup='abcde -o flac -acddb,tag,playlist,cue,move,clean -N -x'

# go
export GOROOT=/usr/local/lib/go
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin
# suckless terminal
#alias st="stterm -f 'Ubuntu Mono:pixelsize=24' -T '$USER@$HOSTNAME: $PWD'"

