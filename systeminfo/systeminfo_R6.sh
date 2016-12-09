#!/bin/bash
#####################################################################################################
#NIIT FUJITSU SECOND GROUP
# File name: systeminfo_R6.sh
# Summary:   Get Redhat6.8 system information
# Author:    Zeng Su,Chen Li <949391156@qq.com>
######################################################################################################
IP=192.168.60.129
passwd=andy123
R6=root@$IP

#ssh-keygen
auto_ssh_copy_id(){
         expect -c "set timeout -1;
            spawn ssh-copy-id $2;
            expect {
               *(yes/no)* {send -- yes\r;exp_continue;}
               *assword:* {send -- $1\r;exp_continue;}
               eof        {exit 0;}
            }";
}

auto_ssh_copy_id ${passwd} root@${IP}

#Test machine partition status
echo -e "\033[42;37m This system partition status is:\033[0m"
ssh $R6 fdisk -l

#The file system where the root directory resides
echo -e "\033[42;37m The Information of RootfileType:\033[0m"
ssh $R6 df -Th| awk '$NF=="/" {print $2}'
 
#Test the selinux state of the machine
echo -e "\033[42;37m The Information of Selinux:\033[0m"
ssh $R6 getenforce

# The kernel version
echo -e "\033[42;37m The Information of  Kernel:\033[0m"
ssh $R6 uname -r

#Test machine dmesg information of the latest 10 lines (the last 10 lines) data.
echo -e "\033[42;37m dmesg information was obtained from the RHEL6 of the tail 10\033[0m"
ssh $R6 dmesg | tail -n 10

#The test machine is in English
echo -e "\033[42;37m Set R6 language to English\033[0m"
en=$(locale -a | grep en_US.utf8)
if [ -n "$en" ]
then
ssh $R6 LANG=$en
	    echo -e "Set R6 language to $en success"
else
            echo -e "\033[41;37m Set R6 language to English failure ! Please downlosd the language pack!\033[0m"
fi

#Open the test machine's http service
echo -e "\033[42;37m The service start successful!:\033[0m"
ssh $R6 service httpd start

echo -e "\033[42;37m The service start stauts:\033[0m"
ssh $R6 service httpd status
#Sign in with each other without a password
ssh $R6 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
