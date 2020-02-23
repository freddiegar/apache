Install Software in Debian|Ubuntu OS
___

# Performance, not use swap while RAM < 90% used

[Tips 1](https://www.linuxbabe.com/ubuntu/4-tips-speed-up-ubuntu-16-04)
[Tips 2](https://github.com/akalongman/ubuntu-configuration)

```bash
echo '# Overwrite default: 60
vm.swappiness=10' | sudo tee -a /etc/sysctl.d/99-sysctl.conf
```

# Change default time GRUB to 2
```bash
sudo sed -i 's/GRUB_TIMEOUT=[0-9]*/GRUB_TIMEOUT=2/g' /etc/default/grub
sudo update-grub
```

# Updated repos
```bash
sudo apt update
sudo apt upgrade
```

# Unzip, cURL, Vim and extra utils
```bash
sudo apt-get install -y unzip
sudo apt-get install -y curl
sudo apt-get install -y vim
sudo apt-get install -y tree
sudo apt-get install -y nmap
sudo apt-get install -y apache2-utils
sudo apt-get install -y htop
## sudo apt-get remove unzip curl vim tree nmap apache2-utils htop && sudo apt-get autoremove
```

# GIT
```bash
sudo apt-get install -y git-core
git config --global user.name "Freddie Gar"
git config --global user.email freddie.gar@outlook.com
git config --list
## sudo apt-get remove git-core && sudo apt-get autoremove
```

# GIT Flow
```bash
sudo apt-get install git-flow
## sudo apt-get remove git-flow && sudo apt-get autoremove
```

# Zsh
```bash
sudo apt-get install -y zsh
# As User NOT root
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s `which zsh`
gnome-session-quit
## sudo apt-get remove zsh && sudo apt-get autoremove
```

# Aliases
```bash
touch ~/.bash_aliases
echo 'alias x=exit
alias update="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias ducks="du -cks * | sort -rn | head"' > ~/.bash_aliases
echo 'if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi' >> ~/.zshrc
```

# PHP 7.3
```bash
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php # Only Ubuntu
sudo apt-get update
sudo apt-get install -y php7.3-cli
sudo apt-get install -y php7.3-dev
sudo apt-get install -y php7.3-mbstring
sudo apt-get install -y php7.3-xml
sudo apt-get install -y php7.3-mysql
sudo apt-get install -y php7.3-curl
sudo apt-get install -y php7.3-zip
sudo apt-get install -y php7.3-soap
sudo apt-get install -y php7.3-gd
sudo apt-get install -y php7.3-sqlite3
sudo apt-get install -y php7.3-intl
sudo apt-get install -y php7.3-memcached
sudo apt-get install -y php7.3-redis
sudo apt-get install -y php7.3-bcmath
## sudo apt-get remove php7.3* && sudo apt-get autoremove
```

# MySQL Client (Server is using Docker)
```bash
# Ubuntu
sudo apt-get install -y mysql-client
## sudo apt-get remove mysql-client && sudo apt-get autoremove

# Debian
sudo apt-get install -y mariadb-client
## sudo apt-get remove mariadb-client && sudo apt-get autoremove
```

# Composer
```bash
cd ~
curl -L https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm -Rf composer-setup.php
## rm -Rf /usr/local/bin/composer
```

# Security Checker
```bash
cd ~
sudo curl -L http://get.sensiolabs.org/security-checker.phar -o /usr/local/bin/security-checker
sudo chmod +x /usr/local/bin/security-checker
## Command: 
## sudo rm /usr/local/bin/security-checker
```

# Infection AST 
```bash
cd ~
sudo curl -L https://github.com/infection/infection/releases/download/0.15.3/infection.phar -o /usr/local/bin/infection
sudo chmod +x /usr/local/bin/infection
## Command: 
## infection -j$(nproc) [--filter=file.php]
## Update: 
## infection self-update
## sudo rm /usr/local/bin/infection
```

# Docker (Container)

[See 1](https://docs.docker.com/install/linux/docker-ce/ubuntu)
[See 2](https://docs.docker.com/install/linux/linux-postinstall/)

## Ubuntu 18.*, 19.*, Debian 10
```bash
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg software-properties-common
curl -L https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/`lsb_release -is | awk '{print tolower($0)}'` `lsb_release -cs` stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker $(whoami)
gnome-session-quit
```

## Ubuntu 16.*
```bash
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get install -y docker-engine
sudo usermod -aG docker $(whoami)
sudo reboot
## sudo apt-get remove docker-engine docker-ce && sudo apt-get autoremove
```

# Docker Compose
```bash
cd ~
sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
## sudo rm /usr/local/bin/docker-compose
```

# Docker Network
```bash
docker network create --driver=bridge --subnet=172.20.0.0/16 --gateway=172.20.0.1 development
```

# GIT Summary
```bash
cd ~
sudo apt-get install -y gawk
sudo curl -L https://raw.githubusercontent.com/albenik/git-summary/master/git-summary -o /usr/local/bin/git-summary
sudo chmod +x /usr/local/bin/git-summary
## sudo apt-get remove gawk && sudo rm /usr/local/bin/git-summary && sudo apt-get autoremove
```

# SSH Keys
```bash
ssh-keygen                 # Insert passprhase (Algo ...)
ls ~/.ssh
cat ~/.ssh/id_rsa.pub      # Setup SSH Keys in Apps or VPS
```

# Xdebug
```bash
pecl install -f xdebug

echo 'xdebug.idekey=PHPSTORM
xdebug.remote_mode=req
xdebug.remote_host=localhost
xdebug.remote_port=9000
xdebug.remote_enable=1
xdebug.remote_autostart=1
; To enable profiler use XDEBUG_PROFILE=PHPSTORM in (GET|POST|COOKIE)
xdebug.profiler_enable=0
xdebug.profiler_enable_trigger=1
zend_extension=/usr/lib/php/20180731/xdebug.so' | sudo tee /etc/php/7.3/mods-available/xdebug.ini

sudo phpenmod xdebug
```
# Postman
```bash
cd ~
sudo snap install postman
```

# VSCode & Firefox
```bash
cd ~
sudo dpkg -i vscode.deb
tar -xvzf firefox.tar.gz -C dir_dest
tar -xvjf firefox.tar.bz2 -C dir_dest
```

# Node
```bash
cd ~
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' | sudo tee -a ~/.zshrc
# Close Terminal to load changes
nvm ls-remote # Show version available
nvm install v10.15.3
nvm alias default v10.15.3
nvm current
## Enabled to all users in Ubuntu
# n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
## Install pkg: npm install express
## nvm deactivate && nvm uninstall v10.15.3
```

# Clean installation
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get autoremove

## That is ALL :D !

# Optionals

## Ubuntu: Tweak Tool
```bash
gnome-shell --version
sudo apt-get install -y gnome-tweak-tool
## sudo apt-get remove gnome-tweak-tool && sudo apt-get autoremove
```

## Install Xdebug Profiler
```bash
sudo apt-get install -y kcachegrind
## sudo apt-get remove kcachegrind && sudo apt-get autoremove
```

## Screen Recording
```bash
sudo apt-get update
sudo apt-get install -y kazam
## sudo apt-get remove kazam && sudo apt-get autoremove
```

## Google Chrome
```bash
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y google-chrome-stable
## sudo apt-get remove google-chrome-stable && sudo apt-get autoremove
```

## Virtual Box
```bash
cd ~
sudo apt-get update
sudo apt-get install virtualbox
## sudo apt-get remove virtualbox && sudo apt-get autoremove
```

## Vagrant (VM)
```bash
sudo apt-get install -y vagrant
## sudo apt-get remove vagrant && sudo apt-get autoremove
```

## Remove LibreOffice
```bash
sudo apt-get remove -y --purge libreoffice* && sudo apt-get clean && sudo apt-get autoremove
```