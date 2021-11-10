#!/bin/bash
# -------- Cluster configuration in Instance -------- #
echo ECS_CLUSTER=${EcsClusterName} >> /etc/ecs/ecs.config
echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;
