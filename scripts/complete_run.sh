#!/bin/bash

# Run YCSB
cd ./ycsb
sudo ./run_ycsb.sh
cd ..

# Run TPCC
cd ./tpcc
sudo ./run_tpcc.sh
cd ..

# Run Redis
cd ./redis
sudo ./run_redis.sh
cd ..

# Run software overhead
cd ./ycsb-soft
sudo ./run_ycsb.sh
cd ..
