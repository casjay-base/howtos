## DAAPD

Install Deps:  

```shell
sudo apt-get install build-essential git autotools-dev autoconf automake libtool gettext gawk gperf antlr3 libantlr3c-dev libconfuse-dev libunistring-dev libsqlite3-dev libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev libasound2-dev libmxml-dev libgcrypt20-dev libavahi-client-dev zlib1g-dev libevent-dev libplist-dev libsodium-dev libjson-c-dev libwebsockets-dev libcurl*-dev pulseaudio-module-bluetooth pulseaudio
```

Install daapd:  

```shell
wget -q -O - http://www.gyfgafguf.dk/raspbian/forked-daapd.gpg | sudo apt-key add -
echo "deb http://www.gyfgafguf.dk/raspbian/forked-daapd/ $(dpkg --status tzdata|grep Provides|cut -f2 -d'-') contrib" | sudo tee > /etc/apt/sources.list.d/daapd.list
systemctl enable --now forked-daapd.service
```

Setup access:  

```shell
adduser root pulse
adduser root bluetooth
adduser root pulse-access
```

Setup pulseaudio:  

```shell
echo "
# systemd service file for Pulseaudio running in system mode
[Unit]
Description=Pulseaudio sound server
Before=sound.target

[Service]
ExecStart=/usr/bin/pulseaudio --system --disallow-exit

[Install]
WantedBy=multi-user.target
" | sudo tee > /etc/systemd/system/pulseaudio.service 
systemctl enable pulseaudio --now
```

My config:  

```text

# A quick guide to configuring forked-daapd:

general {
 uid = "root"
 db_path = "/var/cache/forked-daapd/songs3.db"
 logfile = "/var/log/forked-daapd.log"
 loglevel = log
 admin_password = "music"
 websocket_port = 3688
 trusted_networks = { "localhost", "192.168", "172.16", "10.", "fd" }
 ipv6 = yes
 cache_path = "/var/cache/forked-daapd/cache.db"
 cache_daap_threshold = 1000
 speaker_autoselect = no
 high_resolution_clock = yes
}

# Library configuration
library {
 name = "%h"
 port = 3689
 password = ""
 directories = { "/mnt/music" }
 follow_symlinks = true
 podcasts = { "/Podcasts" }
 audiobooks = { "/Audiobooks" }
 compilations = { "/Compilations" }
 compilation_artist = "Various Artists"
 hide_singles = false
 radio_playlists = false
 name_library    = "Library"
 name_music      = "Music"
 name_movies     = "Movies"
 name_tvshows    = "TV Shows"
 name_podcasts   = "Podcasts"
 name_audiobooks = "Audiobooks"
 name_radio      = "Radio"
 artwork_basenames = { "artwork", "cover", "Folder" }
 artwork_individual = false
 filetypes_ignore = { ".db", ".ini", ".db-journal", ".pdf", ".metadata" }
 filescan_disable = false
# m3u_overrides = false
# itunes_overrides = false
# itunes_smartpl = false
# no_decode = { "format", "format" }
# force_decode = { "format", "format" }
# pipe_autostart = true
# rating_updates = false
# allow_modifying_stored_playlists = false
# default_playlist_directory = ""
}

# Local audio output
audio {
 type = "pulseaudio"
}

#alsa "hw:1" {
# nickname = "Onboard"
# mixer = "Analogue"
# mixer_device = "hw:1"
#}


fifo {
 nickname = "fifo"
 path = "/tmp/daapd.fifo"
}

airplay_shared {
       control_port = 0
       timing_port = 0
}

airplay "MPDServer" {
# max_volume = 11
# exclude = false
# permanent = false
# reconnect = false
 password = "music"
}

# Chromecast settings
# (make sure you get the capitalization of the device name right)
chromecast "MPDServer" {
 exclude = false
}

spotify {
# settings_dir = "/var/cache/forked-daapd/libspotify"
# cache_dir = "/tmp"
# bitrate = 0
# base_playlist_disable = false
# artist_override = false
# album_override = false
}

mpd {
 port = 6600
 http_port = 66100
 clear_queue_on_stop_disable = false
}

sqlite {
# pragma_cache_size_library = 2000
# pragma_cache_size_cache = 2000
# pragma_journal_mode = DELETE
# pragma_synchronous = 2
# pragma_mmap_size_library = 0
# pragma_mmap_size_cache = 0
# vacuum = yes
}

# Streaming audio settings for remote connections (ie stream.mp3)
streaming {
 sample_rate = 44100
 bit_rate = 192
}


```

/etc/pulse/system.pa  

```text
#!/usr/bin/pulseaudio -nF
# This file is part of PulseAudio.


load-module module-device-restore
load-module module-stream-restore
load-module module-card-restore
load-module module-augment-properties
load-module module-switch-on-port-available
load-module module-alsa-sink
load-module module-alsa-source device=hw:1,0

.ifexists module-udev-detect.so
load-module module-udev-detect
.else
load-module module-detect
.endif

.ifexists module-jackdbus-detect.so
.nofail
load-module module-jackdbus-detect channels=2
.fail
.endif

.ifexists module-bluetooth-policy.so
load-module module-bluetooth-policy
.endif

.ifexists module-bluetooth-discover.so
load-module module-bluetooth-discover
.endif

.ifexists module-esound-protocol-unix.so
load-module module-esound-protocol-unix
.endif

load-module module-native-protocol-unix
load-module module-esound-protocol-tcp
load-module module-native-protocol-tcp
load-module module-zeroconf-publish
load-module module-rtp-recv


.ifexists module-gsettings.so
.nofail
load-module module-gsettings
.fail
.endif

load-module module-default-device-restore
load-module module-rescue-streams
load-module module-always-sink
load-module module-intended-roles
load-module module-suspend-on-idle

.ifexists module-console-kit.so
load-module module-console-kit
.endif
.ifexists module-systemd-login.so
load-module module-systemd-login
.endif

load-module module-position-event-sounds
load-module module-role-cork
load-module module-filter-heuristics
load-module module-filter-apply
#set-default-sink output
#set-default-source input
```

/etc/pulse/daemon.conf

```text
# This file is part of PulseAudio.
daemonize = no
allow-module-loading = yes
use-pid-file = yes
system-instance = yes
local-server-type = system
default-script-file = /etc/pulse/system.pa
enable-remixing = yes
remixing-use-all-sink-channels = yes
```
