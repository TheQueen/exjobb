#!/bin/bash

echo "initializing PALLOC partitions..."
echo 0xe000 > /sys/kernel/debug/palloc/palloc_mask
echo xor 13 16 > /sys/kernel/debug/palloc/control
echo xor 14 17 > /sys/kernel/debug/palloc/control
echo xor 15 18 > /sys/kernel/debug/palloc/control
echo 1 > /sys/kernel/debug/palloc/use_mc_xor
echo "bitmapping set"

mkdir /sys/fs/cgroup/cpuset/part1
cgcreate -g palloc:part1
echo 0 > /sys/fs/cgroup/palloc/part1/palloc.bins
echo 0 > /sys/fs/cgroup/cpuset/part1/cpuset.cpus
echo 0 > /sys/fs/cgroup/cpuset/part1/cpuset.mems
echo $1 > /sys/fs/cgroup/palloc/part1/tasks
echo $1 > /sys/fs/cgroup/cpuset/part1/tasks


echo 1 > /sys/kernel/debug/palloc/use_palloc
echo 2 > /sys/kernel/debug/palloc/debug_level
echo "PALLOC partitions initialized"
