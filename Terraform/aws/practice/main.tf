resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "main-tf"
  }

}

resource "aws_subnet" "subnets" {
  count      = length(var.subnet-names)
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"


  tags = {
    Name = "subnet ${count.index}"
  }
}