module "ecs" {
  source            = "./Modules"
  family            = "my_task_def"
  container_name_1  = "nginx_container"
  container_name_2  = "httpd_container"
  container_image_1 = "nginx"
  container_image_2 = "httpd"
  cpu_1             = 256
  cpu_2             = 512
  my_svc            = "fisrt_service"
  desired_count     = 1
  cluster_name      = "ecs_cluster"
  memory_1          = 512
  memory_2          = 256
}