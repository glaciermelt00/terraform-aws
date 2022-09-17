//--[ Subnet Setting ]----------------------------------------------------------
/**
 * Global Subnet
 */
resource aws_subnet global_1 {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = module.global_network.subnet_ips_glaciermelt["c_global"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "prod-sn-global-1"
  }
}

resource aws_subnet global_2 {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = module.global_network.subnet_ips_glaciermelt["a_global"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "prod-sn-global-2"
  }
}

resource aws_subnet global_3 {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = module.global_network.subnet_ips_glaciermelt["d_global"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "prod-sn-global-3"
  }
}

//--[ Subnet Setting ]----------------------------------------------------------
/**
 * Private Subnet
 */
resource aws_subnet private_1 {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = module.global_network.subnet_ips_glaciermelt["c_private"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "prod-sn-private-1"
  }
}

resource aws_subnet private_2 {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = module.global_network.subnet_ips_glaciermelt["a_private"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "prod-sn-private-2"
  }
}


resource aws_subnet private_3 {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = module.global_network.subnet_ips_glaciermelt["d_private"]
  availability_zone       = "ap-northeast-1d"
  map_public_ip_on_launch = false
  tags = {
    "Name" = "prod-sn-private-3"
  }
}
