terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "ecs_task_definition" {
  source = "./ecs_task_definition"

  ignored_keys = ["image"]

  ecs_task_definition = {
    family = "example-task"

    container_definitions = jsonencode([
      {
        name      = "first-container"
        image     = "nginx"
        cpu       = 512
        memory    = 1024
        essential = true
        portMappings = [{
          containerPort = 80
          hostPort      = 80
        }]
      }
    ])
  }
}