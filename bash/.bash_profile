alias ll='ls -l'
alias cdh='cd ~'
alias cdc='cd /c/code/'
alias cdn='cd ~/Nuget/'
alias doy='date +%j'
alias nr='nuget restore'
alias load='source ~/.bash_profile'
alias slc="git show $(git lol -n 1 | awk '{print $2}')"
alias make="/c/Program\ Files\ \(x86\)/GnuWin32/bin/make.exe"

# SSH Environment setup
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
