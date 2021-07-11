
# Custom aliases
alias vim=nvim
alias kopia=kopia.exe

alias ls='ls -lF --color=auto'
alias left='ls -t -1 -l' #last modified file

# shows mounted drives
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

# adds progress bar to cp
alias cp='rsync -ah --info=progress2'

# Alias rm to trash-cli
# trash-restore, trash-put, trash-empty
alias rm=trash
