#!/usr/bin/env bash
sudo su
yum update -y
echo "SELINUX=disabled" > /etc/selinux/config
setenforce 0
yum install epel-release -y
yum install vim wget curl docker nginx screen -y
systemctl enable nginx
systemctl start docker
systemctl enable docker
docker run --detach --publish 8090:8090 cptactionhank/atlassian-confluence:latest
#wget https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-6.2.1-x64.bin
ln -s /vagrant/ssl/ /etc/nginx/ssl
ln -s /vagrant/confluence.conf /etc/nginx/conf.d/confluence.conf
systemctl start nginx
#if ! [ -L /var/www ]; then
#	rm -rf /var/www
#	ln -fs /vagrant /var/www
#fi
#systemctl restart httpd
#systemctl enable httpd
#yum install screen -y
screen -dms tunnel /vagrant/tunnel.sh
