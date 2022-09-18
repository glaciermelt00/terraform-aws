/*
 * Copyright SecondGame All Rights Reserved.
 *
 * For the full copyright and license information,
 * please view the LICENSE file that was distributed with this source code.
 */

terraform {
  required_version = ">= 0.12"

  # State Storage and Locking
  backend s3 {
    region         = "ap-northeast-1"
    bucket         = "terraform-498049530403.secondgame.net"
    key            = "db"
    dynamodb_table = "terraform_lock"
  }
}

module global_network {
  source = "../../modules/network/"
}

provider aws {
  version = "3.24.1"
  region  = "ap-northeast-1"
}

provider aws {
  alias  = "virginia"
  region = "us-east-1"
}

data aws_caller_identity self {
}
