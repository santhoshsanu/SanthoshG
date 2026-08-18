output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "ec2_public_dns" {
  value = module.ec2.public_dns
}

output "ec2_private_ip" {
  value = module.ec2.private_ip
}

output "ec2_key_name" {
  value = module.ec2.key_name
}

output "ec2_private_key_file" {
  value = module.ec2.private_key_file
}