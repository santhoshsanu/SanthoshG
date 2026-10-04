# ============================================================================
# EC2 Module - Outputs
# ============================================================================

# --- Instance ----------------------------------------------------------------

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.this.arn
}

output "instance_state" {
  description = "Current state of the EC2 instance"
  value       = aws_instance.this.instance_state
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IP address of the EC2 instance (empty string when associate_public_ip_address is false)"
  value       = aws_instance.this.public_ip
}

output "private_dns" {
  description = "Private DNS name of the EC2 instance"
  value       = aws_instance.this.private_dns
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance (empty string when no public IP is assigned)"
  value       = aws_instance.this.public_dns
}

# --- AMI ---------------------------------------------------------------------

output "ami_id" {
  description = "AMI ID used to launch the instance (resolved from lookup or explicit override)"
  value       = local.resolved_ami_id
}

output "ami_name" {
  description = "Name of the Ubuntu AMI resolved by the data source (empty when ami_id override is used)"
  value       = var.ami_id == "" ? data.aws_ami.ubuntu.name : ""
}

# --- Network -----------------------------------------------------------------

output "subnet_id" {
  description = "Subnet ID the instance was launched in"
  value       = aws_instance.this.subnet_id
}

output "vpc_id" {
  description = "VPC ID derived from the subnet"
  value       = aws_instance.this.vpc_id
}
