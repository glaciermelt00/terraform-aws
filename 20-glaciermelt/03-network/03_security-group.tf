/**
 * Default setting
 */
resource aws_security_group default {
  vpc_id      = aws_vpc.default.id
  name        = "default0"
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
