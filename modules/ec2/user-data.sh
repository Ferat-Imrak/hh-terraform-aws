#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "$(curl http://169.254.169.254/latest/meta-data/public-ipv4)" > /var/www/html/index.html
