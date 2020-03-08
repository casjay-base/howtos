## Jenkins Install guide
```
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo  
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key  
yum install -y java-1.8.0-openjdk  
yum install -y jenkins  
systemctl enable jenkins  
systemctl start jenkins  
```
