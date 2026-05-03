# Call the setup module to create a random bucket prefix
run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}


mock_provider "aws" {
  alias = "fake"
}


# Apply run block to create the bucket
run "create_bucket" {
  variables {
    bucket_name       = "${run.setup_tests.bucket_prefix}-aws-s3-backend-test"
  }

  # Check that the bucket name is correct
  assert {
    condition     = aws_s3_bucket.bucket_state.bucket == "${run.setup_tests.bucket_prefix}-aws-s3-backend-test"
    error_message = "Invalid bucket name"
  }

  providers = {
    aws.backend = aws.fake
  }

}

