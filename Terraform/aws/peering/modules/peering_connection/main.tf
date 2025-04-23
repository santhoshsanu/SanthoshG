resource "aws_vpc_peering_connection" "this" {
  vpc_id        = var.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_region   = var.peer_region
  auto_accept   = var.auto_accept

  tags = merge({
    Name = "${var.tags["Name"]}-peering"
  }, var.tags)
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true

  tags = merge({
    Name = "${var.tags["Name"]}-accepter"
  }, var.tags)
}

resource "aws_route" "vpc_to_peer" {
  route_table_id            = var.vpc_route_table_id
  destination_cidr_block    = var.peer_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "peer_to_vpc" {
  provider                  = aws.peer
  route_table_id            = var.peer_route_table_id
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
