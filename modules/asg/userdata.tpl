#!/bin/bash
## change port for ssh and install apache2 and awscli
output : { all : '| tee -a /var/log/cloud-init-output.log' }
sudo apt update -y && sudo apt-get upgrade -y
sudo sed -i 's/\#Port 22/Port 6522/g' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
sudo apt-get install apache2 -y
sudo apt-get install awscli -y
sudo systemctl restart apache2
aws s3 cp s3://skillup-malcedo/index.html /var/www/html/index.html
sudo chmod 666 /var/www/html/index.html
sudo ec2metadata --local-hostname  >> /var/www/html/index.html
sudo systemctl restart apache2
