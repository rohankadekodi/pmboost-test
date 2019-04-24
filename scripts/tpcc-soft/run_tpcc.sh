#!/bin/bash

current_dir=$(pwd)
setup_dir=`readlink -f ..`
pmem_dir=/mnt/pmem_emul

run_tpcc_boost()
{
    fs=$1
    for run in 1
    do
        sudo rm -rf $pmem_dir/*
        sudo ./run_boost.sh $fs $run
        sleep 2
    done
}

:'
sudo $setup_dir/dax_config.sh
run_tpcc_boost dax

cd $setup_dir
sudo ./nova_relaxed_config.sh
cd $current_dir
run_tpcc_boost relaxed_nova

cd $setup_dir
sudo $setup_dir/pmfs_config.sh
cd $current_dir
run_tpcc_boost pmfs

cd $setup_dir
sudo ./nova_config.sh
cd $current_dir
run_tpcc_boost nova
'

sudo $setup_dir/dax_config.sh
run_tpcc_boost boost

sudo $setup_dir/dax_config.sh
run_tpcc_boost sync_boost

sudo $setup_dir/dax_config.sh
run_tpcc_boost posix_boost

