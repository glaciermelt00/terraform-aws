/**
 * RDS Cluster
 */
resource aws_rds_cluster main {
  cluster_identifier              = "main"
  engine                          = "aurora-mysql"
  engine_version                  = "5.7.mysql_aurora.2.07.3"
  database_name                   = "glaciermelt"
  master_username                 = "glaciermelt00"
  master_password                 = "WNHRUEL4QS6D"
  backup_retention_period         = 35
  backtrack_window                = 259200
  preferred_backup_window         = "16:10-16:40"
  preferred_maintenance_window    = "sun:17:10-sun:17:40"
  enabled_cloudwatch_logs_exports = [ "audit", "error", "slowquery" ]
  storage_encrypted               = true
  deletion_protection             = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.main.name
  db_subnet_group_name            = aws_db_subnet_group.subnet_group_stg.name
  vpc_security_group_ids          = [
    data.terraform_remote_state.network.outputs.security_group_default
  ]
  lifecycle {
    ignore_changes = [
      database_name,
      master_password
    ]
  }
}

/**
 * RDS Cluster: Subnet
 */
resource aws_db_subnet_group subnet_group_stg {
  name       = "rds-main"
  subnet_ids = [
    data.terraform_remote_state.network.outputs.subnet_private_1,
    data.terraform_remote_state.network.outputs.subnet_private_2,
    data.terraform_remote_state.network.outputs.subnet_private_3
  ]
}

/**
 * RDS Cluster: Instance
 */
resource aws_rds_cluster_instance main {
  count                      = 2
  instance_class             = "db.t3.small"
  identifier                 = "rds-aurora-main-${count.index}"
  cluster_identifier         = aws_rds_cluster.main.id
  engine                     = aws_rds_cluster.main.engine
  engine_version             = aws_rds_cluster.main.engine_version
  db_parameter_group_name    = aws_db_parameter_group.main.name
  auto_minor_version_upgrade = false
  monitoring_interval        = 60
  monitoring_role_arn        = data.terraform_remote_state.iam_role.outputs.rds_monitoring
}

/**
 * RDS Parameter Group: For database
 */
resource aws_db_parameter_group main {
  name        = "rds-main"
  family      = "aurora-mysql5.7"
  description = "RDS default DB parameter group"
  parameter {
    name  = "max_connections"
    value = 1024
  }
}

/**
 * RDS Parameter Group: For cluster
 */
resource aws_rds_cluster_parameter_group main {
  name        = "rds-main"
  family      = "aurora-mysql5.7"
  description = "RDS default cluster parameter group"
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }
  parameter {
    name  = "collation_connection"
    value = "utf8mb4_general_ci"
  }
  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }
  parameter {
    name  = "general_log"
    value = 0
  }
  parameter {
    name  = "slow_query_log"
    value = 1
  }
  parameter {
    name  = "log_output"
    value = "file"
  }
  parameter {
    name  = "server_audit_events"
    value = "connect,query,query_dcl,query_ddl,query_dml,table"
  }
  parameter {
    name  = "server_audit_logging"
    value = "1"
  }
  parameter {
    name  = "server_audit_logs_upload"
    value = "1"
  }
}
