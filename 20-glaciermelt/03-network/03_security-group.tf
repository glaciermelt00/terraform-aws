/**
 * Default setting
 */
resource aws_security_group default {
  vpc_id      = aws_vpc.default.id
  name        = "default"
  description = "default VPC security group"
  tags = {
    Name = "default-prod"
  }
}

resource aws_security_group_rule default-1 {
  security_group_id = aws_security_group.default.id
  from_port         = 0
  protocol          = "-1"
  self              = true
  to_port           = 0
  type              = "ingress"
}

resource aws_security_group_rule default-2 {
  security_group_id = aws_security_group.default.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  type              = "egress"
}

/**
 * For load balancer
 */
resource aws_security_group www {
  vpc_id      = aws_vpc.default.id
  name        = "www"
  description = "Network load balancer"
}

resource aws_security_group_rule www-1 {
  security_group_id = aws_security_group.www.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [ "0.0.0.0/0" ]
}

resource aws_security_group_rule www-2 {
  security_group_id = aws_security_group.www.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [ "0.0.0.0/0" ]
}
