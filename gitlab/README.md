## GitLab Install guide

```shell
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash  
EXTERNAL_URL="https://gitlab.example.com"  yum install -y gitlab-ce  
  
gitlab-ctl reconfigure  
  
vim /etc/gitlab/gitlab.rb  
  
#runners  
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash  
sudo yum install gitlab-runner  
/usr/share/gitlab-runner/post-install  
```

## Gitlab Docker

```shell
docker volume create gitlab-config  
docker volume create gitlab-logs
docker volume create gitlab-ce
mkdir -p ~/docker-compose/gitlab
wget https://raw.githubusercontent.com/casjay-base/howtos/master/gitlab/docker-compose.yml -O ~/docker-compose/gitlab/docker-compose.yml
cd ~/docker-compose/gitlab && docker compose
```
