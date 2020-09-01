### ADS-b  
  
```shell
sudo apt-get update
sudo apt-get install git
cd ~
git clone https://github.com/casjay-forks/adsb-receiver.git /usr/src/adsb-receiver
cd /usr/src/adsb-receiver
sudo chmod +x install.sh
./install.sh

sudo piaware-config feeder-id <feeder_id>

```
