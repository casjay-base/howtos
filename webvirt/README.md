# CentOS 7 WebVirt

```bash
yum -y install git python-pip libvirt-python libxml2-python python-websockify supervisor nginx
yum -y install gcc python-devel

pip install --upgrade pip
pip install numpy

git clone git://github.com/retspen/webvirtmgr.git /usr/share/webvirtmgr
cd /usr/share/webvirtmgr
pip install -r requirements.txt

./manage.py syncdb
./manage.py collectstatic

wget https://github.com/casjay-base/howtos/raw/master/webvirt/webvirt.supervisord.ini -O  /etc/supervisord.d/webvirtmgr.ini
wget https://github.com/casjay-base/howtos/raw/master/webvirt/webvirt-nginx.conf -O /etc/nginx/conf.d/webvirt.conf
```
