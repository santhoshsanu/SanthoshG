provider "aws" {
  alias  = "mumbai"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "oregon"
  region = "us-west-2"
}

module "mumbai_vpc" {
  source     = "./modules/vpc"
  providers  = { aws = aws.mumbai }
  cidr_block = "10.0.0.0/16"
  name       = "mumbai"
}

module "oregon_vpc" {
  source     = "./modules/vpc"
  providers  = { aws = aws.oregon }
  cidr_block = "10.1.0.0/16"
  name       = "oregon"
}

module "vpc_peering" {
  source = "./modules/vpc-peering"
  providers = {
    aws      = aws.mumbai
    aws.peer = aws.oregon
  }

  vpc_id              = module.mumbai_vpc.vpc_id
  peer_vpc_id         = module.oregon_vpc.vpc_id
  peer_region         = "us-west-2"
  auto_accept         = false

  vpc_route_table_id      = module.mumbai_vpc.private_route_table_id
  peer_route_table_id     = module.oregon_vpc.private_route_table_id

  vpc_cidr_block          = "10.0.0.0/16"
  peer_vpc_cidr_block     = "10.1.0.0/16"

  tags = {
    Name = "mumbai-oregon-peering"
  }
}
