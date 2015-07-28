#!/bin/bash

# シェルスクリプトをまとめて実行するシェルスクリプト #

# 日付の取得 #
year=`date +'%Y'`
month=`date +'%m'`
day=`date +'%d'`
################

H=home
remote_c="hogehoge.sh"

remote_d= echo $remote_c | sed -e "s/\.[^.]*$//g"


# sshリモートログインし、その上でシェルスクリプトを実行するまで #
expect -c "
        spawn ssh $H
        expect \"% \" ; send \"$remote_c > log/$year/$remote_d$year$month$day.log\r\"
        expect \"% \" ; send \"diff -u log/$year/$remote_d$year$month$day.log log/$year/$remote_d$year$month`expr $day - 1`.log > log/$remote_d.diff\r\"
        expect \"% \" ; send \"cat log/$remote_d.diff\r\"
        expect \"% \" ; send \"exit\r\"
"
#################################################################
