resource "aws_ecs_task_definition" "task_def" {
    family = var.family
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = 1024
    memory                   = 2048
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

resource "aws_ecs_service" "my_svc" {
    name = var.my_svc
    cluster = aws_ecs_cluster.my_cluster.id
    task_definition = aws_ecs_task_definition.task_def.arn
    desired_count = var.desired_count
}