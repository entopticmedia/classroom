# Classroom API Backend
This is the Jupyter-backed backend for the Classroom project

## How to add a new API Server

### Adding a new Jupyter notebook

Create a new notebook according to the specifications of the Jupyter Kernel Gateway. The documentation which is included in the Entoptic Camera Notebook may prove helpful. I also recommend to create a start script which handles the startup and definition of Kernel Gateway parameters. The ```start.sh``` script in the Entoptic Camera Backend is a good starting point.

### Adding a new Systemd service

We use systemd in order to monitor the uptime of our service and restart it, if necessary. Add a new systemd configuration under ```/etc/systemd/system/```. A simple auto-starting configuration for a Kernelgateway notebook may look like this:

```
[Unit]
Description=Classroom

[Service]
Type=simple
PIDFile=/run/classroom.pid
WorkingDirectory=/home/entopticuser/prototypes/classroom_backend
ExecStart=/usr/bin/bash /home/entopticuser/prototypes/classroom/start.sh
User=<insert user here>
Group=root
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
```

Now reload the Systemd service via ```sudo systemctl daemon-reload```, activate the service via ```sudo systemctl enable <service name>``` and start the service via ```sudo systemctl start <service name>```.

An in-depth tutorial for this process can be found under:

[Jupyter & Systemd Tutorial](https://janakiev.com/blog/jupyter-systemd/)

### Adding a new subdomain

Open the Nameserver settings of your domain provider and add a new subdomain by adding an ANAME RECORD pointing to the IP of your server. If you want to allow people to use www. infront of your domain, you have to add a separate ANAME RECORD for this.

### Configuring SSL

Add a new Apache2 configuration under ```/etc/apache2/sites-available/```. The name should be the URL. A configuration for a simple proxy, which just handles the SSL encryption, may look like that:

```
<VirtualHost *:80>
    ServerAdmin <email here>
    ServerName <URL here>
    ServerAlias <www URL here>

    ProxyPreserveHost On
    ProxyPass / <local URL of the service to proxy>
    ProxyPassReverse / <local URL of the service to proxy>
    
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
RewriteEngine on
RewriteCond %{SERVER_NAME} =<URL here> [OR]
RewriteCond %{SERVER_NAME} =<www URL here>
RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>
```

Activate the config via `sudo a2ensite <name of the config>` and reload the Apache2 server in order to let the config take effect via ```systemctl reload apache2```.

Now the service runs on HTTP. In order to encrypt the connection you may now run ```sudo certbot --apache```. Once you followed all the instructions from the certbot, your service will run on HTTPS.

An in-depth tutorial for this process can be found under:

[Install and Manage Apache2](https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-20-04)

[Install and Manage Let's Encrypt with Apache2](https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04)

## Updating an existing service

### Modifying the source
In the first step you should locally modify your source code and push it to the git repository.

### Reloading the service on the server
Once logged into the server, navigate to the repository and ```git pull``` your changes. Then you can run the updated version of your code by restarting the systemd service via ```systemctl restart <service name>```.

## Changelog

| Last commit                              | Description                                                                 |
|------------------------------------------|-----------------------------------------------------------------------------|
| 3eecd1c0c5e9d5d707a109f26ee34dca27264efc | Reworked replicate Python SDK usage due to Replicate's breaking API changes |
| 9e7791ee69a12c571423b0fd6fc60406839c278d | Initial version of Classroom backend                                        |
| bffecd99a959174ae329eda65c6e00a1aa9b6262 | Initial Commit                                                              |

