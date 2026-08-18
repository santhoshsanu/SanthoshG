output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.this.public_ip
}

output "public_dns" {
  description = "EC2 public DNS"
  value       = aws_instance.this.public_dns
}

output "private_ip" {
  description = "EC2 private IP"
  value       = aws_instance.this.private_ip
}

output "hostname" {
  description = "EC2 hostname"
  value       = aws_instance.this.public_dns
}

output "security_group_id" {
  description = "EC2 security group ID"
  value       = aws_security_group.this.id
}

output "key_name" {
  description = "Created key pair name"
  value       = aws_key_pair.this.key_name
}

output "private_key_file" {
  description = "Path to generated private key"
  value       = local_file.private_key.filename
}