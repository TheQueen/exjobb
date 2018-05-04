#!/bin/bash

echo "initializing PALLOC partitions..."

#echo 0x1ffc0 > /sys/kernel/debug/palloc/palloc_mask #6-16

echo 0xe000 > /sys/kernel/debug/palloc/palloc_mask
echo xor 13 16 > /sys/kernel/debug/palloc/control
echo xor 14 17 > /sys/kernel/debug/palloc/control
echo xor 15 18 > /sys/kernel/debug/palloc/control
echo 1 > /sys/kernel/debug/palloc/use_mc_xor
echo "bitmapping set"

#Four parts one for each core WRONG
mkdir /sys/fs/cgroup/cpuset/part1
mkdir /sys/fs/cgroup/cpuset/part2
mkdir /sys/fs/cgroup/cpuset/part3
mkdir /sys/fs/cgroup/cpuset/part4
mkdir /sys/fs/cgroup/cpuset/part5
mkdir /sys/fs/cgroup/cpuset/part6
mkdir /sys/fs/cgroup/cpuset/part7
mkdir /sys/fs/cgroup/cpuset/part8
echo "cgroup cpuset directories created"

cgcreate -g palloc:part1
cgcreate -g palloc:part2
cgcreate -g palloc:part3
cgcreate -g palloc:part4
cgcreate -g palloc:part5
cgcreate -g palloc:part6
cgcreate -g palloc:part7
cgcreate -g palloc:part8
echo "cgroups partition directories created"

echo 0 > /sys/fs/cgroup/palloc/part1/palloc.bins
echo 1 > /sys/fs/cgroup/palloc/part2/palloc.bins
echo 2 > /sys/fs/cgroup/palloc/part3/palloc.bins
echo 3 > /sys/fs/cgroup/palloc/part4/palloc.bins
echo 4 > /sys/fs/cgroup/palloc/part5/palloc.bins
echo 5 > /sys/fs/cgroup/palloc/part6/palloc.bins
echo 6 > /sys/fs/cgroup/palloc/part7/palloc.bins
echo 7 > /sys/fs/cgroup/palloc/part8/palloc.bins
echo "PALLOC bins set"

echo 0 > /sys/fs/cgroup/cpuset/part1/cpuset.cpus
echo 1 > /sys/fs/cgroup/cpuset/part2/cpuset.cpus
echo 2 > /sys/fs/cgroup/cpuset/part3/cpuset.cpus
echo 3 > /sys/fs/cgroup/cpuset/part4/cpuset.cpus
echo 0 > /sys/fs/cgroup/cpuset/part5/cpuset.cpus
echo 1 > /sys/fs/cgroup/cpuset/part6/cpuset.cpus
echo 2 > /sys/fs/cgroup/cpuset/part7/cpuset.cpus
echo 3 > /sys/fs/cgroup/cpuset/part8/cpuset.cpus
echo "cpusets set"

echo 0 > /sys/fs/cgroup/cpuset/part1/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/part2/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/part3/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/part4/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/part5/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/part6/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/part7/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/part8/cpuset.mems

#echo $1

echo $1 > /sys/fs/cgroup/palloc/part1/tasks
echo "palloc tasks set (task=$1)"

echo $1 > /sys/fs/cgroup/cpuset/part1/tasks
echo "cpuset tasks set too"
#copy the file with all tasks/PIDs from directory above and remove $1
#put copied file in part 2-8

# echo $$ > /sys/fs/cgroup/palloc/part2/tasks
# echo $$ > /sys/fs/cgroup/palloc/part3/tasks
# echo $$ > /sys/fs/cgroup/palloc/part4/tasks
#
# echo "palloc tasks are set"
#
# echo $$ > /sys/fs/cgroup/cpuset/part1/tasks
# echo $$ > /sys/fs/cgroup/cpuset/part2/tasks
# echo $$ > /sys/fs/cgroup/cpuset/part3/tasks
# echo $$ > /sys/fs/cgroup/cpuset/part4/tasks
#
# echo "CpuSet tasks are set"

echo 1 > /sys/kernel/debug/palloc/use_palloc
echo 2 > /sys/kernel/debug/palloc/debug_level


echo "PALLOC partitions initialized"
