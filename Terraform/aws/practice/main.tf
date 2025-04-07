resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "main-tf"
  }

}

resource "aws_subnet" "data" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.data-cidr

  tags = {
    Name = "data"
  }
}

resource "aws_subnet" "business" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.business-cidr

  tags = {
    Name = "business"
  }
}


