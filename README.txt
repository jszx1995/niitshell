1.文件说明
shell目录下文件：
	systeminfo_bk.sh：用于识别系统，进入对应的系统进行获得信息。
	systeminfo_R5.sh：用于获取redhat5.11机器上的相关信息。
	systeminfo_R6.sh：用于获取redhat6.8机器上的相关信息。
	systeminfo_R7.sh：用于获取redhat7.2机器上的相关信息。

log目录下文件：
	用户名_日期_RHEL5.log：存放redhat5.11机器上的相关信息。
	用户名_日期_RHEL6.log：存放redhat6.8机器上的相关信息。
	用户名_日期_RHEL7.log：存放redhat7.2机器上的相关信息。

2.执行方法
1)确认系统环境
把.加入环境变量PATH
systeminfo_bk.sh权限为777
三台测试机同时开启
如果本机没有生成公钥，则先生成公钥

2)运行测试
systeminfo_bk.sh RHEL5
systeminfo_bk.sh RHEL6
systeminfo_bk.sh RHEL7
RHEL5,RHEL6,RHEL7:参数必须输入

3.目录结构
shell
|--README.txt
|--log
   |--name_date_RHEL5.log
   |--name_date_RHEL6.log
   |--name_date_RHEL7.log
|--systeminfo
   |--systeminfo_bk.sh
   |--systeminfo_R5.sh
   |--systeminfo_R6.sh
   |--systeminfo_R7.sh

