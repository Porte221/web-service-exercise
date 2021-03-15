#!/bin/bash
ACTION=${1}
VERSION='1.0.0'

#show version
function show_version(){
echo $VERSION
}

#update all system packages
function update_system(){
sudo yum update -y 
}

#install Nginx software package
function install_NGinx(){

sudo amazon-linux-extras install nginx1.12 -y
}

#Configure Nginx to start on boot up
function Ngix_Boot(){
sudo chkconfig nginx on
}

#Copy website documents from S3 to web documen root directory
function copy_S3ToRoot(){
sudo aws s3 cp s3://xavierport218-assignment-webserver/index.html/usr/share/nginx/html/index.html
}

#Start Nginx service
function Ngix_Autoboot(){
sudo service nginx start
}

function display_help(){
cat << EOF
Usage: ${0} {-r|--remove|-v|--version|-h|--help} <filename>

OPTIONS:
	-r | --remove  Removes files in directory
	-v | --version Displays the version
	-h | --help Display the command help

Examples: 
	Delete file in directory:
	$ ${0} -r

	Show version:
	$ ${0} -v version

	Display help:
	$ ${0} -h
EOF
}
case "$ACTION" in 
	-r|--remove)
	sudo service nginx stop
	rm /usr/share/nginx/html
	yum remove nginx -y
	;;
	-v|--version)
	show_version
	;;
	-h|--help)
	display_help
	;;
	*)
echo "Usage ${0} {-h|-v|-r}"
exit 1

esac

