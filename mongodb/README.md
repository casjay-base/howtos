## MongoDB install  
  
```shell
sudo curl -LSs https://rpm-devel.sourceforge.io/ZREPO/RHEL/rhel/casjay.repo /etc/yum.repos.d/casjay.repo
sudo yum install -y mongodb-org
sudo systemctl enable --now mongod
```

#### Secure it
```shell
sudo vim /etc/mongodb.conf
```
##### add this to the config
```text
net:
  port: 27017
  bindIp: 127.0.0.1
```
##### Restart MongoDB service
```shell
sudo systemctl restart mongod
```
  
---
#### docker install  
```shell
mkdir -p /var/lib/docker/storage/mongodb && chmod -Rf 777 /var/lib/docker/storage/mongodb

docker run -d \
--name mongodb \
--restart=always \
-p 127.0.0.1:27017:27017 \
-v /var/lib/docker/storage/mongodb:/data/db  \
-e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
-e MONGO_INITDB_ROOT_PASSWORD=secret \
mongo
```
  
#### More on security
<https://scalegrid.io/blog/10-tips-to-improve-your-mongodb-security/>
