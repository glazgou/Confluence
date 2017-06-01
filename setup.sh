#!/usr/bin/bash
#Bringing up aws instance
set=x
. $HOME/VMs/EPAM_LAB/confluence_project/vars.sh
echo "Let's up your aws instance needed to this project"
mkdir $HOME/confluence
mkdir $HOME/confluence/aws_ins
cd $HOME/confluence/aws_ins
vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
touch $HOME/confluence/aws_ins/Vagrantfile
echo "-Building Vagrantfile for AWS Instance-"
	echo -e "Vagrant.configure("2") do |config|" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "config.vm.box = \"dummy\"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "config.vm.provider :aws do |aws,override|" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "aws.access_key_id=\"$AWSKEYID\"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "aws.secret_access_key=\"$AWSKEY\"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "aws.security_groups=[\"$AWSSECGROUP\"]" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "aws.keypair_name="$AWSKEYPAIR"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "aws.region=\"$AWSREGION\"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "aws.instance_type=\"$AWSINTYPE\"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "aws.ami=\"$AWSAMI\"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "aws.elastic_ip = "$AWSELASTIP"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "override.ssh.username = \"$AWSSSHUSER\"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "override.ssh.private_key_path=\"$HOME/.ssh/$AWSPRIVKEYN\"" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "end" >> $HOME/confluence/aws_ins/Vagrantfile
	echo -e "end" >> $HOME/confluence/aws_ins/Vagrantfile
echo "-End of Vagrantfile for AWS Instance-"
vagrant up
#---------------------------------------------------------------------------------------------------------------------
#Bringing up CentOS_7 VM
echo "Let's up your CentOS_7 VM needed to this project"
mkdir $HOME/confluence/centos_vm
mkdir $HOME/confluence/centos_vm/ssl
cp /home/glazgou/VMs/EPAM_LAB/confluence_project/bootstrap.sh $HOME/confluence/centos_vm/bootstrap.sh
cp /home/glazgou/VMs/EPAM_LAB/confluence_project/ssl/confluence.crt $HOME/confluence/centos_vm/ssl/confluence.crt
cp /home/glazgou/VMs/EPAM_LAB/confluence_project/confluence.conf $HOME/confluence/centos_vm/confluence.conf
cp /home/glazgou/VMs/EPAM_LAB/confluence_project/ssl/confluence.key $HOME/confluence/centos_vm/ssl/confluence.key
cp /home/glazgou/VMs/EPAM_LAB/confluence_project/epam-lab.pem $HOME/confluence/centos_vm/epam-lab.pem
cp /home/glazgou/VMs/EPAM_LAB/confluence_project/tunnel.sh $HOME/confluence/centos_vm/tunnel.sh
cd $HOME/confluence/centos_vm
vagrant box add "centos/7" --provider virtualbox
touch $HOME/confluence/centos_vm/Vagrantfile
echo "-Building Vagrantfile for CentOS_7 VM-"
	echo -e "Vagrant.configure("2") do |config|" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "config.vm.synced_folder \".\", \"/vagrant\", type: \"rsync\"" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "config.vm.provision \"shell\", path: \"bootstrap.sh\"" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "config.vm.define \"Centos_7\" do |cent|" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "cent.vm.box = \"centos/7\"" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "cent.vm.network \"forwarded_port\", guest: 443, host: 12345" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "cent.vm.network \"public_network\"," >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "use_dhcp_assigned_default_route: true" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "cent.vm.network \"private_network\", type: \"dhcp\"" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "cent.vm.provider \"virtualbox\" do |vc|" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "vc.memory = $CENTMEM" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "vc.cpus = $CENTCPU" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "end" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "end" >> $HOME/confluence/centos_vm/Vagrantfile
	echo -e "end" >> $HOME/confluence/centos_vm/Vagrantfile
echo "-End of Vagrantfile for CentOS_7 VM-"
vagrant up
#---------------------------------------------------------------------------------------------------------------------
