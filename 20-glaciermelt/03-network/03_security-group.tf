/**
 * Default setting
 */
resource aws_security_group default0 {
  vpc_id      = aws_vpc.default.id
  name        = "default"
  description = "default VPC security group"
  tags = {
    Name = "default-prod"
  }
}

resource aws_security_group_rule default0-1 {
  security_group_id = aws_security_group.default0.id
  from_port         = 0
  protocol          = "-1"
  self              = true
  to_port           = 0
  type              = "ingress"
}

resource aws_security_group_rule default0-2 {
  security_group_id = aws_security_group.default0.id
  cidr_blocks       = [ "0.0.0.0/0" ]
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  type              = "egress"
}
