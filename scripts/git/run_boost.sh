#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: sudo ./run_fs.sh <fs> <run_id>"
    exit 1
fi

set -x

workload=git
fs=$1
run_id=$2
current_dir=$(pwd)
git_dir=`readlink -f ../../git`
workload_dir=$git_dir/workload
pmem_dir=/mnt/pmem_emul
if [ "$fs" == "boost_new" ]; then
    boost_dir=`readlink -f ../../boost-git`
elif [ "$fs" == "sync_boost_new" ]; then
    boost_dir=`readlink -f ../../boost-git-sync`
else
    boost_dir=`readlink -f ../../boost-git-posix`
fi
result_dir=`readlink -f ../../results`
fs_results=$result_dir/$fs/$workload

ulimit -c unlimited

echo Sleeping for 5 seconds . . 
sleep 5

run_workload()
{

    echo ----------------------- GIT WORKLOAD ---------------------------

    mkdir -p $fs_results
    rm $fs_results/run$run_id

    rm -rf $pmem_dir/*
    cp -r $workload_dir/repo $pmem_dir && sync
    sync && echo 3 > /proc/sys/vm/drop_caches && sync

    cd $pmem_dir
    cd repo
    git init

    sleep 5

    date

    time $boost_dir/run_boost.sh -p $boost_dir -t nvp_nvp.tree git add . 2>&1 | tee $fs_results/run$run_id

    date

    cd $current_dir

    echo Sleeping for 5 seconds . .
    sleep 5

}


run_workload

cd $current_dir
