#!/bin/bash
##################################################################################
#NIIT FUJITSU SECOND GROUP
#File name: systeminfo_R7.sh
#Summary: Get Redhat7.2 system information
#Author: Liu Qingyuan <676564184@qq.com>
##################################################################################

#Test machine partition status
echo -e "\033[42;37m This system partition status is:\033[0m"
fdisk -l

#The file system where the root directory resides
echo -e "\033[42;37m The Information of RootfileType:\033[0m
`df -Th| awk '$NF=="/" {print $2}'`" 

#Test the selinux state of the machine
echo -e "\033[42;37m The Information of Selinux:\033[0m
`getenforce`"                    

#The kernel version
echo -e "\033[42;37m The Information of  Kernel:\033[0m
`uname -r`"                       

#Test machine dmesg information of the latest 10 lines (the last 10 lines) data.
echo -e "\033[42;37m dmesg is:\033[0m"
echo "`dmesg |tail -10`" 		   

#The test machine is in English
echo -e "\033[42;37m Set R7 language to English\033[0m"
en=$(locale -a | grep en_US.utf8)
if [ -n "$en" ]
then
LANG=$en
echo -e "Set R7 language to $en success"
else
echo -e "\033[41;37m Set R7 language to $en failure ! Please downlosd the language pack!\033[0m"
fi

#Open the test machine's http service
echo -e "\033[42;37m The service start successful!:\033[0m"
service httpd start

echo -e "\033[42;37m The service start stauts:\033[0m"
service httpd status
