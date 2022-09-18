/**
 * VPC
 */
resource aws_vpc default {
  cidr_block           = module.global_network.vpc_ips.glaciermelt
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    "Name" = "prod"
  }
}

/*
 * service discovery
 */
resource aws_service_discovery_private_dns_namespace default {
  name        = "glaciermelt.internal"
  description = "glaciermelt"
  vpc         = aws_vpc.default.id
}
