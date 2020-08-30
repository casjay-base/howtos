## DAAPD 

```shell
wget -q -O - http://www.gyfgafguf.dk/raspbian/forked-daapd.gpg | sudo apt-key add -
echo "deb http://www.gyfgafguf.dk/raspbian/forked-daapd/ $(dpkg --status tzdata|grep Provides|cut -f2 -d'-') contrib" | sudo tee > /etc/apt/sources.list.d/daapd.list
systemctl enable --now forked-daapd.service

```shell
sudo apt-get install build-essential git autotools-dev autoconf automake libtool gettext gawk gperf antlr3 libantlr3c-dev libconfuse-dev libunistring-dev libsqlite3-dev libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev libasound2-dev libmxml-dev libgcrypt20-dev libavahi-client-dev zlib1g-dev libevent-dev libplist-dev libsodium-dev libjson-c-dev libwebsockets-dev libcurl*-dev
```

My config
```text

# A quick guide to configuring forked-daapd:

general {
	uid = "root"
	db_path = "/var/cache/forked-daapd/songs3.db"
#	db_backup_path = "/var/cache/forked-daapd/songs3.bak"
	logfile = "/var/log/forked-daapd.log"
	loglevel = log
	admin_password = "music"
	websocket_port = 3688
	trusted_networks = { "localhost", "192.168", "172.16", "10.", "fd" }
	ipv6 = yes
#	cache_path = "/var/cache/forked-daapd/cache.db"
#	cache_daap_threshold = 1000
#	speaker_autoselect = no
#	high_resolution_clock = yes
}

# Library configuration
library {
	name = "mpd @ %h"
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
#	m3u_overrides = false
#	itunes_overrides = false
#	itunes_smartpl = false
#	no_decode = { "format", "format" }
#	force_decode = { "format", "format" }
#	pipe_autostart = true
#	rating_updates = false
#	allow_modifying_stored_playlists = false
#	default_playlist_directory = ""
}

# Local audio output
audio {
	nickname = "MPDServer"
	type = "alsa"
#	server = ""
	card = "default"
#	mixer = ""
#	mixer_device = ""
#	sync_disable = false
#	offset_ms = 0
#	adjust_period_seconds = 100
}

#alsa "card name" {
#	nickname = "Computer"
#	mixer = ""
#	mixer_device = ""
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
#	max_volume = 11
#	exclude = false
#	permanent = false
#	reconnect = false
	password = "music"
}

# Chromecast settings
# (make sure you get the capitalization of the device name right)
chromecast "MPDServer" {
	exclude = false
}

spotify {
#	settings_dir = "/var/cache/forked-daapd/libspotify"
#	cache_dir = "/tmp"
#	bitrate = 0
#	base_playlist_disable = false
#	artist_override = false
#	album_override = false
}

mpd {
	port = 6600
	http_port = 66100
	clear_queue_on_stop_disable = false
}

sqlite {
#	pragma_cache_size_library = 2000
#	pragma_cache_size_cache = 2000
#	pragma_journal_mode = DELETE
#	pragma_synchronous = 2
#	pragma_mmap_size_library = 0
#	pragma_mmap_size_cache = 0
#	vacuum = yes
}

# Streaming audio settings for remote connections (ie stream.mp3)
streaming {
	sample_rate = 44100
	bit_rate = 192
}

```
