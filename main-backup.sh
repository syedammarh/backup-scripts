#!/bin/bash
## Adding variables for future changes ##
DATE=$("/usr/bin/date")
LOG="/var/log/log-snapshot.txt"
MOSH="mongosh"
PARAM1="--quiet"
PARAM2="--eval"
COMM1="db.serverStatus().storageEngine"
COMM2="db.fsyncLock()"
COMM3="db.fsyncUnlock()"
ARG1="wiredtiger"
MONGOPARAM="mongodb://admin:password@vm-hostname1,vm-hostname2,vm-hostname3/admin?otherParams"
HOSTS=$(echo "$MONGOPARAM" | awk -F[@/] '{print $4}' | tr ',' '\n')
for vm in $HOSTS;
do
        echo -e "#######"
        echo -e "#######"
        echo -e "#######"
	echo "Performing snapshot backup on $vm"
        echo -e "#######"
        echo -e "#######"
        echo -e "#######"
	echo "Checking storage engine"
	$MOSH $PARAM1 $PARAM2 $COMM1 | grep -i $ARG1 > /dev/null
	if [ $? == 0 ];then
	        echo -e "#######"
        	echo -e "#######"
        	echo -e "#######"
        	echo "Storage Engine is $ARG1"
        	echo "Performing the fsyncLock() Operation"
	        echo -e "#######"
        	echo -e "#######"
        	echo -e "#######"
		$MOSH $PARAM2 $PARAM2 $COMM2
		echo "Performing Snapshot backup"
        	echo "make-vm-snapshot vm-hostname"
        	echo -e "#######"
        	echo -e "#######"
        	echo "Performing the fsyncUnlock() Operation"
		$MOSH $PARAM1 $PARAM2 $COMM3
        	echo -e "#######"
        	echo -e "#######"
		echo "$vm snapshot is done at $DATE" >> $LOG
        	echo -e "#######"
        	echo -e "#######"
	else
        	echo -e "#######"
        	echo -e "#######"
        	echo -e "#######"
        	echo "Performing $vm node backup"
		echo "make-vm-snapshot vm-hostname"
        	echo -e "#######"
        	echo -e "#######"
		echo "$vm snapshot is done at $DATE" >> $LOG
        	echo -e "#######"
        	echo -e "#######"
	fi
done
