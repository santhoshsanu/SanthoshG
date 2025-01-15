Manuall Steps for Installing Tomcat.
------------------

* Create the Tomcat User and Directory

```
sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat
```

* Update Packages and Install Java (JDK)

```
sudo apt update && sudo apt install default-jdk -y
```

* Download Tomcat Package

```
cd /tmp
```

```
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.13/bin/apache-tomcat-10.1.13.tar.gz
```

*  Extract Tomcat Package to /opt/tomcat

```
sudo tar xzvf apache-tomcat-10*tar.gz -C /opt/tomcat --strip-components=1
```

* Set Ownership and Permissions

```
sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R u+x /opt/tomcat/bin
```

* Create a Systemd Service File for Tomcat

```
sudo nano /etc/systemd/system/tomcat.service
```

*  Add the Following Content to the Service File:

```
[Unit]
Description=Tomcat
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```

*  Reload the Systemd Daemon

```
sudo systemctl daemon-reload
```

* Start and Enable Tomcat Service

```
sudo systemctl start tomcat
sudo systemctl status tomcat
sudo systemctl enable tomcat
```