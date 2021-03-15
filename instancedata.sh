#!/bin/bash

#create a file in current directory
touch metadata.txt

# Append instance host id into metdata.txt file
curl -w "\n" http://instance-data/latest/meta-data/hostname >> metadata.txt

# Append iam info pulled from Iam Roles URL
curl -w "\n" http://instance-data/latest/meta-data/iam/info >> metadata.txt

# Append security groups associated with this instance into text file
curl -w "\n" http://instance-data/latest/meta-data/security-groups >> metadata.txt


