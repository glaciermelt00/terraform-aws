output vpc {
  value = aws_vpc.default.id
}

output internal_dns_ns {
  value = aws_service_discovery_private_dns_namespace.default.id
}

output subnet_global_1 {
  value = aws_subnet.global_1.id
}

output subnet_global_2 {
  value = aws_subnet.global_2.id
}

output subnet_global_3 {
  value = aws_subnet.global_3.id
}

output subnet_private_1 {
  value = aws_subnet.private_1.id
}

output subnet_private_2 {
  value = aws_subnet.private_2.id
}

output subnet_private_3 {
  value = aws_subnet.private_3.id
}

//-- [ Security Group ] --------------------------------------------------------
output security_group_default {
  value = aws_security_group.default.id
}

