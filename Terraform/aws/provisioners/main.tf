provider "aws" {
  region = "us-east-1"
}


# data "aws_vpc" "default" {
#     default = true
# }

# data "aws_subnet" "name" {
#     vpc_id = data.aws_vpc.default.id
    
# }

# data "aws_security_group" "default" {
#     vpc_id = data.aws_vpc.default.id
#     name = "default"
# }

resource "aws_key_pair" "key" {
  key_name   = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAmeMmUd3VWqdvfecpBB0I9vn/UR/7tBppeFiyjSJqI2J2rL13cnTlzCI5q/sw4p4yKcgEw6J6kGrgfMGVUq14rXCPUU9T/sjUwQ4BBilfUCdwqsHO+PPjDDyf3yzY/2bJWawGW5mabNgNCSKphQjXwHvxZmKAml0YEUgYZrKlS21l+1+wtiHrYioqhSNCHsCix1U4RO0lz5qkRCzAApzIRj3jQxBDYf34IRMSIDD1nsPtD3OqHqYNYp42HsoNVHItdxJt3roLn9PB2MwqR+BV9wfuzxUA5kJjVbYg+Q87W7OxUm8POKMdkkWqejDXNh7IjJu3cPicWCR31y/ggD/dH39fXfys8TK1sIMbTBQdbq2SkuG5wOrI46XQCZ1IiJ/fQJO+5aXAhp9PfzbKX7wbJec9K/4hpkSf23DGj598DUIqWixomIN0mHgnBSxDD99xaDO3V6RpfUUtw2I5WBx+H0aAssBbjI5Z7GkQaInYuAVCHIWvpx8PFRAD/YWc/Ds= sai@DESKTOP-J38G2UV"
}



resource "aws_instance" "test" {
  ami                    = "ami-084568db4383264d4"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name
#   subnet_id = data.aws_subnet.name.id
#   vpc_security_group_ids = [data.aws_security_group.default.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "file" {
    source      = "apache.sh"
    destination = "/tmp/apache.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y"
    ]
  }
}

output "aws_instance" {
    value = aws_instance.test.public_ip
 
}


# output "aws_instance" {
#     value = aws_instance.test.public_dns
  
# }
