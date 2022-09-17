//--[ Network Routing ]---------------------------------------------------------
/**
 * Route table: Global layer
 */
resource aws_route_table rtb_global {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    "Name" = "prod-rtb-global"
  }
}
resource aws_route_table_association global_1 {
  subnet_id      = aws_subnet.global_1.id
  route_table_id = aws_route_table.rtb_global.id
}

resource aws_route_table_association global_2 {
  subnet_id      = aws_subnet.global_2.id
  route_table_id = aws_route_table.rtb_global.id
}

resource aws_route_table_association global_3 {
  subnet_id      = aws_subnet.global_3.id
  route_table_id = aws_route_table.rtb_global.id
}

//--[ Network Routing ]---------------------------------------------------------
/**
 * Route table: Private layer
 */
resource aws_route_table rtb_private {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat1.id
  }
  tags = {
    "Name" = "prod-rtb-private"
  }
}

resource aws_route_table_association rtb_private-1 {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.rtb_private.id
}

resource aws_route_table_association rtb_private-2 {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.rtb_private.id
}

resource aws_route_table_association rtb_private-3 {
  subnet_id      = aws_subnet.private_3.id
  route_table_id = aws_route_table.rtb_private.id
}
