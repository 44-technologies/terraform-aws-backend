
# First Create the Bucket with next features:
#   - Versioning
#   - Encryption

resource "aws_s3_bucket" "bucket_state" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_state_encryption" {
  bucket = aws_s3_bucket.bucket_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket_state_versioning" {
  bucket = aws_s3_bucket.bucket_state.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_public_access_block" "bucket_state_public_block" {
  bucket = aws_s3_bucket.bucket_state.id

  # Retroactively remove public access granted through public ACLs
  ignore_public_acls = true

  # Block new public ACLs and uploading public objects
  block_public_acls = true

  # Block new public bucket policies
  block_public_policy = true

  # Retroactivley block public and cross-account access if bucket has public policies
  restrict_public_buckets = true
}


# Lock Table
resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.bucket_lock_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
