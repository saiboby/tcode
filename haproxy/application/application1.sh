#!/bin/bash
sudo apt update -y && sudo apt install -y nginx
sudo systemctl start nginx
echo "<h1>hello! This is our Nginx application1<h1>" > /var/www/html/app1.html
sed -i "s/80/8081/g" /etc/nginx/sites-enabled/default
systemctl restart nginx



 

 

