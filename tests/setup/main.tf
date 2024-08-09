

resource "random_pet" "bucket_prefix" {
  length = 4
}

output "bucket_prefix" {
  value = random_pet.bucket_prefix.id
}