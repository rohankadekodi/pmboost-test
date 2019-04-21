#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: sudo ./run_fs.sh <fs> <run_id>"
    exit 1
fi

set -x

workload=tar
fs=$1
run_id=$2
current_dir=$(pwd)
tar_dir=`readlink -f ../../tar`
workload_dir=$tar_dir/workload
pmem_dir=/mnt/pmem_emul
boost_dir=`readlink -f ../../boost-tar`
result_dir=`readlink -f ../../results`
fs_results=$result_dir/$fs/$workload

ulimit -c unlimited

echo Sleeping for 5 seconds . . 
sleep 5

run_workload()
{

    echo ----------------------- TAR WORKLOAD ---------------------------

    mkdir -p $fs_results
    rm $fs_results/run$run_id

    rm -rf $pmem_dir/*
    cp $workload_dir/tar_workload.tar.gz $pmem_dir && sync

    cd $pmem_dir

    sleep 5

    date

    time $tar_dir/src/tar -xf $pmem_dir/tar_workload.tar.gz 2>&1 | tee $fs_results/run$run_id

    date

    cd $current_dir

    echo Sleeping for 5 seconds . .
    sleep 5

}


run_workload

cd $current_dir
