### VS-Code docker

```shell
sudo mkdir -p /var/lib/docker/storage/vscode/config

docker create \
  --name=code-server \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=America/New_York \
  -e PASSWORD=password \
  -e SUDO_PASSWORD=password \
  -e PROXY_DOMAIN=code-server.casjay.in \
  -p 8443:8443 \
  -v /var/lib/docker/storage/vscode/config:/config \
  --restart always \
  linuxserver/code-server
```
