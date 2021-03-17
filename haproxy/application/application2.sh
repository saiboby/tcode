#!/bin/bash
# sudo apt update -y && sudo apt install -y nginx
# sudo systemctl start nginx
# echo "<h1>hello! This is our Nginx application2<h1>" > /var/www/html/app2.html

# sed -i "s/80/8082/g" /etc/nginx/sites-enabled/default

# systemctl restart nginx

sudo apt-get update -y
sudo apt-get install openjdk-8-jdk -y
sudo apt install net-tools -y
# sudo su -
touch roddam
# cd /home/ubuntu
sudo wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.64/bin/apache-tomcat-8.5.64.tar.gz

sudo tar -xvzf apache-tomcat-8.5.64.tar.gz 
sudo mv apache-tomcat-8.5.64 tomcat 

sed -i '$d' /tomcat/conf/tomcat-users.xml
cat <<EOF >> /tomcat/conf/tomcat-users.xml
<role rolename="tomcat"/>
  <role rolename="manager-script"/>
  <role rolename="manager-gui"/>
  <role rolename="manager-status"/>
  <role rolename="manager-jmx"/>
  <user username="tomcat" password="tomcat" roles="tomcat,manager-script,manager-gui,manager-status,manager-jmx"/>
</tomcat-users>
EOF

cat <<EOF > /tomcat/webapps/manager/META-INF/context.xml
<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<Context antiResourceLocking="false" privileged="true" >
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
<!--  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>
</Context>
EOF


# sudo git clone https://github.com/saiboby/sampleapp
# sudo cp -rf sampleapp/target/myapp-latest.war /tomcat/webapps/
# mkdir /tomcat/webapps/harika
# sudo mv /tomcat/webapps/ROOT/* /tomcat/webapps/harika/
# mkdir /tomcat/webapps/ROOT 
# sudo mv /tomcat/webapps/myapp-latest/* /tomcat/webapps/ROOT/

cd /tomcat/bin/
./startup.sh
# sudo mkdir /tomcat/webapps/app2
# sudo cp -rf /tomcat/webapps/ROOT/ /tomcat/webapps/app2
sudo cp -rf /tomcat/webapps/ROOT/ /tomcat/webapps/app2