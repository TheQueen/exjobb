 #!/bin/bash

mkdir /sys/fs/cgroup/cpuset/part$2
#echo "cgroup cpuset directories created"

cgcreate -g palloc:part$2
# echo "cgroups partition directories created"

#MÅSTE FIXA SÄTT ATT HÅLLA KOLL PÅ BINS!
#echo 0-1 > /sys/fs/cgroup/palloc/part$2/palloc.bins
#echo "PALLOC bins set"
echo "ERROR dont know how to decide bins to put in palloc.bins"
echo "Therefore not set"

#MÅSTE FIXA SÄTT ATT HÅLLA KOLL PÅ VILKEN CPU SOM SKA KÖRA!
#echo 0 > /sys/fs/cgroup/cpuset/part$2/cpuset.cpus
# echo "cpusets set"
echo "ERROR dont know how to decide cpu to put in cpuset.cpus!"
echo "Therefore not set"

echo 0 > /sys/fs/cgroup/cpuset/part$2/cpuset.mems
# echo "cpuset.mems set to 0"
#
echo $1 > /sys/fs/cgroup/palloc/part$2/tasks
# #echo "palloc tasks set (task=$1)"
#
echo $1 > /sys/fs/cgroup/cpuset/part$2/tasks
# echo "cpuset tasks set too"
