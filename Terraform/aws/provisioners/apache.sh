#!/bin/bash
apt update -y
apt install nginx -y
echo "Hello World from santhosh" > /var/www/html/index.html