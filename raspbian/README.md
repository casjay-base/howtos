## My raspbian setup  
  
```shell
sudo apt update && sudo dist-upgrade -yy -q && reboot || echo "Update has failed"
sudo apt install git curl gnupg python3 python3-pil libjpeg-dev vim-nox neomutt isync msmtp pass lynx notmuch abook urlview newsboat mplayer mpc mpd pianobar net-tools mpv ctags build-essential fim emacs-nox
bash -c "$(curl -LsS https://raw.githubusercontent.com/casjay-dotfiles/minimal/master/install.sh)"
sudo GH=casjay bash -c "$(curl -LsS https://github.com/casjay-base/raspbian/raw/master/install.sh)"
```
  
  
