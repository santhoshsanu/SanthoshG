variable "family" {
    type = string
}

variable "container_name_1" {
    type = string
}

variable "container_name_2" {
    type = string
}

variable "container_image_1" {
    type = string
}

variable "container_image_2" {
    type = string
}

variable "cpu_1" {
    type = number
}

variable "cpu_2" {
    type = number
}

variable "memory_1" {
    type = number
}

variable "memory_2" {
    type = number
}

variable "cluster_name" {
    type = string 
}

variable "my_svc" {
  type = string
}


variable "desired_count" {
    type = number
  
}