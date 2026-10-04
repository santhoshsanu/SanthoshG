# ec2

Creates an AWS EC2 instance running the latest Ubuntu LTS AMI with Apache2
installed and started via cloud-init user data. The AMI is resolved dynamically
at plan time from Canonical's official images so you always get the most recent
patch without changing any variables.

## Usage

### Minimal

```hcl
module "web" {
  source = "../ec2"

  product     = "atlas"
  service     = "web"
  environment = "dev"
  subnet_id   = "subnet-0abc123456789"
}
```

### With security group and key pair

```hcl
module "web" {
  source = "../ec2"

  product     = "atlas"
  service     = "web"
  environment = "prod"
  subnet_id   = var.subnet_id

  instance_type                = "t3.small"
  key_name                     = "my-keypair"
  vpc_security_group_ids       = [module.sg_web.security_group_id]
  associate_public_ip_address  = true

  root_volume_size             = 30
  root_volume_encrypted        = true
  root_volume_kms_key_id       = module.kms.key_arn

  tags = {
    Team = "platform"
  }
}
```

### With extra userdata (e.g. install additional packages)

```hcl
module "web" {
  source = "../ec2"

  product     = "atlas"
  service     = "web"
  environment = "dev"
  subnet_id   = var.subnet_id

  extra_userdata = <<-EOT
    apt-get install -y php libapache2-mod-php
    systemctl restart apache2
  EOT
}
```

### Pin a specific Ubuntu version

```hcl
module "web" {
  source = "../ec2"

  product        = "atlas"
  service        = "web"
  environment    = "dev"
  subnet_id      = var.subnet_id
  ubuntu_version = "22.04"   # default is 24.04
}
```

## Key Inputs

| Name | Description | Default |
| --- | --- | --- |
| `product` | Product name for naming / tagging | _required_ |
| `service` | Service name for naming / tagging | _required_ |
| `environment` | Environment (e.g. dev, staging, prod) | _required_ |
| `subnet_id` | Subnet to launch the instance in | _required_ |
| `ubuntu_version` | Ubuntu LTS version (`20.04`, `22.04`, `24.04`) | `"24.04"` |
| `ami_id` | Explicit AMI override; skips dynamic lookup when set | `""` |
| `instance_type` | EC2 instance type | `"t3.micro"` |
| `key_name` | EC2 key pair name for SSH access | `""` |
| `vpc_security_group_ids` | Security group IDs to attach | `[]` |
| `associate_public_ip_address` | Assign a public IP | `false` |
| `iam_instance_profile` | IAM instance profile name to attach | `""` |
| `root_volume_size` | Root EBS volume size in GiB | `20` |
| `root_volume_type` | Root EBS volume type (`gp3`, `gp2`, `io1`, `io2`) | `"gp3"` |
| `root_volume_encrypted` | Encrypt the root volume | `true` |
| `root_volume_kms_key_id` | KMS key for root volume encryption | `""` |
| `extra_userdata` | Extra shell commands appended after Apache2 setup | `""` |
| `monitoring` | Enable detailed CloudWatch monitoring | `false` |
| `disable_api_termination` | Enable termination protection | `false` |
| `tags` | Additional tags to merge onto all resources | `{}` |

## Outputs

| Name | Description |
| --- | --- |
| `instance_id` | ID of the EC2 instance |
| `instance_arn` | ARN of the EC2 instance |
| `instance_state` | Current state of the instance |
| `private_ip` | Private IP address |
| `public_ip` | Public IP address (empty when none assigned) |
| `private_dns` | Private DNS name |
| `public_dns` | Public DNS name (empty when none assigned) |
| `ami_id` | Resolved AMI ID used to launch the instance |
| `ami_name` | Name of the dynamically resolved Ubuntu AMI |
| `subnet_id` | Subnet the instance was launched in |
| `vpc_id` | VPC derived from the subnet |

## Notes

- **AMI stability** — `ignore_changes = [ami]` is set by default so routine
  `terraform apply` runs do not replace the instance when a newer Ubuntu image
  is published. Remove that `ignore_changes` line if you want rolling AMI
  updates on every apply.
- **Ubuntu AMI owner** — Canonical's official owner ID is `099720109477`. This
  is hardcoded in the data source so no manual lookup is required.
- **User data** — Apache2 is installed via `apt-get`, enabled with `systemctl`,
  and a minimal HTML page is written to `/var/www/html/index.html`. Use
  `extra_userdata` to append any additional setup without forking the module.
- **Root volume** — encrypted with `gp3` by default. Pass `root_volume_kms_key_id`
  to use a customer-managed KMS key (e.g. from the `kms` module).
