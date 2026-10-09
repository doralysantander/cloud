resource "aws_s3_bucket" "cerberus_bcket" {
    bucket = local.s3-sufix
}