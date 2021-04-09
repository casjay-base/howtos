### Docker, Rancher, and Kubernetes  
  
Docker

```shell
sudo groupadd docker; sudo usermod -aG docker $USER; newgrp docker 
curl -fsSL https://github.com/docker/docker-install/raw/master/install.sh | sudo sh
sudo systemctl enable --now docker
```
  
Rancher  

```shell
sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:latest
```
  
Kubernetes

```shell
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

MiniKube

```shell
 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
 sudo install minikube-linux-amd64 /usr/local/bin/minikube
 minikube start
```

Clean up

```shell
rm kubectl
rm minikube
```
  
Sources:  
<https://www.youtube.com/watch?oILc0ywDVTk>  
<https://rancher.com/docs/rancher/v2.x/en/installation/requirements/installing-docker/>  
<https://rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/>  
