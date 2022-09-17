/**
 * [ Terraform Locking ]
 *  DynamoDB can be used as a locking mechanism
 *  to remote storage backend S3 to store state files.
 *  The DynamoDB table is keyed on “LockID” which is set as a bucketName/path,
 *  so as long as we have a unique combination of this we don’t have any problem
 *  in acquiring locks and running everything in a safe way.
 */
resource aws_dynamodb_table terraform_lock {
  name           = "terraform_lock"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1
  attribute {
    name = "LockID"
    type = "S"
  }
}
