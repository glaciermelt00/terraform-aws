/**
 * Internet Gateway
 */
resource aws_internet_gateway default {
  vpc_id = aws_vpc.default.id
  tags   = {
    "Name" = "prod"
  }
}

/**
 * Network-NAT instance
 */
resource aws_instance nat1 {
  ami                         = "ami-fe9d4a81"
  availability_zone           = "ap-northeast-1c"
  ebs_optimized               = false
  instance_type               = "t2.nano"
  monitoring                  = false
  key_name                    = ""
  subnet_id                   = aws_subnet.global_1.id
  vpc_security_group_ids      = [ aws_security_group.default.id ]
  associate_public_ip_address = true
  disable_api_termination     = true
  source_dest_check           = false
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  tags = {
    "Name" = "nat1.glacirmelt.internal"
  }
}
