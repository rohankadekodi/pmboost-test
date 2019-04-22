#!/bin/bash

current_dir=$(pwd)
setup_dir=`readlink -f ..`
pmem_dir=/mnt/pmem_emul

run_ycsb_boost()
{
    fs=$1
    for run in soft1 soft2 soft3
    do
        sudo rm -rf $pmem_dir/*
        sudo ./run_boost.sh LoadA $fs $run
        sleep 5
        sudo ./run_boost.sh RunA $fs $run
        sleep 5
    done
}

sudo $setup_dir/dax_config.sh
run_ycsb_boost dax

:'
cd $setup_dir
sudo $setup_dir/pmfs_config.sh
cd $current_dir
run_ycsb_boost pmfs
'

cd $setup_dir
sudo $setup_dir/nova_config.sh
cd $current_dir
run_ycsb_boost nova

sudo $setup_dir/dax_config.sh
run_ycsb_boost boost

sudo $setup_dir/dax_config.sh
run_ycsb_boost sync_boost

sudo $setup_dir/dax_config.sh
run_ycsb_boost posix_boost
