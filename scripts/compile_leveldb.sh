#!/bin/bash

set -x

leveldb_path=`readlink -f ../leveldb`
leveldb_build_path=$leveldb_path/build
workload_path=$leveldb_path/ycsb_workloads
root_path=$(pwd)/..

cd $leveldb_build_path
cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build .

cd $workload_path
tar -xf loada_5M.tar.gz
tar -xf runa_5M_5M.tar.gz

cd $root_path
