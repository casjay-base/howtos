# Gitea Install

```bash
echo "
###### Debian Main Repos
deb http://ftp.us.debian.org/debian/ stable main contrib non-free
deb http://ftp.us.debian.org/debian/ stable-updates main contrib non-free
deb http://security.debian.org/ stable/updates main contrib non-free
" > /etc/apt/sources.list

apt update && apt upgrade -y
apt install -y curl wget apt-transport-https psmisc net-tools postfix dirmngr neovim git-core build-essential nginx-full nfs-common htop open-vm-tools
dpkg-reconfigure postfix
dpkg-reconfigure dash

mkdir -p /mnt/backups /var/www/html/.well-known /etc/letsencrypt
echo "
10.0.254.1:/mnt/Volume_1/backups         /mnt/backups                 nfs defaults,rw 0 0
10.0.254.1:/var/www/html/.well-known     /var/www/html/.well-known    nfs defaults,rw 0 0
10.0.254.1:/etc/letsencrypt              /etc/letsencrypt             nfs defaults,rw 0 0
" >> /etc/fstab
mount -a

useradd --system --shell /bin/bash --comment 'Git Version Control' --create-home --home-dir /home/git git

mkdir -p /var/lib/gitea/{custom,data,indexers,public,log}
chown git:git /var/lib/gitea/{data,indexers,log}
chmod 750 /var/lib/gitea/{data,indexers,log}
mkdir /etc/gitea
chown root:git /etc/gitea
chmod 770 /etc/gitea
chmod 750 /etc/gitea
chmod 644 /etc/gitea/app.ini
```
