# resource "aws_iam_role" "ecs_execution_role" {
#   name = "ecs-execution-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#         Effect = "Allow"
#         Sid    = ""
#       },
#     ]
#   })
# }

# # Attach the necessary policies to the execution role
# resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
#   role       = aws_iam_role.ecs_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"  # Allows ECS to pull from ECR
# }

# resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
#   role       = aws_iam_role.ecs_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"  # Allows ECS to push logs to CloudWatch
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
#   role       = aws_iam_role.ecs_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonECSTaskExecutionRolePolicy"  # Grants ECS task execution permissions
# }


resource "aws_ecs_task_definition" "task_def" {
    family = var.family
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = 1024
    memory                   = 2048
    # task_role_arn = 
    # execution_role_arn = aws_iam_role.ecs_execution_role.arn
    container_definitions = jsonencode([
        {
            name = var.container_name_1
            image = var.container_image_1
            cpu = var.cpu_1
            memory = var.memory_1
            essential = true
            portMappings = [
                {
                    containerPort = 80
                    hostPort      = 80
                }
            ]
        },
        {
            name = var.container_name_2
            image = var.container_image_2
            cpu = var.cpu_2
            memory = var.memory_2
            essential = true
            portMappings = [
                {
                    containerPort = 8080
                    hostPort      = 8080
                }
            ]
        }
    ])
}





resource "aws_ecs_cluster" "my_cluster" {
    name = var.cluster_name
}


data "aws_security_group" "ecs_security_grp" {
    id = var.security_group_id
}

data "aws_subnet" "selected" {
    id = var.subnet_id
}



resource "aws_ecs_service" "my_svc" {
    name = var.my_svc
    cluster = aws_ecs_cluster.my_cluster.id
    task_definition = aws_ecs_task_definition.task_def.arn
    desired_count = var.desired_count
    launch_type = "FARGATE"

    network_configuration {
      assign_public_ip = var.assign_public_ip
      security_groups = [var.security_group_id]
      subnets = [var.subnet_id]
    }

    depends_on = [ aws_ecs_task_definition.task_def ]

}

