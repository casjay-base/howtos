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
add this to the config
```text
net:
  port: 27017
  bindIp: 127.0.0.1
```
Restart MongoDB service
```shell
sudo systemctl restart mongod
```
