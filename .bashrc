alias qm="matlab -nodisplay -nojvm;stty sane"
alias m="matlab -nosplash -nodesktop;stty sane"
alias c=cat
alias u=ls
alias e=less
alias rg="grep -R --color=auto"
alias du0="du -sh ."
alias du1="du -h --max-depth=1 ."
alias par="parallel -C' ' --progress"
alias ckill="cat jobids | xargs scancel"
alias py="ipython console --no-banner --pylab"
alias re="source ~/.bashrc"
alias m="make -j"
alias nvs="watch --interval=0.5 nvidia-smi"
alias g=git
alias v=vim
alias sum="/home/jonlong/caffe2/tools/extra/summarize.py"
alias cr=clear

function prof {
    PYTHONPATH=.:$PYTHONPATH caffe time -gpu $1 -iterations $2 -model $3 2>&1 | tee time
}

function cdx {
    cd /home/jonlong/x/caffe/exp/$(basename $(pwd))
}

function cde {
    cd /home/jonlong/caffe2/exp/$(basename $(pwd))
}

function run {
    stdbuf -oL python solve.py $1 $2 2>&1 | tee $3
}

function clean {
    dirname=/home/jonlong/x/caffe/exp/$(basename $(pwd))
    echo $dirname
    rm -Ir $dirname
}

function use {
    export PYTHONPATH=/home/jonlong/$1/python:$PYTHONPATH
}

function mcd {
    mkdir -p $@ && cd $@
}

# dammit MKL
export LD_PRELOAD=$HOME/anaconda/lib/libmkl_core.so:$HOME/anaconda/lib/libmkl_sequential.so

export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/home/jonlong/anaconda/lib:/usr/local/lib
export PYTHONPATH=/home/jonlong/caffe/python:/home/jonlong/util:/usr/lib/python2.7/dist-packages
export PATH=/home/jonlong/caffe/build/tools:/home/jonlong/anaconda/bin:$PATH

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# yes please
set -o vi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
color_prompt=yes
else
color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1='\n\[\e[33;1m\]\! ($?) \d \t \u\[\e[0m\]@\[\e[32;1m\]\h\[\e[0m\]:\[\e[34;1m\]\w\[\e[0m\]`__git_ps1`\n\$\$\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -h'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


eval "$(hub alias -s)"
