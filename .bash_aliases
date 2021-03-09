alias x="exit"
alias v="vim"
alias m="man"
alias l="less"
alias t="touch"
alias d="diff"
alias ll="ls -lh"

alias c="composer"
alias ci="composer install"
alias cu="composer update"
alias ct="composer test"
alias cda="composer dump-autoload"

alias pex="sudo phpenmod xdebug"
alias pdx="sudo phpdismod xdebug"

alias vt="vendor/bin/phpunit --stop-on-failure --no-coverage"
alias vtu="vendor/bin/phpunit --stop-on-failure --no-coverage --testsuite=unit"
alias vtf="vendor/bin/phpunit --stop-on-failure --no-coverage --filter"
alias st="bin/phpunit --stop-on-failure --no-coverage"
alias stu="bin/phpunit --stop-on-failure --no-coverage --testsuite=unit"
alias stf="bin/phpunit --stop-on-failure --no-coverage --filter"

alias ducks="du -cks * | sort -rn | head"
alias update="sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y"
alias fo="/opt/firefox/firefox --new-tab"

alias dexec="docker exec -it"
alias dlogs="docker logs --tail 50 -f"
alias dstart="docker start"
alias dstop="docker stop"
alias dstatus="docker ps --format \"{{.Names}}\""

alias gs="git summary"
alias gst="git status"
alias gd="git diff -w"
alias gdc="git diff -w --cached"
alias ga="git add"
alias gcmsg="git commit -m"
alias gcmsga="git commit --amend -m"
alias gl="git pull"
alias gm="git merge"
alias gp="git push"
alias gb="git branch"
alias gfa="git fetch --all"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gsh="git stash"
alias gshp="git stash -p"
alias gsl="git stash list"
alias gsp="git stash pop"
alias gsb="git stash branch"
alias grh="git reset HEAD"
alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glogp="glog -p"

alias cdt="cd /var/www/html/atar"
alias cdf="cd /var/www/html/freddiegar"
alias cdx="cd /var/www/html/flexphp"
alias cde="cd /var/www/html/evertec"

