# xen-orchestra - CentOS

```bash
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo

yum groupinstall 'Development Tools'
yum -y install epel-release gcc gcc-c++ automake libpng-devel git python redis nodejs yarn
systemctl enable --now redis

git clone -b master http://github.com/vatesfr/xen-orchestra
yarn
yarn build
cd packages/xo-server
cp sample.config.yaml .xo-server.yaml
vi .xo-server.yaml # mounts: '/': '../xo-web/dist/'
yarn start 
```

## xen-orchestra - Debian

```bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt-get install -y nodejs yarn build-essential redis-server libpng-dev git python-minimal libvhdi-utils lvm2

git clone -b master http://github.com/vatesfr/xen-orchestra
cd xen-orchestra
yarn
yarn build
cd packages/xo-server
cp sample.config.yaml .xo-server.yaml
vi .xo-server.yaml # mounts: '/': '../xo-web/dist/'
yarn start 
```

## xen-orchestra - Updating

```bash
cd /opt/xen-orchestra/
sudo git pull --ff-only
sudo yarn
sudo yarn build
```
