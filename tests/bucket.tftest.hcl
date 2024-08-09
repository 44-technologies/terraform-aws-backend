# Call the setup module to create a random bucket prefix
run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

# Apply run block to create the bucket
run "create_bucket" {
  variables {
    bucket_name       = "${run.setup_tests.bucket_prefix}-aws-s3-backend-test"
    bucket_lock_table = "${run.setup_tests.bucket_prefix}-aws-s3-backend-lock"
  }

  # Check that the bucket name is correct
  assert {
    condition     = aws_s3_bucket.bucket_state.bucket == "${run.setup_tests.bucket_prefix}-aws-s3-backend-test"
    error_message = "Invalid bucket name"
  }

}

run "create_lock_table" {
  variables {
    bucket_name       = "${run.setup_tests.bucket_prefix}-aws-s3-backend-test"
    bucket_lock_table = "${run.setup_tests.bucket_prefix}-aws-s3-backend-lock"
  }

  # Check that the Lock Table name is correct
  assert {
    condition     = aws_dynamodb_table.terraform_lock.name == "${run.setup_tests.bucket_prefix}-aws-s3-backend-lock"
    error_message = "Invalid Lock Table"
  }

}

