## Docker Install guide
```bash

yum install -y yum-utils device-mapper-persistent-data lvm2
yum install -y docker-ce

mkdir /etc/systemd/system/docker.service.d
wget https://git.casjay.in/global/howtos/raw/branch/master/docker/etc/systemd/system/docker.service.d/docker.conf -O /etc/systemd/system/docker.service.d/docker.conf

systemctl enable docker --now

base=https://git.casjay.in/docker/tools/raw/branch/master/usr/local/bin
for i in docker-compose docker-machine
do
  sudo wget "$base/${i}" -O /usr/local/bin/${i} && chmod -f +x /usr/local/bin/$i
done

base=https://git.casjay.in/docker/tools/raw/branch/master/etc/bash_completion.d
for i in docker-machine-prompt docker-machine-wrapper docker-machine docker-compose
do
  sudo wget "$base/${i}" -O /etc/bash_completion.d/$i
done


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