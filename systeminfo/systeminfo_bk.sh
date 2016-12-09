#!/bin/bash
###############################################################################
# NIIT FUJITSU SECOND GROUP
# File name: systeminfo_bk.sh
# Summary:   Identify the system type
# Author:    Zhu Xiang <jszx1995@126.com>
###############################################################################
PARAMETER=$1
YY=`date +%y`
MM=`date +%m` 
DD=`date +%d`
BACKETC=$YY$MM$DD
keygen=~/.ssh/id_rsa.pub

auto_ssh_keygen(){
         expect -c "set timeout -1;
            spawn ssh-keygen;
            expect {
            */.ssh/id_rsa):* {send -- \n\r;exp_continue;}
	    *(y/n)?* {send -- y\r;exp_continue;}
            *(empty for no passphrase)* {send -- \n\r;exp_continue;}
            *again* {send -- \n\r}
            eof        {exit 0;}
	    }";
}

if [ -f $keygen ]
then
	#Recognition system
	case "$PARAMETER" in
		RHEL5 ) bash systeminfo_R5.sh > ../log/${USER}_${BACKETC}_RHEL5.log 2>&1;;
		RHEL6 ) bash systeminfo_R6.sh > ../log/${USER}_${BACKETC}_RHEL6.log 2>&1;;
		RHEL7 ) bash systeminfo_R7.sh > ../log/${USER}_${BACKETC}_RHEL7.log 2>&1;;
		* ) echo -e "\e[1;41mPlease enter：RHEL5 RHEL6 RHEL7 parameter!\e[0m";;
	esac
else
	auto_ssh_keygen
fi

