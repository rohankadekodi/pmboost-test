Contents:

1.      boost-ycsb  - Our library.
2.      linux-4.13  - The kernel which has NOVA and on which we added system calls for boost-ycsb.
3.      kbuild      - Destination of compiled kernel 4.13.
4.      leveldb     - Workload which we will use to compare boost-ycsb with NOVA.
5.      scripts     - Directory containing all the shell scripts for compiling and running workload
6.      results     - Directory containing results of the workload run on boost-ycsb and NOVA

-----------------

Pre-requisites:

1.      Persistent Memory >= 24GB, mounted on /mnt/pmem_emul
2.      Boost library (sudo apt-get install libboost-dev on Ubuntu)
3.      LevelDB dependencies (cmake version >= 3.12)

-----------------

Build Steps:

1.      cd ./scripts/
2.      Compile Linux-4.13: sudo ./compile_kernel.sh
3.      Compile leveldb: ./compile_leveldb.sh (Refer to https://github.com/google/leveldb if compilation fails)
4.      Compile boost-ycsb: ./compile_boost.sh
5.      Reboot system

-----------------

Run Steps:

A.  Run boost-ycsb
    1.      Create ext4-DAX on /mnt/pmem_emul (sudo mkfs.ext4 -b 4096 /dev/pmemX /mnt/pmem_emul)
    2.      cd ./scripts/
    3.      sudo ./run_boost.sh <LoadA/RunA/RunB/RunC/RunF/RunD> (In that order)

B.  Run NOVA
    1.      install NOVA module: sudo insmod ./kbuild/fs/nova/nova.ko
    2.      Create NOVA on /mnt/pmem_emul (sudo mount -t NOVA -o init /dev/pmemX /mnt/pmem_emul)
    3.      cd ./scripts/
    4.      sudo ./run_nova.sh <LoadA/RunA/RunB/RunC/RunF/RunD> (In that order)

-----------------

In case of any difficulties, feel free to e-mail me at kadekodirohan@gmail.com

Thank you!
