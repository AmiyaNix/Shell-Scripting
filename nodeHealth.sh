#!/bin/bash


###########################
#Author: Amiya
#Date: 28/02/2025
#
#This Script outputs the node health
#
#Version: v1
###########################

set -x #debug mode
set -e #exit the script when there is an error triggered
set -o pipefail

df -h

free -g

nproc

ps -ef | grep lib | awk -F" " '{print $1}'
