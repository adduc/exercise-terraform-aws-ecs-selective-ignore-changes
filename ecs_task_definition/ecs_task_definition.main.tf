## Providers

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

## Input Variables

variable "ignored_keys" {
  type = list(string)
}

variable "ecs_task_definition" {
  type = object({
    container_definitions = string
    family                = string
  })
}

## Local Variables

locals {
  # filter out ignored keys
  filtered_container_definitions = [
    for container in jsondecode(var.ecs_task_definition.container_definitions) : {
      for k, v in container : k => v if !contains(var.ignored_keys, k)
    }
  ]
}

## Resources

resource "aws_ecs_task_definition" "task_definition" {
  family                = var.ecs_task_definition.family
  container_definitions = var.ecs_task_definition.container_definitions

  lifecycle {
    ignore_changes       = [container_definitions]
    replace_triggered_by = [null_resource.task_definition]
  }
}

#
resource "null_resource" "task_definition" {
  triggers = {
    container_definitions = jsonencode(local.filtered_container_definitions)
  }
}
