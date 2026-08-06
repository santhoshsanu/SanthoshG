provider "aws" {
    region = "us-east-1"
}
  


resource "aws_subnet" "pub" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = 
}


data "aws_ami" "ami" {
    most_recent = true

    filter {
        name = "name"
        values = ["al2023-ami-2023"]
    }
}



resource "aws_instance" "exmaple" {
  ami = "ami-xxxxxxx"
  instance_type = "t3.micro"

  tags = {
    created_by = "santhosh"
    env = "lab"

  }
}