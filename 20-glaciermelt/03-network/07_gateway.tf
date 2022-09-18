/**
 * Gateway instance
 */
resource aws_instance gateway1 {
  ami                         = "ami-0df99b3a8349462c6"
  availability_zone           = "ap-northeast-1c"
  ebs_optimized               = false
  instance_type               = "t2.nano"
  monitoring                  = false
  key_name                    = ""
  subnet_id                   = aws_subnet.global_1.id
  vpc_security_group_ids      = [ aws_security_group.default0.id ]
  iam_instance_profile        = data.terraform_remote_state.iam_role.outputs.ec2_common_profile
  associate_public_ip_address = true
  disable_api_termination     = true
  source_dest_check           = false
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  tags = {
    "Name" = "gs1.glacirmelt.internal"
  }
}
