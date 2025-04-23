variable "vpc_id" {
  description = "The ID of the requester's VPC"
  type        = string
}

variable "peer_vpc_id" {
  description = "The ID of the peer VPC"
  type        = string
}

variable "peer_region" {
  description = "The AWS region of the peer VPC"
  type        = string
}

variable "auto_accept" {
  description = "Whether to automatically accept the peering connection (only works if both VPCs are in the same account)"
  type        = bool
  default     = false
}

variable "vpc_route_table_id" {
  description = "Route table ID of the VPC to add peer CIDR route"
  type        = string
}

variable "peer_route_table_id" {
  description = "Route table ID of the peer VPC to add VPC CIDR route"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block of the requester's VPC"
  type        = string
}

variable "peer_vpc_cidr_block" {
  description = "CIDR block of the peer VPC"
  type        = string
}

variable "tags" {
  description = "Tags to apply to peering resources"
  type        = map(string)
  default     = {}
}
