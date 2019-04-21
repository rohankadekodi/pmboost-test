#!/bin/bash

set -x

current_dir=$(pwd)

boost_ycsb=../boost-ycsb
boost_ycsb_posix=../boost-ycsb-posix
boost_ycsb_sync=../boost-ycsb-sync

boost_tpcc=../boost-tpcc
boost_tpcc_posix=../boost-tpcc-posix
boost_tpcc_sync=../boost-tpcc-sync

boost_redis=../boost-redis
boost_redis_posix=../boost-redis-posix
boost_redis_sync=../boost-redis-sync

boost_tar=../boost-tar
boost_tar_posix=../boost-tar-posix
boost_tar_sync=../boost-tar-sync

boost_git=../boost-git
boost_git_posix=../boost-git-posix
boost_git_sync=../boost-git-sync

boost_rsync=../boost-rsync
boost_rsync_posix=../boost-rsync-posix
boost_rsync_sync=../boost-rsync-sync

for boost in $boost_ycsb $boost_ycsb_posix $boost_ycsb_sync $boost_tpcc $boost_tpcc_posix $boost_tpcc_sync $boost_redis $boost_redis_posix $boost_redis_sync $boost_tar $boost_tar_posix $boost_tar_sync $boost_git $boost_git_posix $boost_git_sync $boost_rsync $boost_rsync_posix $boost_rsync_sync
do
    cd $boost
    make clean
    make -j4 
    cd $current_dir
done

