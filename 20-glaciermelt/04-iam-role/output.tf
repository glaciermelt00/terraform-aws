output ec2_common {
  value = aws_iam_role.ec2_common.arn
}

output ec2_common_profile {
  value = aws_iam_instance_profile.ec2_common.name
}

output rds_monitoring {
  value = aws_iam_role.rds_monitoring.arn
}

output lambda {
  value = aws_iam_role.lambda.arn
}
