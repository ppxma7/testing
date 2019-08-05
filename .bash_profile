
EDITOR=nano
CLICOLOR=1

# FSL Configuration
FSLDIR=/usr/local/fsl
. ${FSLDIR}/etc/fslconf/fsl.sh
PATH=${FSLDIR}/bin:${PATH}
export PATH FSLDIR


export FREESURFER_HOME=/Applications/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
SUBJECTS_DIR=/Users/ppxma7/data/subjects
export SUBJECTS_DIR


export EDITOR CLICOLOR DISPLAY PATH FSLDIR     #LSCOLORS
export FSLOUTPUTTYPE=NIFTI_PAIR

# PTOA config
PATH=/Users/ppxma7/Documents/nottingham/bin:${PATH}
export PATH

#bash script commands
PATH=/Users/ppxma7/Documents:${PATH}
export PATH

PATH=/Users/ppxma7/Documents/nottingham/digitAtlas:${PATH}
export PATH

PATH=/usr/local/bin:${PATH}
export PATH

#Add afni path
#export PATH=/Users/ppxma7/abin:$PATH
#export DYLD_FALLBACK_LIBRARY_PATH=$HOME/abin
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages

#export AFNI_VERSION_CHECK=NO
#export AFNI_MOTD_CHECK=NO

echo 'Running FSL version:  ' `cat $FSLDIR/etc/fslversion`
# ---------------------------------------------------------------------

#colours
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

#git stuff

source ~/.git-completion.bash
source ~/.git-prompt.sh

MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
GIT_PS1_SHOWDIRTYSTATE=true
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

export PS1=$MAGENTA"\u"'$(
    if [[ $(__git_ps1) =~ \*\)$ ]]
    # a file has been modified but not added
    then echo "'$YELLOW'"$(__git_ps1 " (%s)")
    elif [[ $(__git_ps1) =~ \+\)$ ]]
    # a file has been added, but not commited
    then echo "'$MAGENTA'"$(__git_ps1 " (%s)")
    # the state is clean, changes are commited
    else echo "'$CYAN'"$(__git_ps1 " (%s)")
    fi)'$BLUE" \w"$GREEN": "

alias ll='ls -la'
alias gst='git status -uno'
alias gco='git checkout'
alias gci='git commit'
alias gad='git add'
alias gpl='git pull'
alias gpu='git push'


# - - - - - 

#export MAGICK_HOME="/Users/ppxma7/ImageMagick-6.9.3"
#export PATH="$MAGICK_HOME/bin:$PATH"
#export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

# other stuff
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

alias Data='cd ~/data' #jump to data

alias rdrive='cd /Volumes/TOUCHMAP/ma/'

alias hpc='ssh ppxma7@login001.augusta.nottingham.ac.uk'

alias matlab='/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop'


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
