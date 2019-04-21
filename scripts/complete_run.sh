#!/bin/bash

# Run TAR
cd ./tar
sudo ./run_tar.sh
cd ..

# Run git
cd ./git
sudo ./run_git.sh
cd ..

# Run rsync
cd ./rsync
sudo ./run_rsync.sh
cd ..

# Run TPCC
cd ./tpcc
sudo ./run_tpcc.sh
cd ..

# Run Redis
cd ./redis
sudo ./run_redis.sh
cd ..

# Run YCSB
cd ./ycsb
sudo ./run_ycsb.sh
cd ..
