#! /bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y 

####### installing and staring hapr#########
sudo apt-get install haproxy -y

sudo systemctl start haproxy

############### setting up the username and password ####################

#sed -i 's/stats auth admin:admin123/stats auth admin:admin4455/g' /etc/haproxy/haproxy.cfg

############## adding frontend and backend servers details ############################

echo "The give private ip ddress is : ${ip_address0}" > /tmp/ipadress.cfg

cat <<EOF >> /etc/haproxy/haproxy.cfg
listen stats
bind *:8181
stats enable
stats uri /
stats realm Haproxy\ Statistics
#stats auth username:password

frontend haproxy
bind :80
mode http
acl nginx1 path_beg -i /app1.html
acl nginx2 path_beg -i /app2
use_backend application1 if nginx1
use_backend application2 if nginx2

backend application1
        server server1 ${ip_address0}:8081 check

backend application2
        server server2 ${ip_address1}:8080 check
EOF


################ validating the configuration file #####################

sudo haproxy -f /etc/haproxy/haproxy.cfg -c

################# Restaring the haproxy service ##########

sudo systemctl restart haproxy


