# Home-Assistant on CentOS 7
```bash
# Optionally add user
#adduser --system --shell=/bin/bash --home=/var/lib/homeassistant  homeassistant

wget https://github.com/casjay/howtos/raw/master/home-assistant/rpm-packages.txt -O /tmp/hass-rpms.txt
wget https://github.com/casjay/howtos/raw/master/home-assistant/requirements-el7.txt -O /tmp/hass-pips.txt

yum install -y $(cat /tmp/hass-rpms.txt)

#Optional switch to user and clone repo
#su - homeassistant
#git clone https://git.casjay.in/systems/hass.git /var/lib/homeassistant/.homeassistant

cd /var/lib/homeassistant && /usr/local/bin/python3 -m venv . && source ./bin/activate

/var/lib/homeassistant/bin/python3 -m pip install --upgrade pip
/var/lib/homeassistant/bin/python3 -m pip install wheel
/var/lib/homeassistant/bin/python3 -m pip install python-openzwave
/var/lib/homeassistant/bin/python3 -m pip install homeassistant 
/var/lib/homeassistant/bin/python3 -m pip install -r /tmp/hass-pips.txt
systemctl daemon-reload && systemctl enable hass.service

echo 'SUBSYSTEM=="tty", ATTRS{idVendor}=="0658", ATTRS{idProduct}=="0200", SYMLINK+="zwave"' >> /etc/udev/rules.d/99-usb-serial.rules
echo 'SUBSYSTEM=="tty", ATTRS{idVendor}=="067b", ATTRS{idProduct}=="2303", SYMLINK+="gps"' >> /etc/udev/rules.d/99-usb-serial.rules

deactivate

```
