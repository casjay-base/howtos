## DAAPD 

```shell
wget -q -O - http://www.gyfgafguf.dk/raspbian/forked-daapd.gpg | sudo apt-key add -
echo "deb http://www.gyfgafguf.dk/raspbian/forked-daapd/ $(dpkg --status tzdata|grep Provides|cut -f2 -d'-') contrib" | sudo tee > /etc/apt/sources.list.d/daapd.list
systemctl enable --now forked-daapd.service

```shell
sudo apt-get install build-essential git autotools-dev autoconf automake libtool gettext gawk gperf antlr3 libantlr3c-dev libconfuse-dev libunistring-dev libsqlite3-dev libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev libasound2-dev libmxml-dev libgcrypt20-dev libavahi-client-dev zlib1g-dev libevent-dev libplist-dev libsodium-dev libjson-c-dev libwebsockets-dev libcurl*-dev
```
