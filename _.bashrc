# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


cudaV=cuda
export CUDA_HOME=/usr/local/${cudaV}
export PATH=/usr/local/${cudaV}/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/${cudaV}/lib64:/usr/local/${cudaV}/extras/CUPTI/lib64:$LD_LIBRARY_PATH
# For CUDA Toolkit >= 9.0


#export PYENV_ROOT="/home/mike/.pyenv"
#export PYENV_ROOT="/nfs/romanoff/ext01/mike/pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="/home/mike/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#source deactivate
#pyenv activate py374

source /home/mike/virtual_env/venv/bin/activate

#export CUDA_HOME=/home/mike/cuda
#export PATH=/home/mike/cuda/bin:$PATH
#export LD_LIBRARY_PATH=/home/mike/cuda/lib64:/home/mike/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
#alias python="pyenv exec python"
#
#export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64
#export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH						# For CUDA Toolkit <= 7.5
# if you want python2

cip=$(hostname -I)
ccip=${cip:0:15}
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export PYTHONDONTWRITEBYTECODE=1
alias jup='jupyter notebook --ip=$ccip --port=40088'
alias tbd='tensorboard --port 40055 --host $ccip'
alias nvd='nvidia-smi'
alias cnt='ls -f |wc -l'
alias tmux='tmux -2'
alias cd_rom='cd /nfs/romanoff/ext01/mike'
alias cd_max='cd /nfs/maximoff/ext01/mike'
alias cd_ssd='cd /nfs/koiu-ssd/mike'

function cd_ext(){
    cd /nfs/${1}/ext01/mike
}

# seop's function 
function go(){
    ssh -p 6150 mike@${1}.aitricsdev.com
}
function gpu(){
    CUDA_VISIBLE_DEVICES=$1 python $2
}
function cu(){
    CUDA_VISIBLE_DEVICES=$1 $2
}
function scp_go(){
    scp -P 6150 $1 mike@${2}.aitricsdev.com:/home/mike/${3}
}
function scp_come(){
    scp -P 6150 mike@${1}.aitricsdev.com:/home/mike/${2} $3
}
function scpr_go(){
    scp -P 6150 -r $1 mike@${2}.aitricsdev.com:/home/mike/${3}
}
function scpr_come(){
    scp -P 6150 -r mike@${1}.aitricsdev.com:/home/mike/${2} $3
}
function scp_go_all(){ 
    KNHOSTS="stark strange parker rogers banner romanoff maximoff quill lang groot fury rocket odinson gamora"
    echo $KNHOSTS
    for HO in $KNHOSTS ; do
        scp -P 6150 $1 mike@${HO}.aitricsdev.com:/home/mike/${2}
    done
}
function scpr_go_all(){ 
    KNHOSTS="stark strange parker rogers banner romanoff maximoff quill lang groot fury rocket odinson gamora"
    echo $KNHOSTS
    for HO in $KNHOSTS ; do
        scp -P 6150 -r $1 mike@${HO}.aitricsdev.com:/home/mike/${2}
    done
}
function whosusing(){
    ps axfo pid,euser,egroup,args | grep $1
}
function new_venv(){
    if [ -z "$2" ]
    then
        echo Error: specify python version
    else
        pyfull=$2
        pyver=${pyfull:0:3}
        virtualenv --system-site-packages -p $PYENV_ROOT/versions/${pyfull}/bin/python${pyver} --clear /home1/irteam/users/mspark/virtual_
env/${1}
    fi
    #source /home1/irteam/users/mspark/virtual_env/${1}/bin/activate
}
function venv(){
    virtualenv --system-site-packages -p $PYENV_ROOT/versions/3.8.4/bin/python3.8 $vname --clear /home/mike/virtual_env/${1}
    source /home/mike/virtual_env/${1}/bin/activate
}

