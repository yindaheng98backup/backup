#!/bin/bash
#!/bin/bash

#此脚本用于下载远程仓库
USER=$1
TOKEN=$2
REPO_NAME=$3 #仓库名称
LOCAL=$4     #仓库目录
URL="https://$TOKEN@github.com/$USER/$REPO_NAME.git"
PRE=$(pwd)
rm -rf $LOCAL
for ((SUCCESS = 1; SUCCESS != 0; )); do
    git clone --mirror $URL $LOCAL/.git #下载仓库中的所有branch
    SUCCESS=$?
done # 也就下载仓库这里可能出乱子了，循环一下直到成功
cd $LOCAL
git config --bool core.bare false
cd $PRE
