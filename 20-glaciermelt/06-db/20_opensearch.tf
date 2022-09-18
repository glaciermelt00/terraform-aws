resource aws_elasticsearch_domain opensearch {
  domain_name           = "glaciermelt-opensearch"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type          = "t3.small.elasticsearch"
    zone_awareness_enabled = false
    instance_count         = 1
  }

  vpc_options {
    subnet_ids = [
      data.terraform_remote_state.network.outputs.subnet_private_1
    ]
    security_group_ids = [
      data.terraform_remote_state.network.outputs.security_group_www,
      data.terraform_remote_state.network.outputs.security_group_default
    ]
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  log_publishing_options {
    cloudwatch_log_group_arn = "${aws_cloudwatch_log_group.opensearch.arn}:*"
    log_type                 = "INDEX_SLOW_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = "${aws_cloudwatch_log_group.opensearch.arn}:*"
    log_type                 = "SEARCH_SLOW_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = "${aws_cloudwatch_log_group.opensearch.arn}:*"
    log_type                 = "ES_APPLICATION_LOGS"
  }

  snapshot_options {
    automated_snapshot_start_hour = 19
  }

  access_policies = data.aws_iam_policy_document.opensearch.json
}

data aws_iam_policy_document opensearch {
  statement {
    effect  =   "Allow"
    actions = [ "es:*" ]
    principals {
      type        = "AWS"
      identifiers = [
        "*"
      ]
    }
    resources = [
      "arn:aws:es:ap-northeast-1:${data.aws_caller_identity.self.account_id}:domain/glaciermelt-opensearch/*"
    ]
  }
}

resource aws_iam_service_linked_role opensearch {
  aws_service_name = "es.amazonaws.com"
}

resource aws_cloudwatch_log_group opensearch {
  name = "/ecs/glaciermtl-opensearch"
}
