#!/bin/bash
###############################################################################
# NIIT FUJITSU SECOND GROUP
# File name: systeminfo_R5.sh
# Summary:   Get Redhat5.11 system information
# Author:    Zhu Xiang ,Tan Jili <jszx1995@126.com>
###############################################################################
IP=192.168.60.130
passwd=andy123
R5=root@$IP
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
ssh $R5 fdisk -l 

#The file system where the root directory resides
echo -e "\033[42;37m The Information of RootfileType:\033[0m"
ssh $R5 df -Th| awk '$NF=="/" {print $1}'   

#Test the selinux state of the machine
echo -e "\033[42;37m The Information of Selinux:\033[0m"
ssh $R5 sestatus -v | awk 'NR==1 {print $3}'

#The kernel version
echo -e "\033[42;37m The Information of  Kernel:\033[0m"
ssh $R5 uname -r                        

#Test machine dmesg information of the latest 10 lines (the last 10 lines) data.
echo -e "\033[42;37m dmesg information was obtained from the RHEL6 of the tail 10\033[0m"
ssh $R5 dmesg | tail -10

#The test machine is in English
echo -e "\033[42;37m Set R5 language to English\033[0m"
en=$(locale -a | grep en_US.utf8)
if [ -n "$en" ]
then
ssh $R5 LANG=$en
	echo -e "Set R5 language to $en success"
else
	echo -e "\033[41;37m Set R5 language to English failure ! Please downlosd the language pack!\033[0m"
fi

#Open the test machine's http service
echo -e "\033[42;37m The service start successful!:\033[0m"
ssh $R5 service httpd start

echo -e "\033[42;37m The service start stauts:\033[0m"
ssh $R5 service httpd status
#Sign in with each other without a password
ssh $R5 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

