#!/bin/bash

current_dir=$(pwd)
setup_dir=`readlink -f ..`
pmem_dir=/mnt/pmem_emul

run_tpcc()
{
    fs=$1
    for run in 1
    do
        sudo rm -rf $pmem_dir/*
        sudo ./run_fs.sh $fs $run
        sleep 5
    done
}

run_tpcc_boost()
{
    for run in 1 2
    do
        sudo rm -rf $pmem_dir/*
        sudo ./run_boost.sh boost $run
        sleep 5
    done
}

sudo $setup_dir/dax_config.sh
run_tpcc dax

cd $setup_dir
sudo ./nova_config.sh
cd $current_dir
run_tpcc nova

cd $setup_dir
sudo $setup_dir/pmfs_config.sh
cd $current_dir
run_tpcc pmfs

sudo $setup_dir/dax_config.sh
run_tpcc_boost
