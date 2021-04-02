## Install NodeJS with NVM  
  
```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```
  
#### Install the latest  

```shell
nvm install node
nvm use node
```
  
#### Install the lts version  

```shell
nvm install --lts
nvm use --lts
```
  
#### Install a specific version  

```shell
nvm install v9.3.0
nvm use v9.3.0
```
  
## Install system specific packages  

### Ubuntu/Debian  

```shell
sudo apt-get install -y build-essential
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
```  

#### Redhat/Fedora/CentOS  

```shell
yum groupinstall 'Development Tools'
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
```

#### Arch  

```shell
sudo pacman -S nodejs npm
```
  
##### Setup nginx  

```shell
curl -LSs https://github.com/casjay-base/howtos/raw/master/nodejs/nginx.conf > /etc/nginx/vhosts.d/myapp.conf
vim /etc/nginx/vhosts.d/myapp.conf
systemctl daemon-reload
systemctl restart nginx
```
  
##### SytemD setup  

```shell
curl -LSs https://github.com/casjay-base/howtos/raw/master/nodejs/myapp.service > /etc/systemd/system/myapp.service
vim /etc/systemd/system/myapp.service
systemctl daemon-reload
systemctl enable --now myapp
```
