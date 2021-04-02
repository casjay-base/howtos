# Installing Mattermost on RHEL 7

You can also use these instructions to install Mattermost on CentOS 7, Oracle Linux 7, or  
Scientific Linux 7. With the exception of the operating system that you install, the process is identical.

A complete Mattermost installation consists of 3 major components: a proxy server, a database server, and the Mattermost server. You can install all components on 1 machine, or you can install each component on its own machine. If you have only 2 machines, then install the proxy and the Mattermost server on one machine, and install the database on the other machine.

For the database, you can install either MySQL or PostgreSQL. The proxy is NGINX.

Note

If you have any problems installing Mattermost, see the [troubleshooting guide](https://www.mattermost.org/troubleshoot/). To submit an improvement or correction, click **Edit** at the top of this page.

Install and configure the components in the following order. Note that you need only one database, either MySQL or PostgreSQL.

1. [Installing Mattermost on RHEL 7](#installing-mattermost-on-rhel-7)
   1. [Installing Red Hat Enterprise Linux 7](#installing-red-hat-enterprise-linux-7)
   2. [Installing MySQL Database Server](#installing-mysql-database-server)
   3. [Installing PostgreSQL Database](#installing-postgresql-database)
   4. [Installing Mattermost Server](#installing-mattermost-server)
   5. [**To install Mattermost Server on RHEL 7**](#to-install-mattermost-server-on-rhel-7)
   6. [Configuring Mattermost Server](#configuring-mattermost-server)
   7. [Configuring TLS on Mattermost Server](#configuring-tls-on-mattermost-server)
   8. [Installing NGINX Server](#installing-nginx-server)
   9. [**What to do next**](#what-to-do-next)
   10. [Configuring NGINX as a proxy for Mattermost Server](#configuring-nginx-as-a-proxy-for-mattermost-server)
   11. [**To configure NGINX as a proxy**](#to-configure-nginx-as-a-proxy)
      1. [**NGINX Configuration FAQ**](#nginx-configuration-faq)
   12. [Configuring NGINX with SSL and HTTP/2](#configuring-nginx-with-ssl-and-http2)



## [Installing Red Hat Enterprise Linux 7](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

Install the 64-bit version of RHEL 7 on each machine that hosts one or more of the components.

**To install RHEL 7 Server:**

1. To install RHEL 7, see the [RedHat Installation Instructions](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/).
2. After the system is installed, make sure that it’s up to date with the most recent security patches. Open a terminal window and issue the following commands:

> ```shell
> sudo yum update
> sudo yum upgrade
> ```

Now that the system is up to date, you can start installing the components that make up a Mattermost system.



## [Installing MySQL Database Server](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

Install and set up the database for use by the Mattermost server. You can install either MySQL or PostgreSQL.

**To install MySQL 5.7 on RHEL 7:**

1. Log in to the server that will host the database, and open a terminal window.
2. Download the MySQL Yum repository from dev.mysql.com.

> ```shell
> wget http://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
> ```

1. Install the Yum repository from the file that you downloaded.

> ```shell
> sudo yum localinstall mysql57-community-release-el7-9.noarch.rpm
> ```

1. Install MySQL.

> ```shell
> sudo yum install mysql-community-server
> ```

1. Start the MySQL server.

> ```shell
> sudo systemctl start mysqld.service
> ```
>
> Note
>
> 1. The first time that you start MySQL, the superuser account `'root'@'localhost'` is created and a temporary password is generated for it.
> 2. Also the first time that you start MySQL, the `validate_password` plugin is installed. The plugin forces passwords to contain at least one upper case letter, one lower case letter, one digit, and one special character, and that the total password length is at least 8 characters.

1. Obtain the root password that was generated when you started MySQL for the first time.

> ```shell
> sudo grep 'temporary password' /var/log/mysqld.log
> ```

1. Change the root password. Login with the password that you obtained from the previous step.

> ```shell
> mysql -u root -p
> ```

1. Change the password. At the mysql prompt, type the following command. Be sure to replace `Password42!` with the password that you want to use.

> ```shell
> mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'Password42!';
> ```

1. Set MySQL to start automatically when the machine starts.

> ```shell
> sudo systemctl enable mysqld
> ```

1. Create the Mattermost user ‘mmuser’.

> ```shell
> mysql> create user 'mmuser'@'%' identified by 'mmuser-password';
> ```
>
> Note
>
> 1. Use a password that is more secure than ‘mmuser-password’.
> 2. The ‘%’ means that mmuser can connect from any machine on the network. However, it’s more secure to use the IP address of the machine that hosts Mattermost. For example, if you install Mattermost on the machine with IP address 10.10.10.2, then use the following command:
>
> > ```shell
> > mysql> create user 'mmuser'@'10.10.10.2' identified by 'mmuser-password';
> > ```

1. Create the Mattermost database.

> ```shell
> mysql> create database mattermost;
> ```

1. Grant access privileges to the user ‘mmuser’.

> ```shell
> mysql> grant all privileges on mattermost.* to 'mmuser'@'%';
> ```

With the database installed and the initial setup complete, you can now install the Mattermost server.



## [Installing PostgreSQL Database](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

1. Log in to the server that will host the database, and open a terminal window.
2. Download the PostgreSQL 9.4 Yum repository.

> - For RHEL 7
>
>   `curl -O https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-redhat94-9.4-3.noarch.rpm`
>
> - For CentOS 7
>
>   `curl -O https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-3.noarch.rpm`
>
> - For Scientific Linux
>
>   `curl -O https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-sl94-9.4-3.noarch.rpm`
>
> - For Oracle
>
>   `curl -O https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-oraclelinux-9.4-3.noarch.rpm`

1. Install the Yum repository from the file that you downloaded.

> ```shell
> sudo yum localinstall pgdg-*-9.4-3.noarch.rpm
> ```

1. Install PostgreSQL.

> ```shell
> sudo yum install postgresql94-server postgresql94-contrib
> ```

1. Initialize the database.

> ```shell
> sudo /usr/pgsql-9.4/bin/postgresql94-setup initdb
> ```

1. Set PostgreSQL to start on boot.

> ```shell
> sudo systemctl enable postgresql-9.4
> ```

1. Start the PostgreSQL server.

> ```shell
> sudo systemctl start postgresql-9.4
> ```

1. Switch to the *postgres* Linux user account that was created during the installation.

> ```shell
> sudo -iu postgres
> ```

1. Start the PostgreSQL interactive terminal.

> ```shell
> psql
> ```

1. Create the Mattermost database.

> ```shell
> postgres=# CREATE DATABASE mattermost;
> ```

1. Create the Mattermost user ‘mmuser’.

> ```shell
> postgres=# CREATE USER mmuser WITH PASSWORD 'mmuser_password';
> ```
>
> Note
>
> Use a password that is more secure than ‘mmuser-password’.

1. Grant the user access to the Mattermost database.

> ```shell
> postgres=# GRANT ALL PRIVILEGES ON DATABASE mattermost to mmuser;
> ```

1. Exit the PostgreSQL interactive terminal.

> ```shell
> postgre=# \q
> ```

1. Log out of the *postgres* account.

> ```shell
> exit
> ```

1. Allow PostgreSQL to listen on all assigned IP Addresses.

> 1. Open `/var/lib/pgsql/9.4/data/postgresql.conf` as root in a text editor.
> 2. Find the following line:
>
> > ```shell
> > #listen_addresses = 'localhost'
> > ```
>
> 1. Uncomment the line and change `localhost` to `*`:
>
> > ```shell
> > listen_addresses = '*'
> > ```
>
> 1. Restart PostgreSQL for the change to take effect:
>
> > ```shell
> > sudo systemctl restart postgresql-9.4
> > ```

1. Modify the file `pg_hba.conf` to allow the Mattermost server to communicate with the database.

> **If the Mattermost server and the database are on the same machine**:
>
> > 1. Open `/var/lib/pgsql/9.4/data/pg_hba.conf` as root in a text editor.
> > 2. Find the following line:
> >
> > > ```shell
> > > local   all             all                        peer
> > > ```
> >
> > 1. Change `peer` to `trust`:
> >
> > > ```shell
> > > local   all             all                        trust
> > > ```
>
> **If the Mattermost server and the database are on different machines**:
>
> > 1. Open `/var/lib/pgsql/9.4/data/pg_hba.conf` as root in a text editor.
> > 2. Add the following line to the end of the file, where *{mattermost-server-IP}* is the IP address of the machine that contains the Mattermost server.
> >
> > > ```shell
> > > host all all {mattermost-server-IP}/32 md5
> > > 
> > > ```

1. Reload PostgreSQL:

> ```shell
> sudo systemctl reload postgresql-9.4
> 
> ```

1. Verify that you can connect with the user *mmuser*.

> 1. If the Mattermost server and the database are on the same machine, use the following command:
>
> > ```shell
> > psql --dbname=mattermost --username=mmuser --password
> > 
> > ```
>
> 1. If the Mattermost server is on a different machine, log into that machine and use the following command:
>
> > ```shell
> > psql --host={postgres-server-IP} --dbname=mattermost --username=mmuser --password
> > 
> > ```
> >
> > Note
> >
> > You might have to install the PostgreSQL client software to use the command.
>
> The PostgreSQL interactive terminal starts. To exit the PostgreSQL interactive terminal, type `\q` and press **Enter**.

With the database installed and the initial setup complete, you can now install the Mattermost server.



## [Installing Mattermost Server](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

Install Mattermost Server on a 64-bit machine.

Assume that the IP address of this server is 10.10.10.2

## **To install Mattermost Server on RHEL 7**

1. Log in to the server that will host Mattermost Server and open a terminal window.
2. Download [the latest version of the Mattermost Server](https://about.mattermost.com/download/). In the following command, replace `X.X.X` with the version that you want to download:

> ```shell
> wget https://releases.mattermost.com/X.X.X/mattermost-X.X.X-linux-amd64.tar.gz
> 
> ```

1. Extract the Mattermost Server files.

> ```shell
> tar -xvzf *.gz
> 
> ```

1. Move the extracted file to the `/opt` directory.

> ```shell
> sudo mv mattermost /opt
> 
> ```

1. Create the storage directory for files.

> ```shell
> sudo mkdir /opt/mattermost/data
> 
> ```
>
> Note
>
> The storage directory will contain all the files and images that your users post to Mattermost, so you need to make sure that the drive is large enough to hold the anticipated number of uploaded files and images.

1. Set up a system user and group called `mattermost` that will run this service, and set the ownership and permissions.

> 1. `sudo useradd --system --user-group mattermost`
> 2. `sudo chown -R mattermost:mattermost /opt/mattermost`
> 3. `sudo chmod -R g+w /opt/mattermost`

1. Set up the database driver in the file `/opt/mattermost/config/config.json`. Open the file as root in a text editor and make the following changes:

> - If you are using PostgreSQL:
>
> > 1. Set `"DriverName"` to `"postgres"`
> > 2. Set `"DataSource"` to the following value, replacing `<mmuser-password>` and `<host-name-or-IP>` with the appropriate values:
> >
> > > `"postgres://mmuser:<mmuser-password>@<host-name-or-IP>:5432/mattermost?sslmode=disable&connect_timeout=10"`.
>
> - If you are using MySQL:
>
> > 1. Set `"DriverName"` to `"mysql"`
> > 2. Set `"DataSource"` to the following value, replacing `<mmuser-password>` and `<host-name-or-IP>` with the appropriate values. Also make sure that the database name is `mattermost` instead of `mattermost_test`:
> >
> > > ```shell
> > > "mmuser:<mmuser-password>@tcp(<host-name-or-IP>:3306)/mattermost?charset=utf8mb4,utf8&readTimeout=30s&writeTimeout=30s"
> > > 
> > > ```

1. Test the Mattermost server to make sure everything works.

   > 1. Change to the `mattermost` directory:
   >
   > > `cd /opt/mattermost`
   >
   > 1. Start the Mattermost server as the user mattermost:
   >
   > > `sudo -u mattermost ./bin/mattermost`

> When the server starts, it shows some log information and the text `Server is listening on :8065`. You can stop the server by pressing CTRL+C in the terminal window.

1. Set up Mattermost to use the systemd init daemon which handles supervision of the Mattermost process.

> 1. Create the Mattermost configuration file:
>
> > ```shell
> > sudo touch /etc/systemd/system/mattermost.service
> > 
> > ```
>
> 1. Open the configuration file in your favorite text editor, and copy the following lines into the file:
>
> > ```shell
> > [Unit]
> > Description=Mattermost
> > After=syslog.target network.target postgresql-9.4.service
> > 
> > [Service]
> > Type=notify
> > WorkingDirectory=/opt/mattermost
> > User=mattermost
> > ExecStart=/opt/mattermost/bin/mattermost
> > PIDFile=/var/spool/mattermost/pid/master.pid
> > TimeoutStartSec=3600
> > LimitNOFILE=49152
> > 
> > [Install]
> > WantedBy=multi-user.target
> > 
> > ```
> >
> > Note
> >
> > If you are using MySQL, replace `postgresql-9.4.service` by `mysqld.service` in the `[unit]` section.
>
> 1. Make the service executable.
>
> > ```shell
> > sudo chmod 664 /etc/systemd/system/mattermost.service
> > 
> > ```
>
> 1. Reload the systemd services.
>
> > ```shell
> > sudo systemctl daemon-reload
> > 
> > ```
>
> 1. Set Mattermost to start on boot.
>
> > ```shell
> > sudo systemctl enable mattermost
> > 
> > ```

1. Start the Mattermost server.

> ```shell
> sudo systemctl start mattermost
> 
> ```

1. Verify that Mattermost is running.

> ```shell
> curl http://localhost:8065
> 
> ```
>
> You should see the HTML that’s returned by the Mattermost server.

Now that Mattermost is installed and running, it’s time to create the admin user and configure Mattermost for use.

## [Configuring Mattermost Server](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

Create the System Admin user and set up Mattermost for general use.

1. Open a browser and navigate to your Mattermost instance. For example, if the IP address of the Mattermost server is `10.10.10.2` then go to [http://10.10.10.2:8065](http://10.10.10.2:8065/).
2. Create the first team and user. The first user in the system has the `system_admin` role, which gives you access to the System Console.
3. Open the System Console. To open the System Console, click your username at the top of the navigation panel, and in the menu that opens, click **System Console**.
4. Set the Site URL:

> 1. In the GENERAL section of the System Console, click **Configuration**.
> 2. In the **Site URL** field, set the URL that users point their browsers at. For example, *<https://mattermost.example.com>*. If you are using HTTPS, make sure that you set up TLS, either on Mattermost Server or on a proxy.

1. Set up email notifications.

> 1. In the NOTIFICATIONS section of the System Console, click **Email** and make the following changes:
>
> > - Set **Enable Email Notifications** to *true*
> > - Set **Notification Display Name** to *No-Reply*
> > - Set **Notification From Address** to *{your-domain-name}* For example, *example.com*
> > - Set **SMTP Server Username** to *{SMTP-username}* For example, *admin@example.com*
> > - Set **SMTP Server Password** to *{SMTP-password}*
> > - Set **SMTP Server** to *{SMTP-server}* For example, *mail.example.com*
> > - Set **SMTP Server Port** to *465*
> > - Set **Connection Security** to *TLS* or *STARTTLS*, depending on what the SMTP server accepts.
>
> 1. Click **Test Connection**.
> 2. After your connection is working, click **Save**.

1. Set up the file and image storage location.

> Note
>
> 1. Files and images that users attach to their messages are not stored in the database. Instead, they are stored in a location that you specify. You can store the files on the local file system or in Amazon S3.
> 2. Make sure that the location has enough free space. The amount of storage that’s required depends on the number of users and on the number and size of files that users attach to messages.
> 3. In the FILES section of the System Console, click **Storage**.
> 4. If you store the files locally, set **File Storage System** to *Local File System*, and then either accept the default for the **Local Storage Directory** or enter a location. The location must be a directory that exists and has write permissions for the Mattermost server. It can be an absolute path or a relative path. Relative paths are relative to the `mattermost` directory.
> 5. If you store the files on Amazon S3, set **File Storage System** to *Amazon S3* and enter the appropriate values for your Amazon account.
> 6. Click **Save**.

1. Review the other settings in the System Console to make sure everything is as you want it.
2. Restart the Mattermost Service.

> On Ubuntu 14.04 and RHEL 6.6:
>
> ```shell
> sudo restart mattermost
> 
> ```
>
> On Ubuntu 16.04, Debian Jessie, and RHEL 7:
>
> ```shell
> sudo systemctl restart mattermost
> 
> ```

## [Configuring TLS on Mattermost Server](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

You have two options if you want users to connect with HTTPS:

> 1. Set up TLS on Mattermost Server.
> 2. Install a proxy such as NGINX and set up TLS on the proxy.

The easiest option is to set up TLS on the Mattermost Server, but if you expect to have more than 200 users, use a proxy for better performance. A proxy server also provides standard HTTP request logs.

**Configure TLS on the Mattermost Server**:

1. In the **System Console** > **General** > **Configuration**.

> 1. Change the **Listen Address** setting to `:443`.
> 2. Change the **Connection Security** setting to `TLS`.
> 3. Change the **Forward port 80 to 443** setting to `true`.

1. Activate the `CAP_NET_BIND_SERVICE` capability to allow Mattermost to bind to low ports.

> 1. Open a terminal window and change to the Mattermost `bin` directory.
>
> > ```shell
> > cd /opt/mattermost/bin
> > 
> > ```
>
> 1. Run the following command:
>
> > ```shell
> > sudo setcap cap_net_bind_service=+ep ./mattermost
> > 
> > ```

1. Install the security certificate. You can use [Let’s Encrypt](https://letsencrypt.org/) to automatically install and setup the certificate, or you can specify your own certificate.

> **To use a Let’s Encrypt certificate**:
>
> > The certificate is retrieved the first time that a client tries to connect to the Mattermost server. Certificates are retrieved for any hostname a client tries to reach the server at.
> >
> > 1. Change the **Use Let’s Encrypt** setting to `true`.
> > 2. Restart the Mattermost server for these changes to take effect.

Note

> If Let’s Encrypt is enabled, forward port 80 through a firewall, with [Forward80To443](https://docs.mattermost.com/administration/config-settings.html#forward-port-80-to-443) `config.json` setting set to `true` to complete the Let’s Encrypt certification.

**To use your own certificate**:

> 1. Change the **Use Let’s Encrypt** setting to `false`.
> 2. Change the **TLS Certificate File** setting to the location of the certificate file.
> 3. Change the **TLS Key File** setting to the location of the private key file.
> 4. Restart the Mattermost server for these changes to take effect.



## [Installing NGINX Server](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

In a production setting, use a proxy server for greater security and performance of Mattermost.

The main benefits of using a proxy are as follows:

> - SSL termination
> - HTTP to HTTPS redirect
> - Port mapping `:80` to `:8065`
> - Standard request logs

**To install NGINX on RHEL 6.6 or 7:**

1. Log in to the server that will host the proxy, and open a terminal window.
2. Create the file /etc/yum.repos.d/nginx.repo.

> ```shell
> sudo touch /etc/yum.repos.d/nginx.repo
> 
> ```

1. Open the file as root in a text editor and add the following contents, where *{version}* is **6** for RHEL 6.6, and **7** for RHEL 7:

> ```shell
> [nginx]
> name=nginx repo
> baseurl=http://nginx.org/packages/rhel/{version}/$basearch/
> gpgcheck=0
> enabled=1
> 
> ```

1. Install NGINX.

> ```shell
> sudo yum install nginx.x86_64
> 
> ```

1. - After the installation is complete, start NGINX.

     On RHEL 6.6:`sudo service nginx start`On RHEL 7:`sudo systemctl start nginx`

2. **Optional** Set NGINX to start at system boot.

   > On RHEL 6.6:
   >
   > `sudo chkconfig nginx on`
   >
   > On RHEL 7:
   >
   > `sudo systemctl enable nginx`

3. Verify that NGINX is running.

> ```shell
> curl http://localhost
> 
> ```
>
> If NGINX is running, you see the following output:
>
> ```shell
> <!DOCTYPE html>
> <html>
> <head>
> <title>Welcome to nginx!</title>
> .
> .
> .
> <p><em>Thank you for using nginx.</em></p>
> </body>
> </html>
> 
> ```

## **What to do next**

1. Map a fully qualified domain name (FQDN) such as `mattermost.example.com` to point to the NGINX server.
2. Configure NGINX to proxy connections from the Internet to the Mattermost Server.



## [Configuring NGINX as a proxy for Mattermost Server](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

NGINX is configured using a file in the `/etc/nginx/sites-available` directory. You need to create the file and then enable it. When creating the file, you need the IP address of your Mattermost server and the fully qualified domain name (FQDN) of your Mattermost website.

## **To configure NGINX as a proxy**

1. Log in to the server that hosts NGINX and open a terminal window.
2. Create a configuration file for Mattermost.

> ```shell
> sudo touch /etc/nginx/sites-available/mattermost
> 
> ```

1. Open the file `/etc/nginx/sites-available/mattermost` as root in a text editor and replace its contents, if any, with the following lines. Make sure that you use your own values for the Mattermost server IP address and FQDN for *server_name*.

> ```shell
> upstream backend {
>    server 10.10.10.2:8065;
>    keepalive 32;
> }
> 
> proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=mattermost_cache:10m max_size=3g inactive=120m use_temp_path=off;
> 
> server {
>    listen 80;
>    server_name    mattermost.example.com;
> 
>    location ~ /api/v[0-9]+/(users/)?websocket$ {
>        proxy_set_header Upgrade $http_upgrade;
>        proxy_set_header Connection "upgrade";
>        client_max_body_size 50M;
>        proxy_set_header Host $http_host;
>        proxy_set_header X-Real-IP $remote_addr;
>        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
>        proxy_set_header X-Forwarded-Proto $scheme;
>        proxy_set_header X-Frame-Options SAMEORIGIN;
>        proxy_buffers 256 16k;
>        proxy_buffer_size 16k;
>        client_body_timeout 60;
>        send_timeout 300;
>        lingering_timeout 5;
>        proxy_connect_timeout 90;
>        proxy_send_timeout 300;
>        proxy_read_timeout 90s;
>        proxy_pass http://backend;
>    }
> 
>    location / {
>        client_max_body_size 50M;
>        proxy_set_header Connection "";
>        proxy_set_header Host $http_host;
>        proxy_set_header X-Real-IP $remote_addr;
>        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
>        proxy_set_header X-Forwarded-Proto $scheme;
>        proxy_set_header X-Frame-Options SAMEORIGIN;
>        proxy_buffers 256 16k;
>        proxy_buffer_size 16k;
>        proxy_read_timeout 600s;
>        proxy_cache mattermost_cache;
>        proxy_cache_revalidate on;
>        proxy_cache_min_uses 2;
>        proxy_cache_use_stale timeout;
>        proxy_cache_lock on;
>        proxy_http_version 1.1;
>        proxy_pass http://backend;
>    }
> }
> 
> ```

1. Remove the existing default sites-enabled file.

> ```shell
> sudo rm /etc/nginx/sites-enabled/default
> 
> ```

1. Enable the mattermost configuration.

> ```shell
> sudo ln -s /etc/nginx/sites-available/mattermost /etc/nginx/sites-enabled/mattermost
> 
> ```

1. Restart NGINX.

> On Ubuntu 14.04 and RHEL 6.6: `sudo service nginx restart`
>
> On Ubuntu 16.04, Debian Jessie, and RHEL 7: `sudo systemctl restart nginx`

1. Verify that you can see Mattermost through the proxy.

> ```shell
> curl http://localhost
> 
> ```
>
> If everything is working, you will see the HTML for the Mattermost signup page.

1. Restrict access to port 8065.

> By default, the Mattermost server accepts connections on port 8065 from every machine on the network. Use your firewall to deny connections on port 8065 to all machines except the machine that hosts NGINX and the machine that you use to administer Mattermost server. If you’re installing on Amazon Web Services, you can use security groups to restrict access.

Now that NGINX is installed and running, you can configure it to use SSL, which allows you to use HTTPS connections and the HTTP/2 protocol.

### [**NGINX Configuration FAQ**](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

**Why are Websocket connections returning a 403 error?**

This is likely due to a failing cross-origin check. A check is applied for WebSocket code to see if the `Origin` header is the same as the host header. If it’s not, a 403 error is returned. Open the file `/etc/nginx/sites-available/mattermost` as root in a text editor and make sure that the host header being set in the proxy is dynamic:

```shell
location ~ /api/v[0-9]+/(users/)?websocket$ {
  proxy_pass            http://backend;
  (...)
  proxy_set_header      Host $host;
  proxy_set_header      X-Forwarded-For $remote_addr;
}

```

Then in `config.json` set the `AllowCorsFrom` setting to match the domain being used by clients. You may need to add variations of the host name that clients may send. Your NGINX log will be helpful in diagnosing the problem.

```json
"EnableUserAccessTokens": false,
"AllowCorsFrom": "domain.com domain.com:443 im.domain.com",
"SessionLengthWebInDays": 30,

```

For other troubleshooting tips for WebSocket errors, see [potential solutions here](https://docs.mattermost.com/install/troubleshooting.html#please-check-connection-mattermost-unreachable-if-issue-persists-ask-administrator-to-check-websocket-port).

**How do I setup an NGINX proxy with the Mattermost Docker installation?**

1. Find the name of the Mattermost network and connect it to the NGINX proxy:

> ```shell
> docker network ls
> # Grep the name of your Mattermost network like "mymattermost_default".
> docker network connect mymattermost_default nginx-proxy
> 
> ```

1. Restart the Mattermost Docker containers

> ```shell
> docker-compose stop app
> docker-compose start app
> 
> ```

Tip

There is no need to run the ‘web’ container, since NGINX proxy accepts incoming requests.

1. Update your docker-compose.yml file to include a new environment variable `VIRTUAL_HOST` and an `expose` directive.

> ```shell
> environment:
>   # set same as db credentials and dbname
>   - MM_USERNAME=mmuser
>   - MM_PASSWORD=mmuser_password
>   - MM_DBNAME=mattermost
>   - VIRTUAL_HOST=mymattermost.tld
> expose:
>   - "80"
> 
> ```

If you are using SSL, you may also need to expose port 443.

**Why does NGINX fail when installing Gitlab CE with Mattermost on Azure?**

You may need to update the Callback URLs for the Application entry of Mattermost inside your Gitlab instance.

1. Log into your GitLab instance as the admin
2. Go to **Admin > Applications**
3. Click **Edit** on GitLab-Mattermost
4. Update the Callback URLs to your new domain/URL
5. Save the changes
6. Update the external URL for Gitlab and Mattermost in the `/etc/gitlab/gitlab.rb` configuration file.



## [Configuring NGINX with SSL and HTTP/2](#install-and-configure-the-components-in-the-following-order-note-that-you-need-only-one-database-either-mysql-or-postgresql)

Using SSL gives greater security by ensuring that communications between Mattermost clients and the Mattermost server are encrypted. It also allows you to configure NGINX to use the HTTP/2 protocol.

Although you can configure HTTP/2 without SSL, both Firefox and Chrome browsers support HTTP/2 on secure connections only.

You can use any certificate that you want, but these instructions show you how to download and install certificates from [Let’s Encrypt](https://letsencrypt.org/), a free certificate authority.

Note

If Let’s Encrypt is enabled, forward port 80 through a firewall, with [Forward80To443](https://docs.mattermost.com/administration/config-settings.html#forward-port-80-to-443) `config.json` setting set to `true` to complete the Let’s Encrypt certification.

**To configure SSL and HTTP/2:**

1. Log in to the server that hosts NGINX and open a terminal window.
2. Install git.

> If you are using Ubuntu or Debian:
>
> ```shell
> sudo apt-get install git
> 
> ```
>
> If you are using RHEL:
>
> ```shell
> sudo yum install git
> 
> ```

1. Clone the Let’s Encrypt repository on GitHub.

> ```shell
> git clone https://github.com/letsencrypt/letsencrypt
> 
> ```

1. Change to the `letsencrypt` directory.

> ```shell
> cd letsencrypt
> 
> ```

1. Stop NGINX.

> On Ubuntu 14.04 and RHEL 6.6:
>
> ```shell
> sudo service nginx stop
> 
> ```
>
> On Ubuntu 16.04 and RHEL 7:
>
> ```shell
> sudo systemctl stop nginx
> 
> ```

1. Run `netstat` to make sure that nothing is listening on port 80.

> ```shell
> netstat -na | grep ':80.*LISTEN'
> 
> ```

1. Run the Let’s Encrypt installer.

> ```shell
> ./letsencrypt-auto certonly --standalone
> 
> ```
>
> When prompted, enter your domain name. After the installation is complete, you can find the certificate in the `/etc/letsencrypt/live`directory.

1. Open the file `/etc/nginx/sites-available/mattermost` as root in a text editor and update the *server* section to incorporate the highlighted lines in the following sample. Make sure to replace *{domain-name}* with your own domain name, in 3 places.

> ```shell
> proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=mattermost_cache:10m max_size=3g inactive=120m use_temp_path=off;
> 
> server {
>    listen 80 default_server;
>    server_name   {domain-name} ;
>    return 301 https://$server_name$request_uri;
> }
> 
> server {
>   listen 443 ssl http2;
>   server_name    {domain-name} ;
> 
>   ssl on;
>   ssl_certificate /etc/letsencrypt/live/{domain-name}/fullchain.pem;
>   ssl_certificate_key /etc/letsencrypt/live/{domain-name}/privkey.pem;
>   ssl_session_timeout 5m;
>   ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
>   ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
>   ssl_prefer_server_ciphers on;
>   ssl_session_cache shared:SSL:10m;
> 
>   location ~ /api/v[0-9]+/(users/)?websocket$ {
>     proxy_set_header Upgrade $http_upgrade;
>     .
>     .
>     .
> 
> location / {
>     proxy_http_version 1.1;
>     .
>     .
>     .
> 
> ```

1. Restart NGINX.

> On Ubuntu 14.04 and RHEL 6.6:
>
> ```shell
> sudo service nginx start
> ```
>
> On Ubuntu 16.04 and RHEL 7:
>
> ```shell
> sudo systemctl start nginx
> ```

1. Check that your SSL certificate is set up correctly.

> - Test the SSL certificate by visiting a site such as <https://www.ssllabs.com/ssltest/index.html>
> - If there’s an error about the missing chain or certificate path, there is likely an intermediate certificate missing that needs to be included.

1. Configure `cron` so that the certificate will automatically renew every month.

> ```shell
> crontab -e
> 
> ```
>
> In the following line, use your own domain name in place of *{domain-name}*
>
> ```shell
> @monthly /home/ubuntu/letsencrypt/letsencrypt-auto certonly --reinstall --nginx -d {domain-name} && sudo service nginx reload
> 
> ```
