### Bluetooth on headless raspi  
  
Install:  

```shell
sudo apt install bluetooth pi-bluetooth bluez blueman bluealsa 
```
  
Configure Buetooth

```shell
bluetoothctl
agent on
scan on
pair [XX:XX:XX:XX:XX:XX]
connect [XX:XX:XX:XX:XX:XX]
trust [XX:XX:XX:XX:XX:XX]

```

Sources:  
<https://pimylifeup.com/raspberry-pi-bluetooth/>  
<https://www.lesbonscomptes.com/pages/raspmpd.html>  
<https://forum-raspberrypi.de/forum/thread/38902-bluetooth-audio-for-headless-raspbian-jessie/>  
<https://medium.com/@mathieu.requillart/my-ultimate-guide-to-the-raspberry-pi-audio-server-i-wanted-introduction-650020d135e1>  
