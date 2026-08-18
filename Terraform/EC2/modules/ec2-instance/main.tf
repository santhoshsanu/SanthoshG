# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get a subnet from the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Fetch latest Ubuntu 22.04 AMI
data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

# Generate SSH private/public key
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair using generated public key
resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh

  tags = {
    Name = var.key_name
  }
}

# Save private key locally
resource "local_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${path.root}/${var.key_name}.pem"
  file_permission = "0400"
}

# Security Group
resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "Security group for Ubuntu EC2"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    # For testing only
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

# EC2 Instance
resource "aws_instance" "this" {
  ami           = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type = var.instance_type

  subnet_id = data.aws_subnets.default.ids[0]

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  key_name = aws_key_pair.this.key_name

  user_data = <<-EOF
              #!/bin/bash

              apt-get update -y
              apt-get install -y apache2

              systemctl enable apache2
              systemctl start apache2

              echo "Hello from Terraform!" > /var/www/html/index.html
              echo "Hostname: $(hostname)" >> /var/www/html/index.html
              echo "Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)" >> /var/www/html/index.html
              EOF

  tags = {
    Name = var.name
  }
}