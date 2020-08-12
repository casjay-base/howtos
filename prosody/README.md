#### Prosody IM Server

```shell
mkdir -p /var/lib/docker/storage/prosody && chmod -Rf 777 /var/lib/docker/storage/prosody
docker run -d \
   -p 82:80
   -p 5222:5222 \
   -p 5269:5269 \
   -p 5281:5281
   -p 5347:5347 \
   -e LOCAL=admin \
   -e DOMAIN=MYDOMAIN \
   -e PASSWORD=juliet4ever \
   -v /var/lib/docker/storage/prosody/log:/var/log/prosody \
   -v /var/lib/docker/storage/prosody/configuration:/etc/prosody \
   -v /var/lib/docker/storage/prosody/modules:/usr/lib/prosody-modules \
   prosody/prosody
```
