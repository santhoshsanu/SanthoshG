# ============================================================================
# EC2 Module - Ubuntu + Apache2
# Dynamically resolves the latest Ubuntu LTS AMI (Canonical owner).
# Apache2 is installed and started via cloud-init user data.
# ============================================================================

# --- Data Sources ------------------------------------------------------------

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

# Resolve the latest Ubuntu AMI published by Canonical (owner: 099720109477)
# The name filter matches the official Canonical naming scheme:
#   ubuntu/images/hvm-ssd/ubuntu-<codename>-<version>-amd64-server-*
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-*-${var.ubuntu_version}-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# --- Locals ------------------------------------------------------------------

locals {
  instance_name = var.name != "" ? var.name : "${var.product}-${var.service}-${var.environment}"

  # Use explicit AMI if provided, otherwise fall back to dynamic lookup
  resolved_ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.ubuntu.id

  # Standard tags applied to every resource
  common_tags = merge(
    {
      Product     = var.product
      Service     = "${var.product}:${var.service}:ec2"
      Environment = var.environment
      ManagedBy   = "terraform"
      Module      = "ec2"
    },
    var.tags
  )

  # cloud-init user data — installs Apache2, enables it at boot, writes a
  # simple index page, then appends any caller-supplied extra commands
  userdata = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    # ── System update ────────────────────────────────────────────────────────
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -y
    apt-get upgrade -y

    # ── Apache2 installation ─────────────────────────────────────────────────
    apt-get install -y apache2

    # Enable and start the service
    systemctl enable apache2
    systemctl start apache2

    # Default index page
    cat > /var/www/html/index.html <<HTML
    <!DOCTYPE html>
    <html>
      <head><title>${local.instance_name}</title></head>
      <body>
        <h1>${local.instance_name}</h1>
        <p>Environment : ${var.environment}</p>
        <p>Managed by  : Terraform</p>
      </body>
    </html>
    HTML

    ${var.extra_userdata}
  EOF
}

# --- EC2 Instance ------------------------------------------------------------

resource "aws_instance" "this" {
  ami                         = local.resolved_ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name != "" ? var.key_name : null
  iam_instance_profile        = var.iam_instance_profile != "" ? var.iam_instance_profile : null
  user_data                   = base64encode(local.userdata)
  monitoring                  = var.monitoring
  disable_api_termination     = var.disable_api_termination

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    encrypted             = var.root_volume_encrypted
    kms_key_id            = var.root_volume_kms_key_id != "" ? var.root_volume_kms_key_id : null
    delete_on_termination = true

    tags = merge(local.common_tags, {
      Name = "${local.instance_name}-root"
    })
  }

  # Replacing the AMI (e.g. new Ubuntu release) should create the new instance
  # before destroying the old one to minimise downtime
  lifecycle {
    create_before_destroy = true
    # Prevent unintended replacements triggered solely by a new AMI release.
    # Remove this ignore if you want rolling AMI updates on every apply.
    ignore_changes = [ami]
  }

  tags = merge(local.common_tags, {
    Name = local.instance_name
  })
}
