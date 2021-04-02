## Docker Install guide

```bash

yum install -y yum-utils device-mapper-persistent-data lvm2
yum install -y docker-ce

mkdir /etc/systemd/system/docker.service.d
wget https://github.com/casjay-base/howtos/raw/master/docker/etc/systemd/system/docker.service.d/docker.conf -O /etc/systemd/system/docker.service.d/docker.conf

systemctl enable docker --now

base=https://github.com/docker/machine/releases/download/v0.16.0 && \
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && \
sudo mv /tmp/docker-machine /usr/local/bin/docker-machine && \
chmod +x /usr/local/bin/docker-machine
base=https://raw.githubusercontent.com/docker/machine/v0.16.0
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
  sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
done

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Optional install portainer
mkdir -p /var/lib/docker/storage/portainer && chmod -Rf 777 /var/lib/docker/storage/portainer
docker run -d -p 127.0.0.1:9010:9000 \
--restart always \
--name portainer \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /var/lib/docker/storage/portainer:/data \
portainer/portainer

# Optional install registry
mkdir -p /var/lib/docker/storage/registry && chmod -Rf 777 /var/lib/docker/storage/registry
docker run -d \
-p 5000:5000 \
--restart=always \
--name registry \
-v /var/lib/docker/storage/registry:/var/lib/registry \
-e SEARCH_BACKEND=sqlalchemy \
-v /etc/ssl/CA/CasjaysDev:/etc/ssl/CA/CasjaysDev \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/etc/ssl/CA/CasjaysDev/certs/localhost.crt \
-e REGISTRY_HTTP_TLS_KEY=/etc/ssl/CA/CasjaysDev/private/localhost.key \
registry

# Optional install registry frontend
mkdir -p /var/lib/docker/storage/registry-web && chmod -Rf 777 /var/lib/docker/storage/registry-web
docker run --name registry-web \
-d --restart=always \
-e ENV_DOCKER_REGISTRY_HOST=registry.casjay.in \
-e ENV_DOCKER_REGISTRY_PORT=5000 \
-e ENV_REGISTRY_PROXY_FQDN=registry.casjay.in \
-e ENV_REGISTRY_PROXY_PORT=443 \
-e ENV_DEFAULT_REPOSITORIES_PER_PAGE=50 \
-e ENV_MODE_BROWSE_ONLY=false \
-e ENV_DEFAULT_TAGS_PER_PAGE=20 \
-e ENV_DOCKER_REGISTRY_USE_SSL=1 \
-e ENV_USE_SSL=1 \
-v /var/lib/docker/storage/registry-web:/var/lib/registry \
-v /etc/ssl/CA/CasjaysDev/certs/localhost.crt:/etc/apache2/server.crt:ro \
-v /etc/ssl/CA/CasjaysDev/private/localhost.key:/etc/apache2/server.key:ro \
-p 7080:80 \
-p 7081:443 \
konradkleine/docker-registry-frontend:v2
```
