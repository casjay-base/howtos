## My raspbian setup  
  
Servers:  
```shell
sudo apt update && sudo apt dist-upgrade -yy -q && sudo reboot || echo "Update has failed"
sudo apt install -yy git curl gnupg python3 vim-nox pass lynx net-tools ctags build-essential fim emacs-nox x11-xkb-utils x11-session-utils
sudo GH=casjay bash -c "$(curl -LsS https://github.com/casjay-base/raspbian/raw/master/install.sh)"
bash -c "$(curl -LsS -H "Authorization: token ${GITHUB_ACCESS_TOKEN}"  ${MYPRIVATEDOTFILES_SERVER}/raw/master/install.sh)"
```

Desktops:  
```shell
sudo apt update && sudo apt dist-upgrade -yy -q && sudo reboot || echo "Update has failed"
sudo apt install -yy git curl gnupg python3 python3-pil libjpeg-dev vim-nox neomutt isync msmtp pass lynx notmuch abook urlview newsboat mplayer mpc mpd pianobar net-tools mpv ctags build-essential fim emacs-nox x11-xkb-utils x11-session-utils
sudo GH=casjay bash -c "$(curl -LsS https://github.com/casjay-base/raspbian/raw/master/install.sh)"
bash -c "$(curl -LsS -H "Authorization: token ${GITHUB_ACCESS_TOKEN}"  ${MYPRIVATEDOTFILES_DESKTOP}/raw/master/install.sh)"
```
  
  
Resources:  
  
<https://willemm.nl/track-aircraft-using-ads-b-groundstation-virtual-radar-server-vrs/>  
