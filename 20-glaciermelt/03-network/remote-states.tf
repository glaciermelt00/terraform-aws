data terraform_remote_state iam_role {
  backend   = "s3"
  workspace = "glaciermelt00"
  config    = {
    bucket  = "terraform-814937260541.glaciermelt00"
    region  = "ap-northeast-1"
    key     = "iam-role"
  }
}
