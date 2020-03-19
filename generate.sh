#!/usr/bin/env bash

# docs: https:#docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html

function write_range_to_main_tf() {
  echo "output cpu_${1} { value = \"${1}\" }" >> main.tf

  # we can't write a decimal to the output name
  if [ $1 -eq 256 ]; then
    echo "output cpu_${1}-mem_halfGB { value = \"512\" }" >> main.tf
  fi

  for ((i=$2;i<=$3;)); do
    echo "output cpu_${1}-mem_$((i / 1024))GB { value = \"${i}\" }" >> main.tf
    i=$((i + 1024))
  done
  echo >> main.tf

}

echo "# 256 (.25 vCPU)	512 (0.5GB), 1024 (1GB), 2048 (2GB)" > main.tf
write_range_to_main_tf 256 1024 2048

echo "# 512 (.5 vCPU)	1024 (1GB), 2048 (2GB), 3072 (3GB), 4096 (4GB)" >> main.tf
write_range_to_main_tf 512 1024 4096

echo "# 1024 (1 vCPU)	2048 (2GB), 3072 (3GB), 4096 (4GB), 5120 (5GB), 6144 (6GB), 7168 (7GB), 8192 (8GB)" >> main.tf
write_range_to_main_tf 1024 2048 8192

echo "# 2048 (2 vCPU)	Between 4096 (4GB) and 16384 (16GB) in increments of 1024 (1GB)" >> main.tf
write_range_to_main_tf 2048 4096 16384

echo "# 4096 (4 vCPU)	Between 8192 (8GB) and 30720 (30GB) in increments of 1024 (1GB)" >> main.tf
write_range_to_main_tf 4096 8192 30720