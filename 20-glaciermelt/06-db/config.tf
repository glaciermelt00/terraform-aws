terraform {
  required_version = ">= 0.12, <= 0.13.6"

  # State Storage and Locking
  backend s3 {
    region         = "ap-northeast-1"
    bucket         = "terraform-814937260541.glaciermelt00"
    key            = "db"
    dynamodb_table = "terraform_lock"
    shared_credentials_file = "$HOME/.aws/credentials"
    profile                 = "glaciermelt00"
  }
}

module global_network {
  source = "../../modules/network/"
}

provider aws {
  version = "3.24.1"
  region  = "ap-northeast-1"
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "glaciermelt00"
}

provider aws {
  alias  = "virginia"
  region = "us-east-1"
}

data aws_caller_identity self {
}
