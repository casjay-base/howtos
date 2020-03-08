# CentOS
```bash
sudo yum install -y ffmpeg gstreamer1-libav x264 x265 git curl gnupg2
sudo yum install -y nodejs
ln -s /usr/bin/nodejs /usr/bin/node

git clone https://gitlab.com/Shinobi-Systems/Shinobi.git /usr/local/share/shinobi
cd /usr/local/share/shinobi
chmod +x INSTALL/centos.sh && INSTALL/centos.sh

```

# Debian
```bash
sudo apt update
sudo apt install ffmpeg libav-tools x264 x265 git curl gnupg2
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install nodejs -y
ln -s /usr/bin/nodejs /usr/bin/node

git clone https://gitlab.com/Shinobi-Systems/Shinobi.git /usr/local/share/shinobi
cd /usr/local/share/shinobi
chmod +x INSTALL/ubuntu.sh && INSTALL/ubuntu.sh
```
