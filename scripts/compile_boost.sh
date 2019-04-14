#!/bin/bash

set -x

boost_path=../boost-ycsb
root_path=$(pwd)/..

cd $boost_path
make clean
make

cd $root_path
