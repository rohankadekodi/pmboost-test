#!/bin/bash

current_dir=$(pwd)
setup_dir=`readlink -f ..`
pmem_dir=/mnt/pmem_emul

run_tar()
{
    fs=$1
    for run in 1 2 3
    do
        sudo rm -rf $pmem_dir/*
        sudo ./run_fs.sh $fs $run
        sleep 5
    done
}

run_tar_boost()
{
    fs=$1
    for run in 1 2 3 4 5 6 7 8
    do
        sudo rm -rf $pmem_dir/*
        sudo ./run_boost.sh $fs $run
        sleep 5
    done
}

:'
cd $setup_dir
sudo ./nova_config.sh
cd $current_dir
sudo $setup_dir/dax_config.sh
run_tar dax

cd $setup_dir
sudo ./nova_relaxed_config.sh
cd $current_dir
run_tar relaxed_nova

cd $setup_dir
sudo ./nova_config.sh
cd $current_dir
run_tar nova

cd $setup_dir
sudo $setup_dir/pmfs_config.sh
cd $current_dir
run_tar pmfs
'

cd $setup_dir
sudo ./nova_config.sh
cd $current_dir
sudo $setup_dir/dax_config.sh
run_tar_boost boost

sudo $setup_dir/dax_config.sh
run_tar_boost sync_boost

sudo $setup_dir/dax_config.sh
run_tar_boost posix_boost

