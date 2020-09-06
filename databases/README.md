# MySQL/MariaDB

```bash
sudo yum install mariadb-server
sudo systemctl enable --now mariadb
sudo mysql_secure_installation

```

# PostgreSQL

```bash
sudo yum install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
sudo yum install postgresql96-server
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
```
https://comtronic.com.au/how-to-upgrade-postgresql-server-to-9-6/  

# Microsoft SQL Server

```bash
sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2017.repo
sudo yum install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup
systemctl status mssql-server
```
