variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"

}

# variable "subnet-count" {
#   type    = number
#   default = 3
# }

variable "subnet-names" {
  type    = list(string)
  default = ["yellow", "orange", "red"]
}