#!/bin/bash

while getopts t:c: option
do 
    case "${option}"
        in
        t)train_set=${OPTARG};;
        c)train_config=${OPTARG};;
    esac
done

model_dir=exp/mydiarize/model
train_args=

if [ -d $model_dir ]; then
    echo "$model_dir already exit"
    echo " if you want to retry, please remove it."
    exit 1
fi
work=$model_dir/.work
mkdir -p $work
$train_cmd $work/train.log \
    train.py \
        -c $train_config \
        $train_args \
        $train_set $train_set $model_dir\
        || exit 1
