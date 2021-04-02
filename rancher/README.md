### Docker, Rancher, and Kubernetes  
  
Docker

```shell
curl https://releases.rancher.com/install-docker/19.03.sh | sh
```
  
Rancher  

```shell
docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:latest
```
  
Kubernetes

```shell

```
  
Sources:  
<https://www.youtube.com/watch?oILc0ywDVTk>  
<https://rancher.com/docs/rancher/v2.x/en/installation/requirements/installing-docker/>
<https://rancher.com/docs/rancher/v2.x/en/installation/other-installation-methods/single-node-docker/>  
