terraform {
  required_version = ">= 0.12, <= 0.13.6"

  # State Storage and Locking
  backend s3 {
    region         = "ap-northeast-1"
    bucket         = "terraform-308890121156.secondgame.net"
    key            = "state"
    dynamodb_table = "terraform_lock"
    shared_credentials_file = "$HOME/.aws/credentials"
    profile                 = "glaciermelt00"
  }
}

provider aws {
  version = "3.24.1"
  region  = "ap-northeast-1"
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "glaciermelt00"
}

data aws_caller_identity self {
}
