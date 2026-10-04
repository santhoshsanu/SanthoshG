# ============================================================================
# EC2 Module - Variables
# ============================================================================

# --- AWS Provider ------------------------------------------------------------

variable "aws_region" {
  description = "AWS region where the EC2 instance will be created"
  type        = string
  default     = "us-east-1"
}

# --- Identity / Naming -------------------------------------------------------

variable "product" {
  description = "Product name used for naming and tagging (e.g. atlas)"
  type        = string
}

variable "service" {
  description = "Service name used for naming and tagging (e.g. web, api)"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
}

variable "name" {
  description = "Override the auto-generated instance name. Defaults to '{product}-{service}-{environment}' when empty"
  type        = string
  default     = ""
}

# --- AMI ---------------------------------------------------------------------

variable "ubuntu_version" {
  description = "Ubuntu LTS version to use. Controls the AMI filter (e.g. '22.04', '24.04')"
  type        = string
  default     = "24.04"

  validation {
    condition     = contains(["20.04", "22.04", "24.04"], var.ubuntu_version)
    error_message = "ubuntu_version must be one of: 20.04, 22.04, 24.04."
  }
}

variable "ami_id" {
  description = "Explicit AMI ID to use. When set, overrides the dynamic Ubuntu AMI lookup"
  type        = string
  default     = ""
}

# --- Instance ----------------------------------------------------------------

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair to attach. Leave empty for no SSH key"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID in which to launch the instance"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to attach to the instance"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "Name of an existing IAM instance profile to attach. Leave empty to skip"
  type        = string
  default     = ""
}

# --- Storage -----------------------------------------------------------------

variable "root_volume_size" {
  description = "Size of the root EBS volume in GiB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "EBS volume type for the root device (gp3, gp2, io1, io2)"
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2"], var.root_volume_type)
    error_message = "root_volume_type must be one of: gp2, gp3, io1, io2."
  }
}

variable "root_volume_encrypted" {
  description = "Whether to encrypt the root EBS volume"
  type        = bool
  default     = true
}

variable "root_volume_kms_key_id" {
  description = "KMS key ID/ARN used to encrypt the root volume. Uses AWS-managed key when empty"
  type        = string
  default     = ""
}

# --- User Data ---------------------------------------------------------------

variable "extra_userdata" {
  description = "Additional shell commands to append after the Apache2 installation block"
  type        = string
  default     = ""
}

# --- Monitoring / Termination ------------------------------------------------

variable "monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "Enable termination protection on the instance"
  type        = bool
  default     = false
}

# --- Tagging -----------------------------------------------------------------

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
