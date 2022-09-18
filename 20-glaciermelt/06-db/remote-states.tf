/*
 * Copyright SecondGame All Rights Reserved.
 *
 * For the full copyright and license information,
 * please view the LICENSE file that was distributed with this source code.
 */

data terraform_remote_state domain {
  backend = "s3"
  config  = {
    bucket  = "terraform-498049530403.secondgame.net"
    region  = "ap-northeast-1"
    key     = "domain"
  }
}

data terraform_remote_state network {
  backend = "s3"
  config  = {
    bucket  = "terraform-498049530403.secondgame.net"
    region  = "ap-northeast-1"
    key     = "network"
  }
}

data terraform_remote_state iam_role {
  backend = "s3"
  config  = {
    bucket  = "terraform-498049530403.secondgame.net"
    region  = "ap-northeast-1"
    key     = "iam-role"
  }
}
