# terraform-aws-fargate-cpu-memory-values

This module has every variation of valid AWS FARGATE cpu/memory combinations used in Task Definitions. The module helps insulate developers from using the wrong combinations of CPU/memory or having to do math.

#### Supported task CPU and memory values for Fargate tasks are as follows.

| CPU value | Memory value (MiB) |
|---------------|-------------------------------------------------------------|
|256 (.25 vCPU)|512 (0.5GB), 1024 (1GB), 2048 (2GB)|
|512 (.5 vCPU)|1024 (1GB), 2048 (2GB), 3072 (3GB), 4096 (4GB)|
|1024 (1 vCPU)|2048 (2GB), 3072 (3GB), 4096 (4GB), 5120 (5GB), 6144 (6GB), 7168 (7GB), 8192 (8GB)|
|2048 (2 vCPU)|Between 4096 (4GB) and 16384 (16GB) in increments of 1024 (1GB)|
|4096 (4 vCPU)|Between 8192 (8GB) and 30720 (30GB) in increments of 1024 (1GB)|

#### Usage
```
module fargate_values {
  source = "github.com/dirt-simple/terraform-aws-fargate-cpu-memory-values"
}

resource aws_ecs_task_definition the_task {
  <snip>
  container_definitions = <<EOF
  [
    {
      "cpu": ${module.fargate_values.cpu_512},
      "memory": ${module.fargate_values.cpu_512-mem_1GB},
      <snip>
    }
  ]
EOF
}
```
