# Terraform Exercise: Selectively ignoring changes to ECS task definitions

This repository shows how terraform can be written to selectively ignore
changes to an ECS task definition. This is useful in situations where
parts of the ECS task definition may be updated outside of Terraform
(e.g. when switching to an image with a different tag during a
deployment).

## Permissions

This exercise was developed and tested using the following IAM Policy:


```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowECS",
            "Effect": "Allow",
            "Action": [
                "ecs:RegisterTaskDefinition",
                "ecs:DescribeTaskDefinition",
                "ecs:DeregisterTaskDefinition"
            ],
            "Resource": "*"
        }
    ]
}
```