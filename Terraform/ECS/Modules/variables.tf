variable "family" {
    type = string
}

variable "container_name_1" {
    type = string
    default = ""
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

variable "assign_public_ip" {
    type = bool
    default = false
}

variable "security_group_id" {
    type = string
    default = "sg-04226440229e90e52"
}

variable "subnet_id" {
    type = string
    default = "subnet-0bc593d3de0337225"
  
}