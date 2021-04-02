## Mastodon Install guide

```shell
curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -  
wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo  
rpm -Uvh https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm  
  
wget https://github.com/CasjaysDev/packages/raw/master/rhel/mastodon.txt -O /tmp/mastodon.txt  
yum install -y $(cat /tmp/mastodon.txt)  
  
/usr/pgsql-9.6/bin/postgresql96-setup initdb  
  
systemctl start postgresql-9.6 redis  
systemctl enable postgresql-9.6 redis  
  
vim /var/lib/pgsql/9.6/data/pg_hba.conf  
  
# TYPE  DATABASE        USER            ADDRESS                 METHOD  
  
# "local" is for Unix domain socket connections only  
local   all             all                                     trust  
# IPv4 local connections:  
host    all             all             127.0.0.1/32            md5  
# IPv6 local connections:  
host    all             all             ::1/128                 md5  
  
adduser mastodon  
su - mastodon  
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB  
curl -sSL https://get.rvm.io | bash -s stable  
source /home/mastodon/.rvm/scripts/rvm  
rvm install 2.5.1  
  
gem install bundler  
cd ~  
git clone https://github.com/tootsuite/mastodon.git app  
cd ~/app  
git checkout $(git describe --tags `git rev-list --tags --max-count=1`)  
bundle config build.pg --with-pg-config=/usr/pgsql-9.6/bin/pg_config  
bundle install --deployment --without development test  
exit  
  
passwd postgres  
su - postgres -c psql  
CREATE USER mastodon CREATEDB;  
ALTER USER mastodon WITH ENCRYPTED password 'YOURSECUREPASSWORD' CREATEDB;  
\q  
  
su - mastodon  
cd ~/app  
RAILS_ENV=production bundle exec rake mastodon:setup  
  
su -  
git clone https://github.com/casjay-base/howtos /tmp/howtos
cp -Rfv /tmp/howtos/mastodon/{etc,usr}* /  
  
systemctl daemon-reload  
systemctl enable mastodon-web mastodon-queue mastodon-api  
systemctl start mastodon-web mastodon-queue mastodon-api  
systemctl status mastodon-web mastodon-queue mastodon-api  
```  
