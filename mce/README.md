# CouchPotato/HeadPhones/SickRage/Plex/Emby install

## CentOS/RedHat/SL 7

```bash
yum groupinstall -y "Development Tools"
yum -y install curl gcc gettext git libmediainfo libzen mediainfo p7zip par2cmdline python-configobj sqlite tar unzip wget unrar

mkdir -p /mnt/media /mnt/torrents
echo "
10.0.254.1:/mnt/Volume_1/media           /mnt/media                   nfs defaults,rw 0 0
10.0.254.1:/mnt/Volume_1/torrents        /mnt/torrents                nfs defaults,rw 0 0
" >> /etc/fstab
mount -a
```

### CouchPotato

```bash
yum install -y transmission-daemon
rm -Rf /usr/src/python2 /usr/src/python3
git clone https://git.casjay.in/interpreters/python2.git /usr/src/python2
cd /usr/src/python2 && ./build.sh && cd

git clone https://git.casjay.in/mirrors/couchpotato.git /var/lib/couchpotato
git clone https://git.casjay.in/systems/couchpotato.git /tmp/couchpotato

mkdir -p /var/lib/couchpotato && cd /var/lib/couchpotato
/usr/local/bin/python2.7 -m virtualenv .
source /var/lib/couchpotato/bin/activate
/var/lib/couchpotato/bin/python -m pip install cheetah cryptography sabyenc --upgrade
/var/lib/couchpotato/bin/python -m pip install -r /tmp/couchpotato/requirements.txt
deactivate

cd ~

cp -Rfv /tmp/couchpotato/{etc,root,var}* /
systemctl disable transmission-daemon --now
systemctl enable couchpotato couchpotato-bt httpd nginx smb nmb --now

rm -Rf /usr/src/python2 /usr/src/python3 /tmp/couchpotato/ 

munin-node-configure --remove-also --shell | sh
systemctl restart munin-node httpd nginx
history -c && history -w && exit

```

### HeadPhones

```bash
yum install -y transmission-daemon
rm -Rf /usr/src/python2 /usr/src/python3
git clone https://git.casjay.in/interpreters/python2.git /usr/src/python2
cd /usr/src/python2 && ./build.sh && cd

git clone https://git.casjay.in/mirrors/headphones.git /var/lib/headphones
git clone https://git.casjay.in/systems/headphones.git /tmp/headphones

mkdir -p /var/lib/headphones && cd /var/lib/headphones
/usr/local/bin/python2.7 -m virtualenv .
source /var/lib/headphones/bin/activate
/var/lib/headphones/bin/python -m pip install cheetah cryptography sabyenc --upgrade
/var/lib/headphones/bin/python -m pip install -r /tmp/headphones/requirements.txt
deactivate

cd ~

cp -Rfv /tmp/headphones/{etc,root,var}* /
systemctl disable transmission-daemon --now
systemctl enable headphones headphones-bt httpd nginx smb nmb --now

rm -Rf /usr/src/python2 /usr/src/python3 /tmp/headphones/ 

munin-node-configure --remove-also --shell | sh
systemctl restart munin-node httpd nginx
history -c && history -w && exit

```

### SickRage

```bash
yum install -y transmission-daemon
rm -Rf /usr/src/python2 /usr/src/python3
git clone https://git.casjay.in/interpreters/python2.git /usr/src/python2
cd /usr/src/python2 && ./build.sh && cd

git clone https://git.casjay.in/mirrors/sickrage.git /var/lib/sickrage
git clone https://git.casjay.in/systems/sickrage.git /tmp/sickrage

mkdir -p /var/lib/sickrage && cd /var/lib/sickrage
/usr/local/bin/python2.7 -m virtualenv .
source /var/lib/sickrage/bin/activate
/var/lib/sickrage/bin/python -m pip install cheetah cryptography sabyenc --upgrade
/var/lib/sickrage/bin/python -m pip install -r /tmp/sickrage/requirements.txt
deactivate

cd ~

cp -Rfv /tmp/sickrage/{etc,root,var}* /
systemctl disable transmission-daemon --now
systemctl enable sickrage sickrage-bt httpd nginx smb nmb --now

rm -Rf /usr/src/python2 /usr/src/python3 /tmp/sickrage/ 

munin-node-configure --remove-also --shell | sh
systemctl restart munin-node httpd nginx
history -c && history -w && exit

```

### Plex

```bash
yum install ffmpeg
yum install -y https://downloads.plex.tv/plex-media-server/1.14.0.5470-9d51fdfaa/plexmediaserver-1.14.0.5470-9d51fdfaa.x86_64.rpm 
go to http://yourserverip:32400/ and configure it

Optional stats for plex [Tautulli]
rm -Rf /usr/src/python2 /usr/src/python3
git clone https://git.casjay.in/interpreters/python2.git /usr/src/python2
cd /usr/src/python2 && ./build.sh && cd
git clone https://git.casjay.in/mirrors/Plex-Tautulli.git /var/lib/tautulli
git clone https://git.casjay.in/mirrors/plex.git /tmp/plex
cp -Rf /tmp/plex/{etc,root,var}* /
```

### Emby

```bash
yum install ffmpeg
yum install -y https://github.com/MediaBrowser/Emby.Releases/releases/download/3.5.3.0/emby-server-rpm_3.5.3.0_x86_64.rpm
go to http://yourserverip:8096/ and configure it

```

### Airsonic

```bash
mkdir -p /var/airsonic
yum install java-1.8.0-openjdk-headless -y
wget https://github.com/airsonic/airsonic/raw/master/contrib/airsonic.service -O /etc/systemd/system/airsonic.service
wget https://github.com/airsonic/airsonic/releases/download/v10.1.2/airsonic.war -O /var/airsonic/airsonic.war
mkdir -p /mnt/media
echo " 10.0.254.1:/mnt/Volume_1/media           /mnt/media                   nfs defaults,rw 0 0" >> /etc/fstab
mount -a

```
