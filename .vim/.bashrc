# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias gitcp='git commit -a -m "fw"; git push'
alias scps='scps() { scp $1 root@www.codedayday.com:/opt/ ; };scps'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
