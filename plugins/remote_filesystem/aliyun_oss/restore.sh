#!/bin/bash
#检测文件是否被冻结，如果冻结就解冻并等待解冻完成
REMOTE_PATH=$1
CONF_PATH=$(dirname ${BASH_SOURCE[0]})
OSS=$(cat $CONF_PATH/CMD.sh)
if [ -n "$($OSS stat $REMOTE_PATH | grep 'X-Oss-Storage-Class' | grep 'Archive')" ]; then
    #查到文件信息里X-Oss-Storage-Class有Archive，说明是归档文件
    $OSS restore $REMOTE_PATH #要先解冻
    echo "文件 $REMOTE_PATH 已冻结，先解冻"
    while [ -z "$($OSS stat $REMOTE_PATH | grep 'X-Oss-Restore' | grep 'expiry-date')" ]; do
        echo "等待文件 $REMOTE_PATH 解冻"
        sleep 1s
    done
    echo "文件 $REMOTE_PATH 已解冻"
fi
